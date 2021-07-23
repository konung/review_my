class Snippets::NewPage < Private::WrappedLayout
  needs save_snippet : SaveSnippet

  def page_title
    "New Snippet"
  end

  def content
    section class: "px-2 sm:px-6" do
      render_form(@save_snippet)
    end
  end

  private def render_form(op)
    form_for Snippets::Create, class: "flex-1 flex flex-col space-y-6" do
      mount Shared::Field, op.title, &.text_input(autofocus: true, placeholder: "A short and sweet summary of your snippet")

      render_domain_restriction_checkbox(op)
      render_revision_deadline_datetime(op)
      render_content_editor(op)

      submit "Create", class: "bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end

  private def render_revision_deadline_datetime(op)
    mount Shared::Field,
      op.revision_deadline,
      "Revision deadline (when you plan to send your message)", &.datetime_input(
      data_controller: "flatpickr",
      data_flatpickr_enable_time: true,
      data_flatpickr_date_format: "Z",
      data_flatpickr_alt_format: "M J, Y at h:i K",
      data_flatpickr_alt_input: true,
      data_flatpickr_min_date: Time.utc.to_s
    )
  end

  private def render_content_editor(op)
    div do
      div class: "hidden" do
        mount Shared::Field, op.content, &.textarea
      end

      mount Shared::FieldLabel, op.content
      mount Shared::FieldErrors, op.content
      tag("trix-editor", input: "snippet_content", class: "trix-content", placeholder: "Your snippet content")
    end
  end

  private def render_domain_restriction_checkbox(op)
    div class: "relative flex items-start" do
      div class: "flex items-center h-5" do
        checkbox(op.domain_restricted, class: "form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out")
      end

      div class: "ml-3 text-sm leading-5" do
        mount Shared::FieldLabel, op.domain_restricted, "Private"
        para "Restrict revision submissions to users with your domain (#{current_user.email_domain})", class: "text-gray-500"
      end
    end
  end
end
