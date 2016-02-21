# encoding: utf-8

class SubmissionsController < ApplicationController
  before_action :admin_required
  layout "admin"

  def index
    @query_params = params[:q] || {}
    @query = Submission.ransack(@query_params)
    @query.sorts = ['received asc'] if @query.sorts.empty?
    @submissions = @query.result(distinct: true)
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def new
    @submission = Submission.new
    @submission.received = Time.now
    @submission.status = 'nadesłany'
    @author_id = params[:author_id]
  end

  def create
    @submission = Submission.new(submission_params)
    @author_id = params[:author_id]
    if @submission.save
      if @author_id
        authorship = Authorship.new(person_id: @author_id,submission: @submission)
        authorship.save
      end
      redirect_to @submission
    else
      render :new
    end
  end

  def edit
    @submission = Submission.find(params[:id])
  end

  def update
    @submission = Submission.find(params[:id])
    prevStatus = @submission.status

    if @submission.update_attributes(submission_params)
      if @submission.status == 'przyjęty' and @submission.status != prevStatus
        person = @submission.person
        SubmissionMailer.contract(person).deliver_now
        redirect_to @submission, flash: {notice: "Umowa została wysłana"}
      end
      redirect_to @submission
    else
      render :edit
    end
  end

  def destroy
    submission = Submission.find(params[:id])
    submission.destroy
    redirect_to submissions_path
  end



  private
  def submission_params
    params.require(:submission).permit(:issue_id,:status,:language,:received,:funding,
                                       :remarks,:polish_title,:english_title,:english_abstract,
                                       :english_keywords,:person_id)
  end

end
