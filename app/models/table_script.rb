module TableScript

  class Sucks

    def scrap
      html = <<-EOS
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
      doc = Nokogiri::HTML(html)
      rows = doc.xpath('//table/tbody/tr')
      data = {}
      i = 1
      details = rows.collect do |row|
        for j in 1..10
          xpath = "xpath_#{i}_#{j}"
          xpath = row.at("td[#{j}]")
          if xpath.present?
            text = xpath.text.to_s.strip
            rowspan = xpath.attr("rowspan").to_i
            data = data.merge({:"xpath_#{i}_#{j}" => {:"text_#{i}_#{j}" => text, :"rowspan_#{i}_#{j}" => rowspan}})
          end
        end
        i+=1
        data
      end

      details.each do |detail|
        puts "Details::: #{detail.inspect}"
        puts "\n"
      end
      return details
    end


#html = <<-EOS
#      <table >
#        <tbody>
#          <tr>  <!-- table header --> </tr>
#        </tbody>
#        <!-- show threads -->
#        <tbody id="threadbits_forum_251">
#          <tr>
#            <td></td>
#            <td></td>
#            <td>
#              <div>
#                <a href="showthread.php?t=230708" >Vb4 Gold Released</a>
#              </div>
#              <div>
#                <span><a>Paul M</a></span>
#              </div>
#            </td>
#            <td>
#                06 Jan 2010 <span class="time">23:35</span><br />
#                by <a href="member.php?find=lastposter&amp;t=230708">shane943</a>
#              </div>
#            </td>
#            <td><a href="#">24</a></td>
#            <td>1,320</td>
#          </tr>
#
#        </tbody>
#      </table>
#EOS

#doc = Nokogiri::HTML(html)
#rows = doc.xpath('//table/tbody[@id="threadbits_forum_251"]/tr')
#details = rows.collect do |row|
#  detail = {}
#  [
#      [:title, 'td[3]/div[1]/a/text()'],
#      [:name, 'td[3]/div[2]/span/a/text()'],
#      [:date, 'td[4]/text()'],
#      [:time, 'td[4]/span/text()'],
#      [:number, 'td[5]/a/text()'],
#      [:views, 'td[6]/text()'],
#  ].each do |name, xpath|
#    detail[name] = row.at_xpath(xpath).to_s.strip
#  end
#  detail
#end
#puts details.inspect
#return details


    def parse_table
      html = <<-EOS
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

      doc = Nokogiri::HTML(html)
      table = TableParser::Table.new doc, "/html/body/table"

      puts "table::::#{table.inspect}"
      return table
    end

    def parse_data(html, data, new_line = true)

      klass = data.class

      # Use the class to know if we need to create TH or TD
      case
        when klass == Hash
          data.each do |key, value|

            # Start a new row
            if new_line
              html << '<tr>'
              new_line = false
            end

            # Check if we need to use a rowspan
            if value.class == Array || value.count == 1
              html << "<th>#{key}</th>"
            else
              html << "<th rowspan=\"#{value.count}\">#{key}</th>"
            end

            # Parse the content of the hash (recursive)
            html, new_line = parse_data(html, value, new_line)
          end
        when klass = Array
          data.each do |item|
            html << "<td>#{item}</td>"
          end

          # We end the row and flag that we need to start a new one
          # if there is anymore data
          html << '</tr>'
          new_line = true
      end

      return html, new_line
    end

  end
end