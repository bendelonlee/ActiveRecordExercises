module SolutionHelper
  def solution_pretty
    solution.gsub(').', (")\n" + " " * first_word_length + '.'))
  end

  private

  def first_word_length
    solution[/\w*/].length
  end
end
