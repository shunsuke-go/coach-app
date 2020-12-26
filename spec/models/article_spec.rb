require 'rails_helper'

RSpec.describe Article, type: :model do  
  describe '#create' do 
    
      let(:article) { build(:article) }

    context "記事を保存できる場合" do 
      
      it "正しく保存できること" do 
        example_article = FactoryBot.create(:article) 
        expect(example_article).to be_valid  
      end
    end

    context "記事を保存できない場合" do
      
      it "タイトルが空欄だと保存できないこと" do 
        article.title = ""
        expect(article).to be_invalid  
      end

      it "タイトルが16文字以上だと保存できないこと" do 
        article.title = "a" * 16
        expect(article).to be_invalid
      end

      it "記事が空欄だと保存できないこと" do
        article.content = ""
        expect(article).to be_invalid 
      end
    end
  end
end
