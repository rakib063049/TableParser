module TableScript

  class HtmlTable

    def initialize
      @html = <<-EOS
        <table border="1">
         <thead>
            <tr>
              <th>Blue</th>
              <th>Black</th>
              <th>Pink</th>
              <th>Red</th>
              <th>Green</th>
              <th>White</th>
              <th>Grey</th>
              <th>Purple</th>
              <th>Yellow</th>
              </tr>
          </thead>"
          <tbody>
          <tr>
            <td rowspan="13"><i>Main Data</i></td>
            <td rowspan="3">Data A</td>
            <td rowspan="10"> </td>
            <td rowspan="3"><i>Data b</i></td>
            <td><i>Data c</i></td>
            <td><i>Data d</i></td>
            <td>Data e</td>
            <td rowspan="7">Data r1</td>
            <td rowspan="7">Data g</td>
          </tr>
          <tr>
            <td><i>Data w</i></td>
            <td></td>
            <td rowspan="2">Data k</td>
          </tr>
          <tr>
            <td><i>Data n</i></td>
            <td><i>Data p</i><br><i>Data h</i>
            </td>
          </tr>
          <tr>
            <td>Data o</td>
            <td>Data i</td>
            <td><i>Data u</i></td>
            <td><i>Data y</i></td>
            <td rowspan="4">Data t</td>
          </tr>
          <tr>
            <td rowspan="6">Data r2</td>
            <td><i>Data e</i></td>
            <td><i>Data w</i></td>
            <td><i>Data qq</i></td>
          </tr>
          <tr>
            <td><i>Data zz</i></td>
            <td><i>Data xx</i></td>
            <td><i>Data cc</i></td>
          </tr>
          <tr>
            <td><i>Data vv</i></td>
            <td><i>Data bb</i></td>
            <td><i>Data nn</i></td>
          </tr>
          <tr>
            <td rowspan="2"><i>Data zzd</i></td>
            <td><i>Data gg</i></td>
            <td rowspan="2"><i>Data hh</i></td>
            <td><span class="ipinfo">Data pp</td>
            <td rowspan="3">Data cll</td>
            <td></td>
          </tr>
          <tr>
            <td><i>Data cwxwx</i></td>
            <td>Data qatyh</td>
            <td rowspan="2">Data djdj</td>
          </tr>
          <tr>
            <td><i>Data yhn</i></td>
            <td><i>Data rfvc</i></td>
            <td><i>Data yui</i></td>
            <td>Data rty</td>
          </tr>
          <tr>
            <td rowspan="3">Data edc</td>
            <td rowspan="3">Data xyw</td>
            <td><i>Data zxc</i></td>
            <td><i>Data xcv</i></td>
            <td><i>Data yui</i></td>
            <td>Data ryt</td>
            <td rowspan="3">Data cwer</td>
            <td rowspan="3">Data asd</td>
          </tr>
          <tr>
            <td><i>Data dfg</i></td>
            <td><i>Data fgf</i></td>
            <td><i>Data kkhk</i></td>
            <td>Data jjj</td>
          </tr>
          <tr>
            <td><i>Data yyy</i></td>
            <td><i>Data tt</i></td>
            <td><i>Data ff</i></td>
            <td>Data vv</td>
          </tr>
          </tbody>
        </table>
      EOS

    end

    def scrap_table
      data = {}
      doc = Nokogiri::HTML(@html)
      rows = doc.xpath('//table/tbody/tr')
      details = rows.collect do |row|
        row.xpath('./td').map do |col|
          data.merge({text: col.text, rowspan: col.attr("rowspan").to_i})
        end
      end
      return details
    end


    def scrap_table_header(options={})
      data = {}
      doc = Nokogiri::HTML(@html)
      rows = doc.xpath('//table/thead/tr')
      details = rows.collect do |row|
        row.xpath('./th').map do |col|
          data.merge({text: col.text})
        end
      end
      details = delete_column(details, options[:delete_column]) if options[:delete_column].present?
      return details
    end


    def table_header(data)
      html = '<tbody><tr>'
      data.each do |row|
        row.each do |col|
          html << "<th>#{col[:text]}</td>"
        end
      end
      html << '</tr></tbody>'
      return html
    end

    def parse_data(html, data)
      data.each do |row|
        html << '<tr>'
        row.each do |col|
          html << "<td rowspan=" "#{col[:rowspan]}" ">#{col[:text]}</td>"
        end
        html << '</tr>'
      end

      return html
    end

    def column_parser(data, col_index=0)
      data.each_with_index do |row, row_index|
        col = row[col_index]
        if col[:rowspan] > 0
          data[row_index..((row_index+col[:rowspan])-1)].each_with_index do |current_row, row_pointer|
            new_col = {text: col[:text], rowspan: 0}
            row_pointer == 0 ? current_row[col_index].replace(new_col) : current_row.insert(col_index, new_col)
            data[row_index+row_pointer].replace(current_row)
          end
        end
      end
      puts "Calling >>> #{col_index}"
      col_index+=1
      data = column_parser(data, col_index) if col_index <= 8
      return data
    end

    def delete_column(data, col_number)
      data.map { |row| row.delete_at(col_number-1) }
      return data
    end

    def array_to_hash(array)
      count = 0
      hash = Hash.new
      (array.length-1).times do
        hash[array[count]] = array[count+1]
        count += 1
      end
      return hash
    end

    def regenerate_array
      array = []
      temp_array = []

      data = column_parser(scrap_table)
      data = delete_column(data, 3)
      data.each do |row|
        row.each do |col|
          node = col[:text]
          temp_array << node
        end
        array << array_to_hash(temp_array)
        temp_array = []
      end
      return regenerate_hash(array)
    end

    def regenerate_hash(data)
      result = []
      temp_array=[]

      8.times do |n|
        data.each_with_index do |current_array, current_index|
          new_element = false
          key = current_array.keys[n]
          next_index = current_index+1
          next_key = next_index < data.size ? data[next_index].keys[n] : nil
          new_element = true if key.to_s != next_key.to_s
          temp_array << current_array[key]
          if new_element
            result << {key.to_s => temp_array.uniq}
            temp_array = []
          end
        end
      end
      return result
    end

    def create_hash_with_header
      array = []
      temp_array = []

      header = scrap_table_header({delete_column: 3})
      data = column_parser(scrap_table)
      data = delete_column(data, 3)
      header = header.first
      8.times do |n|
        data.each_with_index do |row, index|
          @key = header[n][:text]
          temp_array << row[n][:text]
        end
        array << {@key.to_s => temp_array.uniq}
        temp_array = []
      end
      return array
    end


    def generate_table(options={})
      table_head = scrap_table_header(options)
      data = column_parser(scrap_table)
      data = delete_column(data, options[:delete_column]) if options[:delete_column]
      table_head = table_header(table_head)

      html = "<table class='table table-bordered'>"
      html << table_head
      html = parse_data(html, data)
      html << "</table>"
      return html
    end
  end
end
