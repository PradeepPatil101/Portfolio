module TicketsHelper
  def departure_datetime(ticket)
    ticket.train.departure_date.to_datetime.change({
                                                     hour: ticket.train.departure_time.hour,
                                                     min: ticket.train.departure_time.min
                                                   })
  end
end