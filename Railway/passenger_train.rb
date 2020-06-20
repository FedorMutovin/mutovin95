require_relative 'train'

class PassengerTrain < Train
  def initialize(passenger_train)
    @passenger_train = passenger_train
  end
end
