module TableScript

  class HtmlTable

    def initialize
      @table_head = "<thead>
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
          </thead>
          <tbody>
          <tr>
            <td rowspan="13"><i>Main Data</i></td>
            <td rowspan="3">Data A</td>
            <td rowspan="10"> </td>
            <td rowspan="3"><i>Data b</i></td>
            <td><i>Data c</i></td>
            <td><i>Data d</i></td>
            <td>Data e</td>
            <td rowspan="7">Data r</td>
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
            <td rowspan="6">Data r</td>
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

    def parse_data_step_1(html, data)
      i=-1
      data_array=[]

      data.each_with_index do |row, index|
        row.each do |col|
          (1..col[:rowspan]).each do |n|
            if index == 0
              i+=1
              data[i].delete_at(0) if i == 0
              new_col = {text: col[:text], rowspan: 0}
              new_row = data[i]
              new_row = new_row.insert(0, new_col) if new_row.present?
              data_array << new_row if new_row.present?
            end
          end
        end
      end
      parse_data(html, data_array)
    end

    def column_parser(data)
      data.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          if col[:rowspan] > 0
            data[row_index..(col[:rowspan]-1)].each_with_index do |current_row, row_pointer|
              puts "calling #{[row_index, col_index, row_pointer]}"
              new_col = {text: col[:text], rowspan: 0}
              row_pointer == 0 ? current_row[col_index].replace(new_col) : current_row.insert(col_index, new_col)
              #puts "clsp #{current_row.inspect}\n"
              data[row_pointer].replace(current_row)
            end
            return data
          end
        end
      end
    end

    def parser_complete(data)
      data = column_parser(data)
      puts "1:::data #{data}"
      data = column_parser(data)
      puts "2:::data #{data}"
      data = column_parser(data)
      puts "3:::data #{data}"
      data = column_parser(data)
      puts "4:::data #{data}"
      data = column_parser(data)
      puts "5:::data #{data}"
      data = column_parser(data)
      puts "6:::data #{data}"
      data = column_parser(data)
      puts "7:::data #{data}"
      data = column_parser(data)
      puts "8:::data #{data}"
      data = column_parser(data)
      puts "9:::data #{data}"
      data = column_parser(data)
      puts "10:::data #{data}"
      data = column_parser(data)
      puts "11:::data #{data}"
      data = column_parser(data)
      puts "12:::data #{data}"
      data = column_parser(data)
      puts "13:::data #{data}"
      return data
    end


    def general_parser(data, row_counter)
      data_array = data
      break_point = false
      data.each_with_index do |row, row_index|
        row_pointer = row_index
        row.each_with_index do |col, col_index|
          row_pointer = row_pointer <= 12 ? row_pointer : 0
          puts "calling #{[row_index, col_index]}"
          unless break_point
            if col[:rowspan] != 0
              (1..col[:rowspan]).each do |n|
                current_row = data[row_pointer]
                current_row.delete_at(col_index) if current_row.present? && (n == 1)
                new_col = {text: col[:text], rowspan: 0}
                new_row = current_row.insert(col_index, new_col)
                puts "clsp #{row_pointer} #{current_row.inspect}\n"
                data_array.insert(row_pointer, new_row)
                data_array.delete_at(row_pointer)
                row_pointer+=1
              end
            end
            data_array
            break_point = true
          end
          data_array
        end
        row_counter+=1
      end
      general_parser(data_array, row_counter) if row_counter <= 13
      return data_array
    end


    def generate_table(data)
      html = "<table class='table table-bordered'>"
      html << @table_head
      html = TableScript::HtmlTable.new.parse_data(html, data)
      html << "</table>"
      return html
    end
  end
end
