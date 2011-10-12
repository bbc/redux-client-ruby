require "spec_helper"

describe BBC::Redux::Schedule do

  describe ".from_tv_html" do
    it "should work" do
      schedule = BBC::Redux::Schedule.from_tv_html(tv_html_string)
      schedule.size.should  == 201
      schedule.first.should == "5564143876136277914"
    end
  end

  def tv_html_string
    %Q{<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
    <html>
      <head>
        <title>BBC</title>
        <link rel="stylesheet" type="text/css" media="all" title="Default" href="/static/main.css">
      </head>
      <body>
        <div>
          <a href="/"><img src="/static/bbc.gif"></a>


            Logged in! :: <a href="/">Home</a> :: <a href="/user">Your account</a> :: <a href="/logout">Log out</a>

        </div>

    <!--    <h2>Redux is currently being intentionally broken as part of the development process.</h2> -->

      <p>Content search :: <a href="/">Home</a></p>

      <script type="text/javascript">
      function show_advform() {
        document.getElementById("quicksearch").style.display = "none";
        document.getElementById("advsearch").style.display = "block";
        document.getElementById("advq").value = document.getElementById("basicq").value;
        document.cookie = "search=advanced";
      }
      function hide_advform() {
        document.getElementById("advsearch").style.display = "none";
        document.getElementById("quicksearch").style.display = "block";
        document.getElementById("basicq").value = document.getElementById("advq").value;
        document.cookie = "search=basic; path=/";
      }

      function readCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
          var c = ca[i];
          while (c.charAt(0)==' ') c = c.substring(1,c.length);
          if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
        }
        return null;
      }

    </script>

    <div id="quicksearch">
      <form action="/search" method="get">
        <input type="text" name="q" id="basicq" value="">
        <input type="submit" value="search">
        <input type="submit" name="lucky" value="feeling lucky..."><br>
        <a href="javascript:show_advform()">Advanced...</a>
      </form>

      <br>
    </div>

    <div id="advsearch" style="display: none">
      <form action="/search" method="get">
        <table class="advsearch">
          <tr><th>Query:</th><td><input type="text" name="q" id="advq" value=""></td></tr>
          <tr><th>Sort by:</th><td><label><input type="radio" name="sort" value="date" checked> Date</label> <label><input type="radio" name="sort" value="rel" > Relevance</label></td></tr>

          <tr><th>Length:</th><td>Longer than (&gt;=): <input type="text" size="4" name="lt" value=""> minutes<br>Shorter than (&lt;=): <input type="text" size="4" name="st" value=""> minutes</td></tr>
          <tr><th>Include repeats:</th><td><label><input type="checkbox" name="repeats" ></td></tr>
          <tr><th>Channels:</th><td><select name="channel" multiple size=20>

            <optgroup label="TV">
            <option value="bbcone" >BBC One</option><option value="bbctwo" >BBC Two</option><option value="bbcthree" >BBC Three</option><option value="bbcfour" >BBC Four</option><option value="cbbc" >CBBC</option><option value="cbeebies" >CBeebies</option><option value="bbcnews24" >News 24</option><option value="bbchd" >BBC HD</option><option value="bbcparl" >BBC Parliament</option><option value="bbconehd" >BBC One HD</option><option value="itv1" >ITV1</option><option value="itv2" >ITV2</option><option value="itv3" >ITV3</option><option value="itv4" >ITV4</option><option value="channel4" >Channel 4</option><option value="e4" >E4</option><option value="more4" >More4</option><option value="dave" >Dave</option><option value="five" >Five</option><option value="archive" >BBC D3 Archive</option><option value="alia" >Alia magic channel</option><option value="bufvc" >bufvc</option>

            <optgroup label="Radio">
            <option value="bbcr1" >Radio 1</option><option value="bbc1x" >Radio 1 Xtra</option><option value="bbcr2" >Radio 2</option><option value="bbcr3" >Radio 3</option><option value="bbcr4" >Radio 4</option><option value="bbcr5l" >Five Live</option><option value="r5lsx" >Five Live Sports</option><option value="bbc6m" >Six Music</option><option value="bbc7" >BBC 7</option><option value="bbcan" >Asian Network</option><option value="bbcws" >World Service</option>
          </select></td></tr>

          <tr><td colspan=2 style="text-align: center"><br><input type="submit" value="search"></td></tr>
        </table>
      </form>
      <p><a href="javascript:hide_advform()">Basic search</a></p>
    <!--
        <br>
        <input type="radio" name="channel" id="all" value="" checked><label for="all">All BBC channels</label><br><br>
        TV: <label for="bbcone" style="white-space: nowrap"><input type="radio" name="channel" value="bbcone" id="bbcone" >BBC One</label> <label for="bbctwo" style="white-space: nowrap"><input type="radio" name="channel" value="bbctwo" id="bbctwo" >BBC Two</label> <label for="bbcthree" style="white-space: nowrap"><input type="radio" name="channel" value="bbcthree" id="bbcthree" >BBC Three</label> <label for="bbcfour" style="white-space: nowrap"><input type="radio" name="channel" value="bbcfour" id="bbcfour" >BBC Four</label> <label for="cbbc" style="white-space: nowrap"><input type="radio" name="channel" value="cbbc" id="cbbc" >CBBC</label> <label for="cbeebies" style="white-space: nowrap"><input type="radio" name="channel" value="cbeebies" id="cbeebies" >CBeebies</label> <label for="bbcnews24" style="white-space: nowrap"><input type="radio" name="channel" value="bbcnews24" id="bbcnews24" >News 24</label> <label for="bbchd" style="white-space: nowrap"><input type="radio" name="channel" value="bbchd" id="bbchd" >BBC HD</label> <label for="bbcparl" style="white-space: nowrap"><input type="radio" name="channel" value="bbcparl" id="bbcparl" >BBC Parliament</label> <label for="bbconehd" style="white-space: nowrap"><input type="radio" name="channel" value="bbconehd" id="bbconehd" >BBC One HD</label> <br><label for="itv1" style="white-space: nowrap"><input type="radio" name="channel" value="itv1" id="itv1" >ITV1</label> <label for="itv2" style="white-space: nowrap"><input type="radio" name="channel" value="itv2" id="itv2" >ITV2</label> <label for="itv3" style="white-space: nowrap"><input type="radio" name="channel" value="itv3" id="itv3" >ITV3</label> <label for="itv4" style="white-space: nowrap"><input type="radio" name="channel" value="itv4" id="itv4" >ITV4</label> <label for="channel4" style="white-space: nowrap"><input type="radio" name="channel" value="channel4" id="channel4" >Channel 4</label> <label for="e4" style="white-space: nowrap"><input type="radio" name="channel" value="e4" id="e4" >E4</label> <label for="more4" style="white-space: nowrap"><input type="radio" name="channel" value="more4" id="more4" >More4</label> <label for="dave" style="white-space: nowrap"><input type="radio" name="channel" value="dave" id="dave" >Dave</label> <label for="five" style="white-space: nowrap"><input type="radio" name="channel" value="five" id="five" >Five</label> <br><label for="archive" style="white-space: nowrap"><input type="radio" name="channel" value="archive" id="archive" >BBC D3 Archive</label> <label for="alia" style="white-space: nowrap"><input type="radio" name="channel" value="alia" id="alia" >Alia magic channel</label> <label for="bufvc" style="white-space: nowrap"><input type="radio" name="channel" value="bufvc" id="bufvc" >bufvc</label> <br><br>
        Radio: <label for="bbcr1" style="white-space: nowrap"><input type="radio" name="channel" value="bbcr1" id="bbcr1" >Radio 1</label> <label for="bbc1x" style="white-space: nowrap"><input type="radio" name="channel" value="bbc1x" id="bbc1x" >Radio 1 Xtra</label> <label for="bbcr2" style="white-space: nowrap"><input type="radio" name="channel" value="bbcr2" id="bbcr2" >Radio 2</label> <label for="bbcr3" style="white-space: nowrap"><input type="radio" name="channel" value="bbcr3" id="bbcr3" >Radio 3</label> <label for="bbcr4" style="white-space: nowrap"><input type="radio" name="channel" value="bbcr4" id="bbcr4" >Radio 4</label> <label for="bbcr5l" style="white-space: nowrap"><input type="radio" name="channel" value="bbcr5l" id="bbcr5l" >Five Live</label> <label for="r5lsx" style="white-space: nowrap"><input type="radio" name="channel" value="r5lsx" id="r5lsx" >Five Live Sports</label> <label for="bbc6m" style="white-space: nowrap"><input type="radio" name="channel" value="bbc6m" id="bbc6m" >Six Music</label> <label for="bbc7" style="white-space: nowrap"><input type="radio" name="channel" value="bbc7" id="bbc7" >BBC 7</label> <label for="bbcan" style="white-space: nowrap"><input type="radio" name="channel" value="bbcan" id="bbcan" >Asian Network</label> <label for="bbcws" style="white-space: nowrap"><input type="radio" name="channel" value="bbcws" id="bbcws" >World Service</label>  -->
    </div>

    <script type="text/javascript">
      if(readCookie("search") == "advanced" && 0) {
        show_advform();
      }
    </script>



      <a href="/day/radio-2011-01-20">Radio</a>

      <table><tr><th></th><th><img src="/static/bbcone.png"></th><th><img src="/static/bbctwo.png"></th><th><img src="/static/cbeebies.png"></th><th><img src="/static/cbbc.png"></th><th><img src="/static/bbcthree.png"></th><th><img src="/static/bbcfour.png"></th><th><img src="/static/bbcnews24.png"></th></tr><tr>
        <th valign="top">
          <div style="height: 718px; border: 1px dashed">6</div>

          <div style="height: 718px; border: 1px dashed">7</div>

          <div style="height: 718px; border: 1px dashed">8</div>


          <div style="height: 718px; border: 1px dashed">9</div>

          <div style="height: 718px; border: 1px dashed">10</div>

          <div style="height: 718px; border: 1px dashed">11</div>

          <div style="height: 718px; border: 1px dashed">12</div>

          <div style="height: 718px; border: 1px dashed">13</div>

          <div style="height: 718px; border: 1px dashed">14</div>


          <div style="height: 718px; border: 1px dashed">15</div>

          <div style="height: 718px; border: 1px dashed">16</div>

          <div style="height: 718px; border: 1px dashed">17</div>

          <div style="height: 718px; border: 1px dashed">18</div>

          <div style="height: 718px; border: 1px dashed">19</div>

          <div style="height: 718px; border: 1px dashed">20</div>


          <div style="height: 718px; border: 1px dashed">21</div>

          <div style="height: 718px; border: 1px dashed">22</div>

          <div style="height: 718px; border: 1px dashed">23</div>

          <div style="height: 718px; border: 1px dashed">0</div>

          <div style="height: 718px; border: 1px dashed">1</div>

          <div style="height: 718px; border: 1px dashed">2</div>


          <div style="height: 718px; border: 1px dashed">3</div>

          <div style="height: 718px; border: 1px dashed">4</div>

          <div style="height: 718px; border: 1px dashed">5</div>
        </th>

          <td valign="top" width=152>


              <div style="height: 0px">&nbsp;</div>
              <a name="06-00-00">

              <a href="/programme/bbcone/2011-01-20/06-00-00" style="text-decoration: none">
                <div style="height: 2338px; border: 1px dashed">
                  <div class="proghead">Breakfast</div>
                  <img src="/programme/5564143876136277914/download/image-150.jpg" title="The latest news, sport, business and weather from the BBC's Breakfast team. [S] Including regional news at 25 and 55 minutes past each hour."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="09-15-00">

              <a href="/programme/bbcone/2011-01-20/09-15-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">Wanted Down Under</div>
                  <img src="/programme/5564194127253641115/download/image-150.jpg" title="British families sample life down under. Donna and Rob Harrison from Tamworth dream of a new beginning in Australia, but their teenage children are reluctant to move. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="10-00-00">

              <a href="/programme/bbcone/2011-01-20/10-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Homes Under the Hammer</div>
                  <img src="/programme/5564205723665340316/download/image-150.jpg" title="Martin Roberts and Lucy Alexander visit a house in Cardiff, a semi-detached in Broadstairs and a three-floored house in Devon. [S] Then BBC News; Weather."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="11-00-00">

              <a href="/programme/bbcone/2011-01-20/11-00-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">Saints and Scroungers</div>
                  <img src="/programme/5564221185547605917/download/image-150.jpg" title="14/20. Series looking at benefit fraud. This episode features the story of the family who cheated the benefit system to build a property empire worth 1.5 million pounds. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="11-45-00">

              <a href="/programme/bbcone/2011-01-20/11-45-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Cash in the Attic</div>
                  <img src="/programme/5564232781959306909/download/image-150.jpg" title="Series looking at the value of household junk. A mother and daughter seek to clear out their clutter and raise money to buy stylish new outfits for a family wedding. [S] Then BBC News; Weather."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="12-15-00">

              <a href="/programme/bbcone/2011-01-20/12-15-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">Bargain Hunt</div>
                  <img src="/programme/5564240512900437919/download/image-150.jpg" title="Newark: Antiques challenge. Experts Paul Laidlaw and David Barby guide the Bargain Hunters at the Newark County Showground. Tim Wonnacott visits Lyme Park in Cheshire. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-00-00">

              <a href="/programme/bbcone/2011-01-20/13-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News at One</div>
                  <img src="/programme/5564252109312137120/download/image-150.jpg" title="The latest national and international news stories from the BBC News team, followed by weather. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-30-00">

              <a href="/programme/bbcone/2011-01-20/13-30-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">BBC London News</div>
                  <img src="/programme/5564259840253270744/download/image-150.jpg" title="The latest news, sport and weather from London. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-45-00">

              <a href="/programme/bbcone/2011-01-20/13-45-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Doctors</div>
                  <img src="/programme/5564263705723836322/download/image-150.jpg" title="A Broken Heart: Elaine treats a vicar's wife who is at a major crossroads in her life but will she follow her heart or her head? Rob is given an unsettling new case. Also in HD. [AD,S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="14-15-00">

              <a href="/programme/bbcone/2011-01-20/14-15-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">Land Girls</div>
                  <img src="/programme/5564271436664970910/download/image-150.jpg" title="4/5. Fight the Good Fight: Connie becomes concerned that a young evacuee is in danger. Also in HD. [AD,S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-00-00">

              <a href="/programme/bbcone/2011-01-20/15-00-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564283033076668324/download/image-150.jpg" title="The latest national and international news stories from the BBC News team, followed by weather. [S] Followed by regional news."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-05-00">

              <a href="/programme/bbcone/2011-01-20/15-05-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Deadly 60</div>
                  <img src="/programme/5564284321566857125/download/image-150.jpg" title="CBBC. Malaysia: Naturalist Steve Backshall is searching for animals for his Deadly 60 list. In the Gomantong cave system he finds thousands of cockroaches and the scutigera centipede. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-35-00">

              <a href="/programme/bbcone/2011-01-20/15-35-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Me and My Monsters</div>
                  <img src="/programme/5564292052507989926/download/image-150.jpg" title="CBBC. 13/13. Bogey Brothers: Eddie announces that he wants to become a full-time monster. Also in HD. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-00-00">

              <a href="/programme/bbcone/2011-01-20/16-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Copycats</div>
                  <img src="/programme/5564298494958933927/download/image-150.jpg" title="CBBC. Sam and Mark host as two families battle it out in a range of hilarious games, like Quick on the Draw, Mime Time, Music Round, and the formidable Copycats Challenge. Also in HD. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-30-00">

              <a href="/programme/bbcone/2011-01-20/16-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Horrible Histories</div>
                  <img src="/programme/5564306225900064060/download/image-150.jpg" title="CBBC. 3/13. In Ancient Greece, it's time for Spartan High School Musical. Also in HD. [AD,S] Then Diddy Dick and Dom."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-00-00">

              <a href="/programme/bbcone/2011-01-20/17-00-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Newsround</div>
                  <img src="/programme/5564313956841199529/download/image-150.jpg" title="CBBC. Daily news magazine keeping young viewers up to date on the latest stories and events happening at home and abroad. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-15-00">

              <a href="/programme/bbcone/2011-01-20/17-15-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">The Weakest Link</div>
                  <img src="/programme/5564317822311765930/download/image-150.jpg" title="Anne Robinson presents the quick-fire general knowledge quiz in which contestants must decide at the end of each round which of their number should be eliminated. Also in HD. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="18-00-00">

              <a href="/programme/bbcone/2011-01-20/18-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News at Six</div>
                  <img src="/programme/5564329418723465131/download/image-150.jpg" title="The latest national and international news stories from the BBC News team, followed by weather. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="18-30-00">

              <a href="/programme/bbcone/2011-01-20/18-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC London News</div>
                  <img src="/programme/5564337149664598745/download/image-150.jpg" title="The latest news, sport and weather from London. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="19-00-00">

              <a href="/programme/bbcone/2011-01-20/19-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">The One Show</div>
                  <img src="/programme/5564344880605730733/download/image-150.jpg" title="Journalist Andrew Neil joins Chris Evans and Alex Jones in the studio. With reports on the underwater forests in Northern Ireland and the enduring legacy of Winnie the Pooh. Also in HD. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="19-30-00">

              <a href="/programme/bbcone/2011-01-20/19-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">EastEnders</div>
                  <img src="/programme/5564352611546863534/download/image-150.jpg" title="The police question Ricky and Carol about last night's terrible events. Also in HD. [AD,S] Then BBC News."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="20-00-00">

              <a href="/programme/bbcone/2011-01-20/20-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Human Planet</div>
                  <img src="/programme/5564360342487996336/download/image-150.jpg" title="2/8. Deserts - Life in the Furnace: Humans cannot live long without water yet we have found incredible ways to live in deserts. Also in HD. [AD,S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="21-00-00">

              <a href="/programme/bbcone/2011-01-20/21-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Come Fly with Me</div>
                  <img src="/programme/5564375804370261937/download/image-150.jpg" title="5/6. Another visit to Britain's busiest airport terminal, in the hilarious company of Matt Lucas and David Walliams. Also in HD. [AD,S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="21-30-00">

              <a href="/programme/bbcone/2011-01-20/21-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Not Going Out</div>
                  <img src="/programme/5564383535311394738/download/image-150.jpg" title="3/6. Movie: Sitcom. Lee promises to stop treating Lucy's flat as if he owns it - but not before he has hired it out to a film director. Contains adult humour. Also in HD. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="22-00-00">

              <a href="/programme/bbcone/2011-01-20/22-00-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">BBC News at Ten</div>
                  <img src="/programme/5564391266252527539/download/image-150.jpg" title="The latest national and international news, with reports from BBC correspondents worldwide. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="22-25-00">

              <a href="/programme/bbcone/2011-01-20/22-25-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">BBC London News</div>
                  <img src="/programme/5564397708703472346/download/image-150.jpg" title="The latest news, sport and weather from London. [S] Followed by national weather."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="22-35-00">

              <a href="/programme/bbcone/2011-01-20/22-35-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Question Time</div>
                  <img src="/programme/5564400285683849142/download/image-150.jpg" title="David Dimbleby chairs the topical debate from Burnley. The panel includes Alastair Campbell, George Galloway, Simon Hughes, Caroline Spelman and Clarke Carlisle. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="23-35-00">

              <a href="/programme/bbcone/2011-01-20/23-35-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">This Week</div>
                  <img src="/programme/5564415747566114743/download/image-150.jpg" title="A political review of the week presented by Andrew Neil, with Michael Portillo and guests. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="00-20-00">

              <a href="/programme/bbcone/2011-01-21/00-20-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">Skiing Weatherview</div>
                  <img src="/programme/5564427343977813944/download/image-150.jpg" title="Detailed weather forecast. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="00-25-00">

              <a href="/programme/bbcone/2011-01-21/00-25-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Britain's Missing Dads: Panorama</div>
                  <img src="/programme/5564428632468004548/download/image-150.jpg" title="Are actively involved dads becoming an endangered species in some parts of Britain? Reporter Declan Lawn investigates what can be done to keep them in the picture. [S,SL]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="00-55-00">

              <a href="/programme/bbcone/2011-01-21/00-55-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Countryfile</div>
                  <img src="/programme/5564436363409135546/download/image-150.jpg" title="Adam Henson and Ellie Harrison head for the Duddon Valley in Cumbria where they discover how this landscape inspired William Wordsworth. Plus Adam tries his hand at kite-surfing. [S,SL]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="01-55-00">

              <a href="/programme/bbcone/2011-01-21/01-55-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Antiques Roadshow</div>
                  <img src="/programme/5564451825291401147/download/image-150.jpg" title="Fiona Bruce and the experts set up for a busy day at The Sage Gateshead. It takes five men to lift in a piece which is awarded the highest valuation ever seen on the programme. [S,SL]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="02-55-00">

              <a href="/programme/bbcone/2011-01-21/02-55-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">Filthy Rotten Scoundrels</div>
                  <img src="/programme/5564467287173668511/download/image-150.jpg" title="7/15. Series highlighting the work of environment officers. An operation to catch people urinating in the streets of London sees a number of people caught with their trousers down! [S,SL]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="03-40-00">

              <a href="/programme/bbcone/2011-01-21/03-40-00" style="text-decoration: none">
                <div style="height: 1678px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564478883585365949/download/image-150.jpg" title="BBC One joins the BBC's rolling news channel for a night of news, with bulletins on the hour and the headlines every 15 minutes. [S]"><br>
                </div>
              </a>


          </td>

          <td valign="top" width=152>



              <div style="height: 0px">&nbsp;</div>
              <a name="06-00-00">
              <a href="/programme/bbctwo/2011-01-20/06-00-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Harry and Toto</div>
                  <img src="/programme/5564143876140471147/download/image-150.jpg" title="Win and Lose: Animation with a hare and tortoise who help young children learn about opposites. Harry learns that fast isn't always best. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="06-10-00">
              <a href="/programme/bbctwo/2011-01-20/06-10-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Everything's Rosie</div>
                  <img src="/programme/5564146453120848748/download/image-150.jpg" title="Skipping Bears, Talking Trees and Knitted Nests: Rosie lives in a playhouse with her colourful group of friends. Saffie wants to invite the Little Acorns over for a sleepover. [AD,S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="06-20-00">
              <a href="/programme/bbctwo/2011-01-20/06-20-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">dirtgirlworld</div>
                  <img src="/programme/5564149030101226349/download/image-150.jpg" title="Swap: Animated series about dirtgirl and her friends, who live in a bizarre world. What happens when everyone in dirtgirlworld swaps jobs? [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="06-35-00">
              <a href="/programme/bbctwo/2011-01-20/06-35-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Jakers: The Adventures of...</div>
                  <img src="/programme/5564152895571795541/download/image-150.jpg" title="...Piggley Winks. Milk Melodrama: Porcine adventures with Piggley Winks and friends. When Piggley hears about the farm's poor milk sales he launches a creative campaign to improve business. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="07-00-00">
              <a href="/programme/bbctwo/2011-01-20/07-00-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Animals at Work</div>
                  <img src="/programme/5564159338022736751/download/image-150.jpg" title="9/13. Gino Guide Dog: Factual series about working animals. Gino the guide dog helps his boss train for the 2012 Paralympic Games in judo, plus meet the most musical animals of all time. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="07-25-00">
              <a href="/programme/bbctwo/2011-01-20/07-25-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">Newsround</div>
                  <img src="/programme/5564165780473680790/download/image-150.jpg" title="Daily news magazine keeping young viewers up to date on the latest stories and events happening at home and abroad. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="07-30-00">
              <a href="/programme/bbctwo/2011-01-20/07-30-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Dennis & Gnasher</div>
                  <img src="/programme/5564167068963872342/download/image-150.jpg" title="Run Rabbit Run: Animation. Dennis accidentally lets Walter's rabbit loose while looking after it and is forced to disguise Gnasher as the rabbit until the real one can be rescued. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="07-45-00">
              <a href="/programme/bbctwo/2011-01-20/07-45-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Eliot Kid</div>
                  <img src="/programme/5564170934434435954/download/image-150.jpg" title="The Musketeers' Plot: Eliot, Mimi and Kaytoo swear to be faithful to each other, like the Three Musketeers. [S] Followed by The Owl."><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="08-00-00">
              <a href="/programme/bbctwo/2011-01-20/08-00-00" style="text-decoration: none">
                <div style="height: 2578px; border: 1px dashed">
                  <div class="proghead">Tennis: Australian Open 2011</div>
                  <img src="/programme/5564174799905010074/download/image-150.jpg" title="Andy Murray faces Ukrainian Illya Marchenko, currently ranked at 79 in the world, who has progressed from the opening round in Melbourne for the second successive year. [S]"><br>
                </div>
              </a>



              <div style="height: -180px">&nbsp;</div>
              <a name="11-20-00">
              <a href="/programme/bbctwo/2011-01-20/11-20-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Postman Pat</div>
                  <img src="/programme/5564226339512554364/download/image-150.jpg" title="Postman Pat and the Bollywood Dance: Children's animation. Sarah and Meera are practising a traditional Indian dance for the school assembly but Meera's sari has not arrived. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="11-35-00">
              <a href="/programme/bbctwo/2011-01-20/11-35-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Ready Steady Cook</div>
                  <img src="/programme/5564230204983123593/download/image-150.jpg" title="Olympic double gold medallist Rebecca Adlington and her mother Kay compete in the cooking challenge, presided over by Ainsley Harriott. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="12-00-00">
              <a href="/programme/bbctwo/2011-01-20/12-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">The Daily Politics</div>
                  <img src="/programme/5564236647434064770/download/image-150.jpg" title="Andrew Neil and Anita Anand present the top political stories of the day. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="12-30-00">
              <a href="/programme/bbctwo/2011-01-20/12-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">GMT with George Alagiah</div>
                  <img src="/programme/5564244378375197571/download/image-150.jpg" title="George Alagiah presents international news and intelligent analysis to take you live to the heart of the day's top global story. Plus up-to-the-minute global business news. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="13-00-00">
              <a href="/programme/bbctwo/2011-01-20/13-00-00" style="text-decoration: none">
                <div style="height: 1438px; border: 1px dashed">
                  <div class="proghead">Bowls: World Championships</div>
                  <img src="/programme/5564252109316331873/download/image-150.jpg" title="The ladies' singles match-play final is the main focus, as Rishi Persad presents further live coverage of the 2011 World Indoor Bowls Championships. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="15-00-00">
              <a href="/programme/bbctwo/2011-01-20/15-00-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">To Buy or Not to Buy</div>
                  <img src="/programme/5564283033080864394/download/image-150.jpg" title="Property series. It's a rush job for Ed Hall and Jonnie Irwin as they try and find a perfect pad in North London before the baby is born. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="15-45-00">
              <a href="/programme/bbctwo/2011-01-20/15-45-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">Flog It!</div>
                  <img src="/programme/5564294629492562259/download/image-150.jpg" title="Cirencester: The crowds turn out for a valuation day at the Corn Hall in Cirencester. Finds include an early Barbie doll and a 41 piece Clarice Cliff dinner service. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="16-30-00">
              <a href="/programme/bbctwo/2011-01-20/16-30-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">Perfection</div>
                  <img src="/programme/5564306225904262795/download/image-150.jpg" title="4/30. General knowledge quiz show hosted by Nick Knowles. One thousand pounds is up for grabs in each game but only by achieving absolute perfection will contestants win the prize. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="17-15-00">
              <a href="/programme/bbctwo/2011-01-20/17-15-00" style="text-decoration: none">
                <div style="height: 538px; border: 1px dashed">
                  <div class="proghead">Antiques Road Trip</div>
                  <img src="/programme/5564317822315959173/download/image-150.jpg" title="14/30. Kate Bliss and James Lewis are on the fourth leg of their Scottish odyssey. Kate learns some Camera Obscura facts in Edinburgh, but James is more interested in whisky vats. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="18-00-00">
              <a href="/programme/bbctwo/2011-01-20/18-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Eggheads</div>
                  <img src="/programme/5564329418727658374/download/image-150.jpg" title="General knowledge quiz in which teams from all over the UK battle to beat the Eggheads, some of the country's top quiz champions. Also in HD. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="18-30-00">
              <a href="/programme/bbctwo/2011-01-20/18-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Great British Railway Journeys</div>
                  <img src="/programme/5564337149668791175/download/image-150.jpg" title="14/25. Batley to Sheffield: Michael Portillo finds out about shoddy, a successful 19th-century recycling industry. Also in HD. [AD,S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="19-00-00">
              <a href="/programme/bbctwo/2011-01-20/19-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Who Does What?</div>
                  <img src="/programme/5564344880609926808/download/image-150.jpg" title="New series. 1/3. Essex and Salisbury: Jayne feels she is doing more than her fair share and that Neil does little to help. [AD,S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="20-00-00">
              <a href="/programme/bbctwo/2011-01-20/20-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Michel Roux's Service</div>
                  <img src="/programme/5564360342492189577/download/image-150.jpg" title="4/8. Now nearly half-way through their training, Michel Roux takes his group into the world of five-star hotel service on a busy bank holiday weekend. Also in HD. [AD,S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="21-00-00">
              <a href="/programme/bbctwo/2011-01-20/21-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Men of Rock</div>
                  <img src="/programme/5564375804374455178/download/image-150.jpg" title="Moving Mountains: Iain Stewart finds out how gung-ho geologist Edward Bailey discovered that Scotland was once home to super volcanoes. Plus the story of unsung hero Arthur Holmes. [AD,S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="22-00-00">
              <a href="/programme/bbctwo/2011-01-20/22-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">The Great Outdoors</div>
                  <img src="/programme/5564391266256720779/download/image-150.jpg" title="2/3. Comedy about a misfit rambling club. New deputy leader Christine is winning over the group, who deal with a farmer blocking public rights of way. Contains language which may offend. [AD,S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="22-30-00">
              <a href="/programme/bbctwo/2011-01-20/22-30-00" style="text-decoration: none">
                <div style="height: 598px; border: 1px dashed">
                  <div class="proghead">Newsnight</div>
                  <img src="/programme/5564398997197853580/download/image-150.jpg" title="The programme examines the resignation of shadow chancellor Alan Johnson and considers what it means for Labour's future. Presented by Matt Frei. [S] Followed by weather."><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="23-20-00">
              <a href="/programme/bbctwo/2011-01-20/23-20-00" style="text-decoration: none">
                <div style="height: 598px; border: 1px dashed">
                  <div class="proghead">The Planets</div>
                  <img src="/programme/5564411882099744397/download/image-150.jpg" title="3/8. Giants: Documentary series tracing our exploration of the solar system. This programme looks at Voyager's expedition to the vast gas planets of Jupiter, Saturn, Uranus and Neptune. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="00-10-00">
              <a href="/programme/bbctwo/2011-01-21/00-10-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Bowls: World Championships</div>
                  <img src="/programme/5564424767001631256/download/image-150.jpg" title="Highlights of the day's action from the World Indoor Championships. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="01-10-00">
              <a href="/programme/bbctwo/2011-01-21/01-10-00" style="text-decoration: none">
                <div style="height: 1798px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564440228883895183/download/image-150.jpg" title="BBC Two joins the BBC's rolling news channel, with bulletins on the hour and the headlines every 15 minutes. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="03-40-00">
              <a href="/programme/bbctwo/2011-01-21/03-40-00" style="text-decoration: none">
                <div style="height: 1678px; border: 1px dashed">
                  <div class="proghead">Pages from Ceefax</div>
                  <img src="/programme/5564478883589559184/download/image-150.jpg" title="News and information from the BBC's Teletext service."><br>
                </div>
              </a>



          </td>

          <td valign="top" width=152>


              <div style="height: 0px">&nbsp;</div>
              <a name="06-00-00">
              <a href="/programme/cbeebies/2011-01-20/06-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Tikkabilla</div>
                  <img src="/programme/5564143876974884002/download/image-150.jpg" title="Floating and Treasure: Featuring songs, rhymes, surprise guests and things to make. Floating, sharks, treasure and Higgledy House with Toni, Justin and Tamba. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="06-30-00">
              <a href="/programme/cbeebies/2011-01-20/06-30-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Me Too!</div>
                  <img src="/programme/5564151607916016803/download/image-150.jpg" title="Sharing Your Troubles: Drama series about parents and children. Dr Juno has a patient who doesn't want to be examined, but she explains that there is nothing to worry about. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="06-50-00">
              <a href="/programme/cbeebies/2011-01-20/06-50-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Pingu</div>
                  <img src="/programme/5564156761876772004/download/image-150.jpg" title="10/13. Pingu and the Barrel Organ: Animated adventures of the clumsy penguin. Pingu feels sorry for the organ-grinder. He puts money in his hat and wants the adult penguins to do the same. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="07-00-00">
              <a href="/programme/cbeebies/2011-01-20/07-00-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Tweenies</div>
                  <img src="/programme/5564159338857149605/download/image-150.jpg" title="Signs: Preschool fun. Fizz discovers a special picture box in her toybox - it is a sign. The Tweenies discover that signs tell you all sorts of things. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="07-20-00">
              <a href="/programme/cbeebies/2011-01-20/07-20-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Chuggington</div>
                  <img src="/programme/5564164492817904806/download/image-150.jpg" title="Brewster Meets the Mayor: Children's animation in which the trains talk, think and don't need drivers. Brewster prepares to carry Mayor Pullman across the re-opened Border Bridge. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="07-30-00">
              <a href="/programme/cbeebies/2011-01-20/07-30-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Charlie and Lola</div>
                  <img src="/programme/5564167069798282407/download/image-150.jpg" title="Yes I Am, No You're Not: Children's animation featuring the brother and his little sister. Charlie and Lola are looking forward to a Chinese puppet show, despite squabbling all day. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="07-40-00">
              <a href="/programme/cbeebies/2011-01-20/07-40-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">Buzz and Tell</div>
                  <img src="/programme/5564169646778660008/download/image-150.jpg" title="48/52. Puppet panel show hosted by a walrus called Walter Flipstick. The contestants include Melanie Wiggles - a rabbit studying carrots, and Ken Koala, who is very shy. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="07-45-00">
              <a href="/programme/cbeebies/2011-01-20/07-45-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Timmy Time</div>
                  <img src="/programme/5564170935268848809/download/image-150.jpg" title="Timmy Plays Ball: Animation about a young lamb and his farm nursery school. The class learns how to play football but Timmy keeps hogging the ball. Ruffy and Paxton get bored. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="08-00-00">
              <a href="/programme/cbeebies/2011-01-20/08-00-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Octonauts</div>
                  <img src="/programme/5564174800739415210/download/image-150.jpg" title="13/52. The Lost Sea Star: Animated deep sea adventures with Captain Barnacles and his explorers. The Octonauts find an unusual Sea Star on the beach. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="08-10-00">
              <a href="/programme/cbeebies/2011-01-20/08-10-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Postman Pat</div>
                  <img src="/programme/5564177377719792811/download/image-150.jpg" title="Postman Pat and His Runaway Train: Children's animation. Reverend Timms inadvertently starts the Greendale Rocket train, leaving Pat and PC Selby to give chase. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="08-25-00">
              <a href="/programme/cbeebies/2011-01-20/08-25-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Bob the Builder: Project Build It</div>
                  <img src="/programme/5564181243190359212/download/image-150.jpg" title="15/16. Mr Bentley's Assistant: Animated adventures of builder Bob and his friends as they construct an eco-town. Spud gets into trouble after mishearing some information from Mrs Bentley. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="08-35-00">
              <a href="/programme/cbeebies/2011-01-20/08-35-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">ZingZillas</div>
                  <img src="/programme/5564183820170736813/download/image-150.jpg" title="Salsa Dip: A band of primate friends play music in their tropical island paradise. Panzee wants to dance the salsa in the Big Zing but she doesn't think she needs to practice. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="09-00-00">
              <a href="/programme/cbeebies/2011-01-20/09-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Show Me Show Me</div>
                  <img src="/programme/5564190262621680814/download/image-150.jpg" title="Bananas and Sunshine: Chris and Pui investigate and explore in their magical playroom in the sky. Pui goes bananas about bananas and even wants to sell them to Wee Willy Winky. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="09-30-00">
              <a href="/programme/cbeebies/2011-01-20/09-30-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Little Charley Bear</div>
                  <img src="/programme/5564197993562813615/download/image-150.jpg" title="Charley Go Fish: Charley is a teddy bear who uses his imagination to go on adventures. Charley loves fishing for toys in his toy box, but he wants to catch real fish. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="09-40-00">
              <a href="/programme/cbeebies/2011-01-20/09-40-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">Alphablocks</div>
                  <img src="/programme/5564200570543191216/download/image-150.jpg" title="Map: The adventures of 26 lively letters who can make words come to life by holding hands. R isn't sure if she is really a pirate, until she finds a treasure map. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="09-45-00">
              <a href="/programme/cbeebies/2011-01-20/09-45-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Something Special</div>
                  <img src="/programme/5564201859033380017/download/image-150.jpg" title="Butterfly: Educational series for four- to seven-year-old children with learning difficulties. Mr Tumble is looking for a butterfly. He wants to film it with his new camera. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="10-05-00">
              <a href="/programme/cbeebies/2011-01-20/10-05-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Mister Maker Comes to Town</div>
                  <img src="/programme/5564207012994135218/download/image-150.jpg" title="9/25. Mister Maker takes to the road in his magical Makermobile in search of Mini Makers. Mister Maker creates a hilarious hairy bug from an old garlic press and clay. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="10-30-00">
              <a href="/programme/cbeebies/2011-01-20/10-30-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Come Outside</div>
                  <img src="/programme/5564213455445079219/download/image-150.jpg" title="Butterflies: Auntie Mabel and her dog, Pippin, go on adventures in their polka dotted plane. They find out about the life cycle of the butterfly. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="10-45-00">
              <a href="/programme/cbeebies/2011-01-20/10-45-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Mighty-Mites</div>
                  <img src="/programme/5564217320915645620/download/image-150.jpg" title="9/25. Drumming: Sarah-Jane and Go-Joe inspire children to have a go at exciting activities. Go-Joe and his friends Anandaleen and Alessandro form a band with saucepans and wooden spoons. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="11-00-00">
              <a href="/programme/cbeebies/2011-01-20/11-00-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Bits and Bobs</div>
                  <img src="/programme/5564221186386212021/download/image-150.jpg" title="Flowers: The adventures of Bits and Bobs, two inquisitive balls of fluff who are keen to find out about the world. What's Trug found today? It's big and red and good for nosing... [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="11-15-00">
              <a href="/programme/cbeebies/2011-01-20/11-15-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Waybuloo</div>
                  <img src="/programme/5564225051856778422/download/image-150.jpg" title="Treasure Hunt: Animation set in the magical land of Nara. Yojojo and Lau Lau go on a treasure hunt together. Nok Tok helps Lau Lau leave a row of seeds, but a bird eats his clue. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="11-35-00">
              <a href="/programme/cbeebies/2011-01-20/11-35-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Teletubbies</div>
                  <img src="/programme/5564230205817533623/download/image-150.jpg" title="Running: Preschool fun, fantasy and education. Dipsy runs all over Teletubbyland. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="12-00-00">
              <a href="/programme/cbeebies/2011-01-20/12-00-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Balamory</div>
                  <img src="/programme/5564236648268477624/download/image-150.jpg" title="Jungle: Live action series for preschool children, based around the small island community of Balamory. Spencer has lost his guitar. Join in the fun as he tries to find it. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="12-20-00">
              <a href="/programme/cbeebies/2011-01-20/12-20-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Tinga Tinga Tales</div>
                  <img src="/programme/5564241802229232825/download/image-150.jpg" title="Why Crocodile Has a Bumpy Back: Stories telling young children how animals got their distinctive parts. Here, the story of how Crocodile got his bumpy back and became grumpy. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="12-35-00">
              <a href="/programme/cbeebies/2011-01-20/12-35-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Tellytales</div>
                  <img src="/programme/5564245667699799226/download/image-150.jpg" title="12/15. The Golden Duck: Myths and tales from around the world jump off the pages in this mix of animation and stage play. Featuring a traditional Polish story about a shoemaker. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="12-45-00">
              <a href="/programme/cbeebies/2011-01-20/12-45-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Wibbly Pig</div>
                  <img src="/programme/5564248244680176827/download/image-150.jpg" title="Grandpa Pig: Preschool animation based on the popular children's books. Wibbly waits for Grandpa Pig to arrive and remembers some of the things they have done together. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-00-00">
              <a href="/programme/cbeebies/2011-01-20/13-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Show Me Show Me</div>
                  <img src="/programme/5564252110150743228/download/image-150.jpg" title="Bananas and Sunshine: Chris and Pui investigate and explore in their magical playroom in the sky. Pui goes bananas about bananas and even wants to sell them to Wee Willy Winky. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-30-00">
              <a href="/programme/cbeebies/2011-01-20/13-30-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Little Charley Bear</div>
                  <img src="/programme/5564259841091876029/download/image-150.jpg" title="Charley Go Fish: Charley is a teddy bear who uses his imagination to go on adventures. Charley loves fishing for toys in his toy box, but he wants to catch real fish. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-40-00">
              <a href="/programme/cbeebies/2011-01-20/13-40-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">Alphablocks</div>
                  <img src="/programme/5564262418072253630/download/image-150.jpg" title="Map: The adventures of 26 lively letters who can make words come to life by holding hands. R isn't sure if she is really a pirate, until she finds a treasure map. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-45-00">
              <a href="/programme/cbeebies/2011-01-20/13-45-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Something Special</div>
                  <img src="/programme/5564263706562442431/download/image-150.jpg" title="Butterfly: Educational series for four- to seven-year-old children with learning difficulties. Mr Tumble is looking for a butterfly. He wants to film it with his new camera. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="14-05-00">
              <a href="/programme/cbeebies/2011-01-20/14-05-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Mister Maker Comes to Town</div>
                  <img src="/programme/5564268860523197632/download/image-150.jpg" title="9/25. Mister Maker takes to the road in his magical Makermobile in search of Mini Makers. Mister Maker creates a hilarious hairy bug from an old garlic press and clay. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="14-30-00">
              <a href="/programme/cbeebies/2011-01-20/14-30-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Come Outside</div>
                  <img src="/programme/5564275302974141633/download/image-150.jpg" title="Butterflies: Auntie Mabel and her dog, Pippin, go on adventures in their polka dotted plane. They find out about the life cycle of the butterfly. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="14-45-00">
              <a href="/programme/cbeebies/2011-01-20/14-45-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Mighty-Mites</div>
                  <img src="/programme/5564279168444708034/download/image-150.jpg" title="9/25. Drumming: Sarah-Jane and Go-Joe inspire children to have a go at exciting activities. Go-Joe and his friends Anandaleen and Alessandro form a band with saucepans and wooden spoons. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-00-00">
              <a href="/programme/cbeebies/2011-01-20/15-00-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Bits and Bobs</div>
                  <img src="/programme/5564283033915274435/download/image-150.jpg" title="Flowers: The adventures of Bits and Bobs, two inquisitive balls of fluff who are keen to find out about the world. What's Trug found today? It's big and red and good for nosing... [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-10-00">
              <a href="/programme/cbeebies/2011-01-20/15-10-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Waybuloo</div>
                  <img src="/programme/5564285610895652036/download/image-150.jpg" title="Treasure Hunt: Animation set in the magical land of Nara. Yojojo and Lau Lau go on a treasure hunt together. Nok Tok helps Lau Lau leave a row of seeds, but a bird eats his clue. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-30-00">
              <a href="/programme/cbeebies/2011-01-20/15-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Space Pirates</div>
                  <img src="/programme/5564290764856407237/download/image-150.jpg" title="28/30. Music for a Sunny Day: Space-based adventures. The Pirate Posse's mission is to find music for a sunny day. Captain DJ looks cool in his dark sunglasses, but he finds it hard to see. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-00-00">
              <a href="/programme/cbeebies/2011-01-20/16-00-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Hoof and Safety with Nuzzle and...</div>
                  <img src="/programme/5564298495797540038/download/image-150.jpg" title="...Scratch. 5/13. On the Road: Nuzzle and Scratch are here to help keep you out of harm's way on the highway. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-25-00">
              <a href="/programme/cbeebies/2011-01-20/16-25-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Nina and the Neurons: In the Lab</div>
                  <img src="/programme/5564304938248484039/download/image-150.jpg" title="17/25. Sniffing Smells: Scientist Nina and her young Experimenters discover how substances change and react. They investigate how smells reach our noses through the air. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-40-00">
              <a href="/programme/cbeebies/2011-01-20/16-40-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Little Robots</div>
                  <img src="/programme/5564308803719050440/download/image-150.jpg" title="4/13. Too Speedy Sporty: Stop-frame animation about Tiny and his Little Robot friends, who live on a scrapheap. Sporty is just too fast and causes havoc with his high speeds. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-50-00">
              <a href="/programme/cbeebies/2011-01-20/16-50-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Octonauts</div>
                  <img src="/programme/5564311380699428041/download/image-150.jpg" title="14/52. The Albino Humpback Whale: Animated deep sea adventures with Captain Barnacles and his explorers. The Octonauts help out an Albino Humpback Whale with a nasty sunburn. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-00-00">
              <a href="/programme/cbeebies/2011-01-20/17-00-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Timmy Time</div>
                  <img src="/programme/5564313957679806064/download/image-150.jpg" title="Timmy Needs a Bath: Stop-frame animation about the adventures of the young lamb Timmy at his nursery school. After a game of football, muddy Timmy is determined not to have a bath. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-15-00">
              <a href="/programme/cbeebies/2011-01-20/17-15-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Gigglebiz</div>
                  <img src="/programme/5564317823150372043/download/image-150.jpg" title="4/16. Sketch show. Featuring Keith Fit, fitness pundit, who demonstrates how to go canoeing with predictable results, and Simon Pieman, the roller-skating pie delivery boy. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-30-00">
              <a href="/programme/cbeebies/2011-01-20/17-30-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Grandpa in My Pocket</div>
                  <img src="/programme/5564321688620938444/download/image-150.jpg" title="No Two Rings the Same: Comedy drama featuring a shrinking grandpa. Mr Mentor the Inventor invents some Brillioso Bicycle Bells. Mr Liker Biker can't help trying them all out. [AD,S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-40-00">
              <a href="/programme/cbeebies/2011-01-20/17-40-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">Chuggington: Badge Quest</div>
                  <img src="/programme/5564324265601316045/download/image-150.jpg" title="21/39. Follow the Leader: Animation in which the trains learn new skills and life lessons. Koko leads Brewster and Wilson in their delivery of the morning paper. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-45-00">
              <a href="/programme/cbeebies/2011-01-20/17-45-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Driver Dan's Story Train</div>
                  <img src="/programme/5564325554091504846/download/image-150.jpg" title="Puddle Muddle: Driver Dan goes on an exciting journey to Story Corner. The Vrooms come to the rescue when their friend is stuck in a puddle. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="18-00-00">
              <a href="/programme/cbeebies/2011-01-20/18-00-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Waybuloo</div>
                  <img src="/programme/5564329419562071247/download/image-150.jpg" title="CBeebies Bedtime Hour. Dance: Series set in the magical land of Nara. Nok Tok tries to dance like Lau Lau, but he can't. Instead he accidentally creates his own dance, that everyone wants to do. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="18-20-00">
              <a href="/programme/cbeebies/2011-01-20/18-20-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">In the Night Garden</div>
                  <img src="/programme/5564334573522826448/download/image-150.jpg" title="CBeebies Bedtime Hour. Trubliphone Fun: The garden is very noisy when Igglepiggle goes out for a walk. Soon he goes too far and gets lost, so the Pontipines use the Trubliphone to help. [S]"><br>

                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="18-50-00">
              <a href="/programme/cbeebies/2011-01-20/18-50-00" style="text-decoration: none">
                <div style="height: 94px; border: 1px dashed">
                  <div class="proghead">CBeebies Bedtime Stories</div>
                  <img src="/programme/5564342304463959249/download/image-150.jpg" title="CBeebies Bedtime Hour. The Girl with the Bird's Nest Hair: An exciting story read by a special guest. Kimberly Walsh reads The Girl with the Bird's Nest Hair, by Sarah Dyer. [S]"><br>

                </div>
              </a>


          </td>

          <td valign="top" width=152>


              <div style="height: 720px">&nbsp;</div>
              <a name="07-00-00">
              <a href="/programme/cbbc/2011-01-20/07-00-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Arthur</div>

                  <img src="/programme/5564159338051781028/download/image-150.jpg" title="The Boy with His Head in the Clouds/More!: Animated adventures of a young aardvark and friends. George learns that other people have dyslexia. DW is thrilled to receive an allowance. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="07-25-00">
              <a href="/programme/cbbc/2011-01-20/07-25-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Hedz</div>

                  <img src="/programme/5564165780502725029/download/image-150.jpg" title="Children's comedy sketch show, featuring 'celebrities' with bizarre personalities, wobbly bodies and giant heads. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="07-45-00">
              <a href="/programme/cbbc/2011-01-20/07-45-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">The Story of Tracy Beaker</div>

                  <img src="/programme/5564170934463480230/download/image-150.jpg" title="Drama about a young girl and her life in a children's home. Tracy is less than keen on an elderly pair of potential foster parents. [AD,S] Followed by Newsround."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="08-00-00">
              <a href="/programme/cbbc/2011-01-20/08-00-00" style="text-decoration: none">
                <div style="height: 418px; border: 1px dashed">
                  <div class="proghead">Deadly 60</div>

                  <img src="/programme/5564174799934046632/download/image-150.jpg" title="Costa Rica: Wildlife series. Steve is strangled by a boa, gets close to a poisonous frog and is nearly nipped by a blood-sucking vampire in the Costa Rica jungle. [S] Followed by Newsround."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="08-35-00">
              <a href="/programme/cbbc/2011-01-20/08-35-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Bear Behaving Badly</div>

                  <img src="/programme/5564183819365368234/download/image-150.jpg" title="8/13. Radio Doris: Comedy series. It is a hot day and everyone is moving to the beat of Radio Doris, the latest station to hit the airwaves, thanks to DJ Crazy Keith. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="09-00-00">
              <a href="/programme/cbbc/2011-01-20/09-00-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Copycats</div>

                  <img src="/programme/5564190261816312235/download/image-150.jpg" title="Two families battle it out in a range of hilarious games based on the idea of Chinese Whispers and involving anything from remote control football boots to motorized toilets. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="09-25-00">
              <a href="/programme/cbbc/2011-01-20/09-25-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Richard Hammond's Blast Lab</div>

                  <img src="/programme/5564196704267256236/download/image-150.jpg" title="2/13. Science game show. Two teams of budding young scientists test the power of magnetic attraction by attempting to attach a host of household objects to a giant magnet. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="09-55-00">
              <a href="/programme/cbbc/2011-01-20/09-55-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Relic: Guardians of the Museum</div>

                  <img src="/programme/5564204435208389037/download/image-150.jpg" title="13/13. Three children from Bromley are summoned to the British Museum where they have one night to uncover the secrets of a relic held inside, but dark forces are out to get them. [AD,S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="10-25-00">
              <a href="/programme/cbbc/2011-01-20/10-25-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">M.I. High</div>

                  <img src="/programme/5564212166149521838/download/image-150.jpg" title="3/13. Evil by Design: Children's spy drama. Daisy turns green with envy when she and Rose go head-to-head in a modelling competition while investigating a dangerous new fashion craze. [S,SL]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="10-55-00">
              <a href="/programme/cbbc/2011-01-20/10-55-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Hotel Trubble</div>

                  <img src="/programme/5564219897090654639/download/image-150.jpg" title="13/13. Dribble Versus Trubble: Children's sitcom. The evil staff of Hotel Dribble run a dastardly campaign to put Hotel Trubble out of business. Can Jamie, Sally and the others save the day? [S,SL]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="11-25-00">
              <a href="/programme/cbbc/2011-01-20/11-25-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">The Legend of Dick and Dom</div>

                  <img src="/programme/5564227628031787440/download/image-150.jpg" title="13/13. Dr Cheese: Children's sitcom. After months of searching for ingredients, the potion is finally complete - but will it work? The heroes return to the kingdom of Fyredor to try it out. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="11-50-00">
              <a href="/programme/cbbc/2011-01-20/11-50-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">The Slammer</div>

                  <img src="/programme/5564234070482731441/download/image-150.jpg" title="13/13. Children's comedy set in a mock prison, guest starring Mark Benton. Acts performing in the Freedom Show include a musical juggler, a physical comedian and a junior rock band. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="12-20-00">
              <a href="/programme/cbbc/2011-01-20/12-20-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Roar</div>

                  <img src="/programme/5564241801423864242/download/image-150.jpg" title="Wildlife series. A beautiful baby tapir has a nasty infection, Johny Pitts finds a giant glitter ball in the Diana monkey enclosure, and Rani goes to meet the new baby kudu. [S,SL]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="12-50-00">
              <a href="/programme/cbbc/2011-01-20/12-50-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Junior MasterChef: The Final</div>

                  <img src="/programme/5564249532364997150/download/image-150.jpg" title="13/13. The four best chefs attempt to dazzle presenters John Torode and Nadia Sawalha with their best three-course menus ever. Who will be crowned Junior MasterChef Champion 2010? [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-20-00">
              <a href="/programme/cbbc/2011-01-20/13-20-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">Bear Behaving Badly</div>

                  <img src="/programme/5564257263306129844/download/image-150.jpg" title="8/13. Radio Doris: Comedy series. It is a hot day and everyone is moving to the beat of Radio Doris, the latest station to hit the airwaves, thanks to DJ Crazy Keith. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="13-40-00">
              <a href="/programme/cbbc/2011-01-20/13-40-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Young Dracula</div>

                  <img src="/programme/5564262417266885045/download/image-150.jpg" title="13/14. Children's drama following Vlad and Ingrid, who moved to Britain with their father, Count Dracula. Vlad has to sit his first ever 'blood test' - the vampire equivalent of a GCSE. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="14-10-00">
              <a href="/programme/cbbc/2011-01-20/14-10-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">M.I. High</div>

                  <img src="/programme/5564270148208018190/download/image-150.jpg" title="3/13. Evil by Design: Children's spy drama. Daisy turns green with envy when she and Rose go head-to-head in a modelling competition while investigating a dangerous new fashion craze. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="14-40-00">
              <a href="/programme/cbbc/2011-01-20/14-40-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">Deadly 60 Bite Size</div>

                  <img src="/programme/5564277879149150991/download/image-150.jpg" title="Burrowing Owl: Steve Backshall tracks down 60 of the world's deadliest animals. The crew have a chance encounter with a tough little owl with an ingenious way of catching its supper. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="14-45-00">
              <a href="/programme/cbbc/2011-01-20/14-45-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Mona the Vampire</div>

                  <img src="/programme/5564279167639339448/download/image-150.jpg" title="Von Kreepsula Runs Amok: Cartoon series about the adventures of a ten-year-old girl who solves ghoulish mysteries. The evil Von Kreepsula escapes from his comic book prison. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="14-55-00">
              <a href="/programme/cbbc/2011-01-20/14-55-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Mona the Vampire</div>

                  <img src="/programme/5564281744619717047/download/image-150.jpg" title="Nefarious Computer Virus: Cartoon series about the adventures of a ten-year-old girl who solves ghoulish mysteries. Charley is taken over by a new computer game. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-10-00">
              <a href="/programme/cbbc/2011-01-20/15-10-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Eliot Kid</div>

                  <img src="/programme/5564285610090283449/download/image-150.jpg" title="The Villainous Vacuum: Eliot thinks the new super powerful vacuum cleaner is a voracious monster. [S] Followed by Newsround."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-25-00">
              <a href="/programme/cbbc/2011-01-20/15-25-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Arthur</div>

                  <img src="/programme/5564289475560849851/download/image-150.jpg" title="Grandpa Dave's Memory Album: Animation following the adventures of a young aardvark and his friends. Francine's grandmother helps the kids understand Grandpa Dave's memory problems. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-40-00">
              <a href="/programme/cbbc/2011-01-20/15-40-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">League of Super Evil</div>

                  <img src="/programme/5564293341031416252/download/image-150.jpg" title="Red Menacing: It is Henchman Appreciation Day, and that means Red Menace is in charge when a super secret military weapon falls into the hands of LOSE. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="15-50-00">
              <a href="/programme/cbbc/2011-01-20/15-50-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Shaun the Sheep</div>

                  <img src="/programme/5564295918011793853/download/image-150.jpg" title="Frantic Romantic: Children's animation. The farmer struggles to cook a romantic dinner. Can Shaun and the flock save the day when they take over the catering behind the scenes? [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-00-00">
              <a href="/programme/cbbc/2011-01-20/16-00-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">What's New Scooby-Doo?</div>

                  <img src="/programme/5564298494992172135/download/image-150.jpg" title="Gentlemen Start Your Monsters: Children's animated series about a group of teenage sleuths and their cowardly dog. A car race turns out to be more dangerous than usual. [S] Followed by Newsround."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-25-00">
              <a href="/programme/cbbc/2011-01-20/16-25-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Prank Patrol Down Under</div>

                  <img src="/programme/5564304937443115455/download/image-150.jpg" title="15/26. Lousy Laundry: Australia's version of the prank show. Oakley pranks her cousin Danielle at a laundrette, where they help with a service wash for Kylie. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="16-50-00">
              <a href="/programme/cbbc/2011-01-20/16-50-00" style="text-decoration: none">
                <div style="height: 118px; border: 1px dashed">
                  <div class="proghead">Deadly 60 Bite Size</div>

                  <img src="/programme/5564311379894059793/download/image-150.jpg" title="Peregrine Falcon: Series in which wildlife presenter Steve Backshall tracks down 60 of the world's deadliest animals. Here, he races a peregrine falcon in a sports car. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-00-00">
              <a href="/programme/cbbc/2011-01-20/17-00-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">
                  <div class="proghead">The Story of Tracy Beaker</div>

                  <img src="/programme/5564313956874437057/download/image-150.jpg" title="Drama about a young girl and her life in a children's home. Tracy is less than keen on an elderly pair of potential foster parents - until it seems that someone else may benefit. [AD,S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-20-00">
              <a href="/programme/cbbc/2011-01-20/17-20-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">The Slammer</div>

                  <img src="/programme/5564319110835192594/download/image-150.jpg" title="7/15. Slammer Power: Entertainment show in which entertainers enter a mock prison. The electricity bill is sky high, will the Freedom Show be left in the dark? [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="17-50-00">
              <a href="/programme/cbbc/2011-01-20/17-50-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Animals at Work</div>

                  <img src="/programme/5564326841776325059/download/image-150.jpg" title="2/13. Snowball Dancing Cockatoo: Factual series. Snowball, the dancing cockatoo, gears up for a very important show. Sally, the plumber ferret, teaches her apprentices how it's done. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="18-20-00">
              <a href="/programme/cbbc/2011-01-20/18-20-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">
                  <div class="proghead">Paradise Cafe</div>

                  <img src="/programme/5564334572717457860/download/image-150.jpg" title="4/13. Angel Power: Angel, a ghost pro-wrestler, wants to prove she's the greatest wrestler of all time. Tai agrees to take her on, but the girls are worried that Angel is too much for him. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="18-45-00">
              <a href="/programme/cbbc/2011-01-20/18-45-00" style="text-decoration: none">
                <div style="height: 58px; border: 1px dashed">
                  <div class="proghead">Deadly 60 Bite Size</div>

                  <img src="/programme/5564341015168402213/download/image-150.jpg" title="Fat-Tailed Scorpions: Wildlife presenter Steve Backshall tracks down 60 of the world's deadliest animals. Steve coaxes a fat-tailed scorpion out of his burrow. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="18-50-00">
              <a href="/programme/cbbc/2011-01-20/18-50-00" style="text-decoration: none">
                <div style="height: 94px; border: 1px dashed">
                  <div class="proghead">Newsround</div>

                  <img src="/programme/5564342303658590661/download/image-150.jpg" title="Topical news magazine for children. [S]"><br>
                </div>
              </a>


          </td>

          <td valign="top" width=152>


              <div style="height: 9336px">&nbsp;</div>
              <a name="18-58-00">
              <a href="/programme/bbcthree/2011-01-20/18-58-00" style="text-decoration: none">
                <div style="height: 22px; border: 1px dashed">

                  <div class="proghead">This Is BBC Three</div>
                  <img src="/programme/5564344365221907908/download/image-150.jpg" title="BBC Three. The best in new entertainment, comedy, contemporary drama and music for the digital generation. Stay tuned for 60 Seconds news."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="19-00-00">
              <a href="/programme/bbcthree/2011-01-20/19-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">

                  <div class="proghead">Top Gear</div>
                  <img src="/programme/5564344880617983472/download/image-150.jpg" title="3/6. Jeremy Clarkson, Richard Hammond and James May attempt to find the world's greatest four-seat supercar. Plus Richard is on the test track in two very different muscle cars. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="20-00-00">
              <a href="/programme/bbcthree/2011-01-20/20-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">

                  <div class="proghead">Great Movie Mistakes 2: The Sequel</div>
                  <img src="/programme/5564360342500248906/download/image-150.jpg" title="2/11. Robert Webb exposes more of the cinematic gaffes that the film studios hoped they had got away with in films such as Avatar, Shutter Island, The Karate Kid and Star Trek. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="21-00-00">
              <a href="/programme/bbcthree/2011-01-20/21-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">

                  <div class="proghead">How Drugs Work: Cocaine</div>
                  <img src="/programme/5564375804382514673/download/image-150.jpg" title="3/3. Documentary using visual effects and CGI to examine the effects of cocaine on the body. Contains adult themes. Also in HD. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="22-00-00">
              <a href="/programme/bbcthree/2011-01-20/22-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">

                  <div class="proghead">EastEnders</div>
                  <img src="/programme/5564391266264780108/download/image-150.jpg" title="The police question Ricky and Carol about last night's terrible events whilst the family try desperately to track down a missing Bianca. Tamwar makes a bold declaration. Also in HD. [AD,S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="22-30-00">
              <a href="/programme/bbcthree/2011-01-20/22-30-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">

                  <div class="proghead">Ready Steady Drink</div>
                  <img src="/programme/5564398997205913074/download/image-150.jpg" title="Emily Atack looks at the UK's culture of drinking games and asks if they should be banned. Contains adult themes. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="23-30-00">
              <a href="/programme/bbcthree/2011-01-20/23-30-00" style="text-decoration: none">
                <div style="height: 298px; border: 1px dashed">

                  <div class="proghead">Family Guy</div>
                  <img src="/programme/5564414459088178510/download/image-150.jpg" title="7/7. Brian: Portrait of a Dog: Subversive animated comedy about family life. Peter gets Brian to enter a dog show, but when they argue over a trick gone bad Brian walks out on the family. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="23-55-00">
              <a href="/programme/bbcthree/2011-01-20/23-55-00" style="text-decoration: none">
                <div style="height: 238px; border: 1px dashed">

                  <div class="proghead">Family Guy</div>
                  <img src="/programme/5564420901539122511/download/image-150.jpg" title="1/21. Peter, Peter Caviar Eater: Animated comedy series about family life. The Griffins rub shoulders with the rich when Lois's aunt bequeaths the family her mansion. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="00-15-00">
              <a href="/programme/bbcthree/2011-01-21/00-15-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">

                  <div class="proghead">How Drugs Work: Cocaine</div>
                  <img src="/programme/5564426055499877875/download/image-150.jpg" title="3/3. Documentary using visual effects and CGI to examine the effects of cocaine on the body. Contains adult themes. Also in HD. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="01-15-00">
              <a href="/programme/bbcthree/2011-01-21/01-15-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">

                  <div class="proghead">Great Movie Mistakes 2: The Sequel</div>
                  <img src="/programme/5564441517382143313/download/image-150.jpg" title="2/11. Robert Webb exposes more of the cinematic gaffes that the film studios hoped they had got away with in films such as Avatar, Shutter Island, The Karate Kid and Star Trek. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="02-15-00">
              <a href="/programme/bbcthree/2011-01-21/02-15-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">

                  <div class="proghead">Ready Steady Drink</div>
                  <img src="/programme/5564456979264409076/download/image-150.jpg" title="Emily Atack looks at the UK's culture of drinking games and asks if they should be banned. Contains adult themes. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="03-15-00">
              <a href="/programme/bbcthree/2011-01-21/03-15-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">

                  <div class="proghead">Hotter Than My Daughter</div>
                  <img src="/programme/5564472441146674677/download/image-150.jpg" title="1/8. Makeover series about warring mothers and daughters. Sinead is mortified by her mum Caroline, who is never happier than when she's out wearing skimpy clothing. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="03-45-00">
              <a href="/programme/bbcthree/2011-01-21/03-45-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">

                  <div class="proghead">Most Annoying People 2010</div>
                  <img src="/programme/5564480172087807478/download/image-150.jpg" title="10/10. The most authoritative and irreverent review of the year is back. Which A-listers, D-listers, sports stars, pop stars and politicians got under our skin in the last twelve months? [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="04-15-00">
              <a href="/programme/bbcthree/2011-01-21/04-15-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">

                  <div class="proghead">Sun, Sex and Suspicious Parents</div>
                  <img src="/programme/5564487903028940125/download/image-150.jpg" title="3/6. Ayia Napa: Ladies man David and rugby lad Greg party hard with their mates in Ayia Napa. Contains strong language. [S,SL]"><br>
                </div>
              </a>


          </td>

          <td valign="top" width=152>


              <div style="height: 9360px">&nbsp;</div>
              <a name="19-00-00">

              <a href="/programme/bbcfour/2011-01-20/19-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">World News Today</div>
                  <img src="/programme/5564344881435961891/download/image-150.jpg" title="The latest national and international news, exploring the day's events from a global perspective. [S] Followed by weather."><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="19-30-00">

              <a href="/programme/bbcfour/2011-01-20/19-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Barbados at the Races: Storyville</div>
                  <img src="/programme/5564352612377094692/download/image-150.jpg" title="3/4. Run Cat Run!: The series showing Barbados through its horse racing community looks at how a new breed of small trainer is determined to break into the exclusive Turf Club. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="20-00-00">

              <a href="/programme/bbcfour/2011-01-20/20-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Beautiful Equations</div>
                  <img src="/programme/5564360343318227560/download/image-150.jpg" title="Art critic Matt Collings explores the most famous equations in science and realises that concepts of beauty and elegance have been used by many scientists to advance their work. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="21-00-00">

              <a href="/programme/bbcfour/2011-01-20/21-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">The Brain: A Secret History</div>
                  <img src="/programme/5564375805200493094/download/image-150.jpg" title="3/3. Broken Brains: A look at how experiments on abnormal brains can reveal the workings of the normal brain. Contains disturbing scenes. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="22-00-00">

              <a href="/programme/bbcfour/2011-01-20/22-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Five Daughters</div>
                  <img src="/programme/5564391267082758695/download/image-150.jpg" title="3/3. Bodies, thought to be those of Annette Nicholls and Paula Clenell, are discovered. Contains some strong language and some upsetting scenes. [AD,S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="23-00-00">

              <a href="/programme/bbcfour/2011-01-20/23-00-00" style="text-decoration: none">
                <div style="height: 898px; border: 1px dashed">
                  <div class="proghead">Le diner de cons</div>
                  <img src="/programme/5564406728965024361/download/image-150.jpg" title="A group of friends compete over who can bring the most stupid person to dinner. In French with English subtitles. Contains some strong language. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="00-15-00">

              <a href="/programme/bbcfour/2011-01-21/00-15-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">The Brain: A Secret History</div>
                  <img src="/programme/5564426056317856484/download/image-150.jpg" title="3/3. Broken Brains: A look at how experiments on abnormal brains can reveal the workings of the normal brain. Contains disturbing scenes. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="01-15-00">

              <a href="/programme/bbcfour/2011-01-21/01-15-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">Beautiful Equations</div>
                  <img src="/programme/5564441518200122192/download/image-150.jpg" title="Art critic Matt Collings explores the most famous equations in science and realises that concepts of beauty and elegance have been used by many scientists to advance their work. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="02-15-00">

              <a href="/programme/bbcfour/2011-01-21/02-15-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Barbados at the Races: Storyville</div>
                  <img src="/programme/5564456980082387499/download/image-150.jpg" title="3/4. Run Cat Run!: The series showing Barbados through its horse racing community looks at how a new breed of small trainer is determined to break into the exclusive Turf Club. [S]"><br>
                </div>
              </a>


              <div style="height: 0px">&nbsp;</div>
              <a name="02-45-00">

              <a href="/programme/bbcfour/2011-01-21/02-45-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">The Brain: A Secret History</div>
                  <img src="/programme/5564464711023520300/download/image-150.jpg" title="3/3. Broken Brains: A look at how experiments on abnormal brains can reveal the workings of the normal brain. Contains disturbing scenes. [S,SL]"><br>
                </div>
              </a>


          </td>

          <td valign="top" width=152>



              <div style="height: 0px">&nbsp;</div>
              <a name="06-00-00">
              <a href="/programme/bbcnews24/2011-01-20/06-00-00" style="text-decoration: none">
                <div style="height: 1798px; border: 1px dashed">
                  <div class="proghead">Breakfast</div>
                  <img src="/programme/5564143876152727787/download/image-150.jpg" title="All the latest news, sport, business and weather from the BBC's Breakfast team. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="08-30-00">
              <a href="/programme/bbcnews24/2011-01-20/08-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564182530858391788/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="09-00-00">
              <a href="/programme/bbcnews24/2011-01-20/09-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564190261799524589/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="10-00-00">
              <a href="/programme/bbcnews24/2011-01-20/10-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564205723681790190/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="11-00-00">
              <a href="/programme/bbcnews24/2011-01-20/11-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564221185564055791/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="12-00-00">
              <a href="/programme/bbcnews24/2011-01-20/12-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564236647446321392/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="13-00-00">
              <a href="/programme/bbcnews24/2011-01-20/13-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News at One</div>
                  <img src="/programme/5564252109328586993/download/image-150.jpg" title="The latest national and international news stories from the BBC News team, followed by weather. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="13-30-00">
              <a href="/programme/bbcnews24/2011-01-20/13-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564259840269719794/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="14-00-00">
              <a href="/programme/bbcnews24/2011-01-20/14-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564267571210852595/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="15-00-00">
              <a href="/programme/bbcnews24/2011-01-20/15-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564283033093118196/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="16-00-00">
              <a href="/programme/bbcnews24/2011-01-20/16-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564298494975383797/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="17-00-00">
              <a href="/programme/bbcnews24/2011-01-20/17-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News at Five O'Clock</div>
                  <img src="/programme/5564313956857649398/download/image-150.jpg" title="Presented by Huw Edwards, with in-depth discussions and analysis as well as breaking news. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="18-00-00">
              <a href="/programme/bbcnews24/2011-01-20/18-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News at Six</div>
                  <img src="/programme/5564329418739914999/download/image-150.jpg" title="The latest national and international news stories from the BBC News team, followed by weather. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="18-30-00">
              <a href="/programme/bbcnews24/2011-01-20/18-30-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564337149681047800/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="18-45-00">
              <a href="/programme/bbcnews24/2011-01-20/18-45-00" style="text-decoration: none">
                <div style="height: 178px; border: 1px dashed">
                  <div class="proghead">Sportsday</div>
                  <img src="/programme/5564341015151614201/download/image-150.jpg" title="A round-up of the day's sporting events. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="19-00-00">
              <a href="/programme/bbcnews24/2011-01-20/19-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564344880622180602/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="20-00-00">
              <a href="/programme/bbcnews24/2011-01-20/20-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564360342504446203/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="21-00-00">
              <a href="/programme/bbcnews24/2011-01-20/21-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564375804386711804/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="22-00-00">
              <a href="/programme/bbcnews24/2011-01-20/22-00-00" style="text-decoration: none">
                <div style="height: 718px; border: 1px dashed">
                  <div class="proghead">BBC News at Ten</div>
                  <img src="/programme/5564391266268977405/download/image-150.jpg" title="The latest national and international news from the BBC with Sportsday at 10.30, plus the day's business news and the first review of the next morning's newspapers. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="23-00-00">
              <a href="/programme/bbcnews24/2011-01-20/23-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564406728151243006/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="23-30-00">
              <a href="/programme/bbcnews24/2011-01-20/23-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">HARDtalk</div>
                  <img src="/programme/5564414459092375807/download/image-150.jpg" title="Zambian economist and author Dambisa Moyo believes western nations are heading for second division status unless they undertake radical reform. She talks to Stephen Sackur. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="00-00-00">
              <a href="/programme/bbcnews24/2011-01-21/00-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564422190033508608/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="00-30-00">
              <a href="/programme/bbcnews24/2011-01-21/00-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC World News America</div>
                  <img src="/programme/5564429920974641409/download/image-150.jpg" title="Comprehensive news and analysis with Matt Frei and Katty Kay. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="01-00-00">
              <a href="/programme/bbcnews24/2011-01-21/01-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564437651915774210/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="01-30-00">
              <a href="/programme/bbcnews24/2011-01-21/01-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">ABC World News with Diane Sawyer</div>
                  <img src="/programme/5564445382856907011/download/image-150.jpg" title="The latest news from America, as reported by the ABC television network's flagship evening news programme. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="02-00-00">
              <a href="/programme/bbcnews24/2011-01-21/02-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564453113798039812/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="02-30-00">
              <a href="/programme/bbcnews24/2011-01-21/02-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">The Record</div>
                  <img src="/programme/5564460844739172613/download/image-150.jpg" title="Highlights of Thursday 20 January in Parliament, presented by Alicia McCarthy. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="03-00-00">
              <a href="/programme/bbcnews24/2011-01-21/03-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564468575680305414/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="03-30-00">
              <a href="/programme/bbcnews24/2011-01-21/03-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">Return to White Horse Village</div>
                  <img src="/programme/5564476306621440438/download/image-150.jpg" title="Carrie Gracie returns to White Horse Village in China to witness its recent transformation from a place cut off from the rest of the world to a modern high-rise city. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="04-00-00">
              <a href="/programme/bbcnews24/2011-01-21/04-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">BBC News</div>
                  <img src="/programme/5564484037562571016/download/image-150.jpg" title="Twenty-four hours a day, the latest national and international stories as they break. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="04-30-00">
              <a href="/programme/bbcnews24/2011-01-21/04-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">HARDtalk</div>
                  <img src="/programme/5564491768503703817/download/image-150.jpg" title="In Tunisia the interim national unity government is condemned as a sham. Stephen Sackur talks to a member of that government, the minister for regional development Najib Chebbi. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="05-00-00">
              <a href="/programme/bbcnews24/2011-01-21/05-00-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">The World Today</div>
                  <img src="/programme/5564499499444836618/download/image-150.jpg" title="The latest international news. [S]"><br>
                </div>
              </a>



              <div style="height: 0px">&nbsp;</div>
              <a name="05-30-00">
              <a href="/programme/bbcnews24/2011-01-21/05-30-00" style="text-decoration: none">
                <div style="height: 358px; border: 1px dashed">
                  <div class="proghead">World Business Report</div>
                  <img src="/programme/5564507230385969419/download/image-150.jpg" title="The latest business news from around the world, with live reports from Singapore, Frankfurt and London, and news of what happened overnight in New York. [S]"><br>
                </div>
              </a>



          </td>

      </tr></table>
      </body>
    </html>


    }
  end

end
