require 'spec_helper'

describe Follow do

  let!(:togo) { create(:country, name: "Africa") }
  let!(:usa) { create(:country, name: "usa") }

  let!(:fanguy) { create(:user, name: "fanguy") }
  let!(:justin_bieber) { create(:user, name: "justin bieber") }
  let!(:african_singer) { create(:user, name: "african singer") }
  
  let!(:oprah) { create(:user, name: "oprah") }


  it "a user can be followed" do
    justin_bieber.followers << fanguy
    justin_bieber.follows.count.should eq 1
    justin_bieber.followers.first.should eq fanguy
  end

  it "a follower should beable to get all their celebs" do
    fanguy.celebs << justin_bieber
    fanguy.celebs << oprah
    fanguy.celebs.count.should eq 2
    fanguy.celebs.should eq [oprah,justin_bieber]
    fanguy.celebs.first.should eq oprah
    fanguy.celebs.last.should eq justin_bieber
  end


  it "a country can be followed" do
    togo.followers << fanguy
    togo.followers.count.should eq 1
  end


  it "a follower should beable to get all the countries"do
    togo.followers << fanguy
    usa.followers << fanguy
    fanguy.following_countries.count.should eq 2
  end
  it "a follow should beable to get all the users from a country" do
    justin_bieber.countries << usa
    oprah.countries << usa
    african_singer.countries << togo

    fanguy.following_countries << [usa, togo]
    fanguy.following_countries.last.users.should eq [justin_bieber, oprah]
    fanguy.following_countries.first.users.first.should eq african_singer
  end

    it "a follow should beable to get all the users from a country using eager loading" do
    justin_bieber.countries << usa
    oprah.countries << usa
    african_singer.countries << togo

    fanguy.following_countries << [usa, togo]
    fanguy.following_countries.last.users.should eq [justin_bieber, oprah]
    fanguy.following_countries.first.users.first.should eq african_singer
  end

end