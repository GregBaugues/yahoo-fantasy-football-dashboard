require 'spec_helper'

ITEM_XML = %q{
    <item>
      <guid isPermaLink="false">239301</guid>
      <link>http://www.rotoworld.com/player/nfl/4638/kevin-smith</link>
      <title>Report: Lions working phones for running back - Kevin Smith | DET</title>
      <description>CBS Sports' Jason LaCanfora reports Lions GM Martin Mayhew has been calling other teams in search of a running back.</description>
      <a10:updated>2012-08-28T14:41:00-04:00</a10:updated>
    </item>
}

describe Article do

  it 'should create an article from rotoworld xml item' do
    article = Article.from_rotoworld(ITEM_XML)
    article.title.should =~ /Lions working/
    article.published.should be_a Time
    article.link.should =~ /http:/
    article.description.should =~ /CBS Sports/
  end

  it 'should not create the same article twice' do
    2.times { Article.from_rotoworld(ITEM_XML) }
    Article.all.count.should eq 1
  end

  it 'should get new articles' do
    Article.get_new
  end

end
