require 'spec_helper'

describe String do
  describe "#camelize" do
    it 'camelizes the given string' do
      string = "hana_moguella"
      expect(string.camelize).to eql "HanaMoguella"
      expect(string).to eql "hana_moguella"
    end
  end

  describe "#camelize!" do
    it 'camelizes destructively the given string' do
      string = "hana_moguella"
      expect(string.camelize!).to eql "HanaMoguella"
      expect(string).to eql "HanaMoguella"
    end
  end

  describe "#underscore" do
    it 'snakes the given string' do
      string = "HanaMoguella"
      expect(string.underscore).to eql "hana_moguella"
      expect(string).to eql "HanaMoguella"
    end
  end

  describe "#underscore!" do
    it 'snakes destructively the given string' do
      string = "HanaMoguella"
      expect(string.underscore!).to eql "hana_moguella"
      expect(string).to eql "hana_moguella"
    end
  end
end
