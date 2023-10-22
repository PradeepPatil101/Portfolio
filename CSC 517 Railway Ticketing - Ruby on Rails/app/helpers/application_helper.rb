module ApplicationHelper

  # To format the train time.
     def format_time(time)
      time.strftime("%I:%M %p")
     end

  # To format the train data to MM-DD-YY
  def format_date(date)
    date.strftime("%m-%d-%Y")
  end

  def us_states_options
    [
      ['AL', 'AL'],
      ['AK', 'AK'],
      ['AZ', 'AZ'],
      ['AR', 'AR'],
      ['CA', 'CA'],
      ['CO', 'CO'],
      ['CT', 'CT'],
      ['DE', 'DE'],
      ['FL', 'FL'],
      ['GA', 'GA'],
      ['HI', 'HI'],
      ['ID', 'ID'],
      ['IL', 'IL'],
      ['IN', 'IN'],
      ['IA', 'IA'],
      ['KS', 'KS'],
      ['KY', 'KY'],
      ['LA', 'LA'],
      ['ME', 'ME'],
      ['MD', 'MD'],
      ['MA', 'MA'],
      ['MI', 'MI'],
      ['MN', 'MN'],
      ['MS', 'MS'],
      ['MO', 'MO'],
      ['MT', 'MT'],
      ['NE', 'NE'],
      ['NV', 'NV'],
      ['NH', 'NH'],
      ['NJ', 'NJ'],
      ['NM', 'NM'],
      ['NY', 'NY'],
      ['NC', 'NC'],
      ['ND', 'ND'],
      ['OH', 'OH'],
      ['OK', 'OK'],
      ['OR', 'OR'],
      ['PA', 'PA'],
      ['RI', 'RI'],
      ['SC', 'SC'],
      ['SD', 'SD'],
      ['TN', 'TN'],
      ['TX', 'TX'],
      ['UT', 'UT'],
      ['VT', 'VT'],
      ['VA', 'VA'],
      ['WA', 'WA'],
      ['WV', 'WV'],
      ['WI', 'WI'],
      ['WY', 'WY']
    ]
  end
end
