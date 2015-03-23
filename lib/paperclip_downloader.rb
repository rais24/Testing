class PaperclipDownloader < Struct.new(:name, :model)
  OPTIONS = {
              s3_protocol: "",
              s3_credentials: {
                s3_protocol: "",
                bucket: ENV['AWS_BUCKET'],
                access_key_id: ENV['AWS_ACCESS_KEY'],
                secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
              }
            }

  def swap
    @attachment.styles.each do |style|
      `#{command(style)}`
    end
  end

  private
    def command(style)
      "curl #{source_url(style)} -o #{destination_url(style)}"
    end

    def source_url(style)
      s3.url(style)
    end

    def destination_url(style)
      File.join(Rails.root, 'public', filesystem.url(style))
    end

    def filesystem
      attachment
    end

    def s3
      attachment :s3
    end

    def attachment(storage = :filesystem)
      Paperclip::Attachment.new(name, model, OPTIONS.merge(storage: storage))
    end
end