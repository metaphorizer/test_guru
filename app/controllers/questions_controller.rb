class QuestionsController < ApplicationController
  before_action :get_test, only: %i[index]
  before_action :get_question, only: %i[show]

  def index
    questions = @test.questions.pluck(:body)
    render plain: questions.join("\n")
  end

  def show
    render plain: @question.body
  end

  def new
  end

  def create
    if Question.create(question_params)
      render plain: "Question was created!"
    else
      render plain: "Question was not created!"
    end
  end

  private

  def get_test
    @test = Test.find(params[:test_id])
  end

  def get_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
