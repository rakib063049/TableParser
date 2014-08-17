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

      @table_head2 = "<thead>
      <tr>
        <th>Blue</th>
        <th>Black</th>
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

    def generate_hash
      parser = TableScript::HtmlTable.new
      data = parser.column_parser(parser.scrap_table)
      data = parser.delete_column(data, 3)
      data
    end

    def generate_table(options={})
      parser = TableScript::HtmlTable.new
      data = parser.column_parser(parser.scrap_table)
      if options[:delete_column].present?
        table_head = @table_head2
        data = parser.delete_column(data, options[:delete_column])
      else
        table_head = @table_head
      end
      html = "<table class='table table-bordered'>"
      html << table_head
      html = parser.parse_data(html, data)
      html << "</table>"
      return html
    end
  end
end
