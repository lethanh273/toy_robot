require "thor"

require "./src/robot"

class ToyRobotClient < Thor
  desc "process FILE", "read the contents of FILE"

  def process(file)
    instructions = process_instructions(file)

    if instructions.empty?
      error 'Next'
    end

    robot = Robot.new
    instructions.each do |instruction|
      command = instruction[:command]
      parameters = (instruction[:parameters] || "").split(",")
      robot.do command.downcase, parameters
    end
  end

  private

  def parse_command(command)
    command_object = /^([A-Z]+) ?([A-Z,0-9]+)?/.match command

    if (command_object)
      parsed_object = {command: command_object[1]}
      parsed_object[:parameters] = command_object[2] if command_object[2]
    end

    parsed_object
  end

  def is_valid_command?(command)
    command && @placed == true
  end

  def error(message)
    puts message.white.on_red.blink
  end

  def process_instructions(file)
    instructions = []
    @placed = false

    begin
      File.readlines(file).map do |line|
        command = parse_command line.strip.chomp

        @placed = true if command[:command] == "PLACE"

        if is_valid_command?(command)
          instructions.push command
        end
      end

    rescue
      error "#{file} doesn't exist!"
    end
    instructions
  end
end
