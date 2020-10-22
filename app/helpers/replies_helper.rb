module RepliesHelper
  def delete_reply(reply)
    if current_user?(reply.user)

      link_to tweet_reply_path(:tweet_id, reply.id), method: :delete, data: { confirm: 'Are you sure you want to delete this tweet?' } do
        raw(" <span class='icon'>
                    <i class='fa fa-trash-o' aria-hidden='true'></i>
                </span>")
      end
    end
  end
end
