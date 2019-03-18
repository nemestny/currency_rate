class ForcedRate < Rate

  validates(
    :expires_at,
    timeliness:
    {
      type: :datetime,
      after: -> { Time.current },
      allow_blank: false,
      after_message: 'time is wrong'
    }
  )
end
