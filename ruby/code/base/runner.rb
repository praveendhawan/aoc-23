# Runner class
class Runner
  def initialize(file_path, solver_class_name = '', solver_method_name = '')
    @file_path = file_path
    @solver_class = Object.const_get(solver_class_name)
    @solver_method_name = solver_method_name
  end

  def run
    @solver_class.new(@file_path).send(@solver_method_name)
  end
end
