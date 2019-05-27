class Admin::TestsController < Admin::BaseController

   before_action :get_test, only: %i[show update destroy start]

  def index
    @tests = Test.all
  end

  def show
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    @test.author = current_user
    if @test.save
      redirect_to [:admin, @test], notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test], notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path, notice: t('.success')
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test), notice: t('.success')
  end

  private

  def get_test
    @test = Test.find(params[:id])
  end

  def get_questions
    @questions = @test.questions
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end
end