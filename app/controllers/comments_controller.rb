class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @article=Article.find(params[:article_id])
    
        @comment=@article.comments.create(comment_params)
            redirect_to article_path(@article)
        authorize @comment
    end

    def edit
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        authorize @comment
      end
      
      def update
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        authorize @comment
      
        if @comment.update(comment_params)
          respond_to do |format|
            format.html { redirect_to article_path(@article), notice: "Comment updated successfully." }
            format.turbo_stream
          end
        else
          render :edit, status: :unprocessable_entity
        end
      end
      

    def destroy
        @article=Article.find(params[:article_id])
        @comment=@article.comments.find(params[:id])
        authorize @comment

        @comment.destroy
        respond_to do |format|
            format.html {redirect_to article_path(@article), status: :see_other}
            format.turbo_stream
          end

        # redirect_to article_path(@article), status: :see_other
    end 

    private
        def comment_params
            params.require(:comment).permit(:commenter,:body)
        end
end
