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
      <td><i>Main Data</i></td>
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
      <td><i>Main Data</i></td>
      <td><i>Data w</i></td>
      <td></td>
      <td rowspan="2">Data k</td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
      <td><i>Data n</i></td>
      <td><i>Data p</i><br><i>Data h</i>
      </td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
      <td>Data o</td>
      <td>Data i</td>
      <td><i>Data u</i></td>
      <td><i>Data y</i></td>
      <td rowspan="4">Data t</td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
      <td rowspan="6">Data r</td>
      <td><i>Data e</i></td>
      <td><i>Data w</i></td>
      <td><i>Data qq</i></td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
      <td><i>Data zz</i></td>
      <td><i>Data xx</i></td>
      <td><i>Data cc</i></td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
      <td><i>Data vv</i></td>
      <td><i>Data bb</i></td>
      <td><i>Data nn</i></td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
      <td rowspan="2"><i>Data zzd</i></td>
      <td><i>Data gg</i></td>
      <td rowspan="2"><i>Data hh</i></td>
      <td><span class="ipinfo">Data pp</td>
      <td rowspan="3">Data cll</td>
      <td></td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
      <td><i>Data cwxwx</i></td>
      <td>Data qatyh</td>
      <td rowspan="2">Data djdj</td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
      <td><i>Data yhn</i></td>
      <td><i>Data rfvc</i></td>
      <td><i>Data yui</i></td>
      <td>Data rty</td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
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
      <td><i>Main Data</i></td>
      <td><i>Data dfg</i></td>
      <td><i>Data fgf</i></td>
      <td><i>Data kkhk</i></td>
      <td>Data jjj</td>
    </tr>
    <tr>
      <td><i>Main Data</i></td>
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
      puts details.inspect
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

    def parse_data2(html, data)
      data.each do |row|
        html << '<tr>'
        row.each do |col|
          html << '<td>'
          (0..col[:rowspan]).each do
            html << col[:text]
          end
          html << '</td>'
        end
        html << '</tr>'
      end

      return html
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