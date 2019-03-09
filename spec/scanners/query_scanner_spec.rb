require "rails_helper"
describe QueryScanner do
  it '.split_words' do
    qs = QueryScanner.new
    qs.scan("Student.where(dragon: 'puff')")
    expect(qs.send(:split_words)).to eq(%w(Student where dragon: 'puff'))
    qs.scan('"stud#{binding.pry}ent"')
    expect(qs.send(:split_words)).to eq(%w("stud binding pry ent"))
  end
  it '.keywords' do
    qs = QueryScanner.new
    qs.scan("Student.where(dragon: 'puff')")
    expect(qs.send(:keywords)).to eq(%w(Student where))
  end
end
