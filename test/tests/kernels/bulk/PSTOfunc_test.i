[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 4
  ny = 4
  nz = 2
  xmin = -1
  xmax = 1
  ymin = -1
  ymax = 1
  zmin = -0.5
  zmax = 0.5
  elem_type = HEX8
[]

[GlobalParams]
  alpha1 = 0.00126
  alpha2 = 1.76  
  alpha3 = 3.73
  alpha4 = -.591
  alpha5 = -.651
  x1 = -4.18
  x2 = -36.9
  x3 = -251
  x4 = 121
  x5 = 2410
  x6 = 6490
  len_scale = 1.0
  G110 = 0.173
  G11/G110 = 2.0
  G12/G110 = 0
  G44/G110 = 1.0
  G44P/G110 = 1.0
  T = 0.0
  epsilon = 0.01
  polar_x = polar_x
  polar_y = polar_y
  permittivity = 0.00885
  potential_int = potential_int
[]



[Variables]
  [./polar_x]
    order = FIRST
    family = LAGRANGE
    block = '0'
    [./InitialCondition]
      type = ConstantIC
      value = 0.05
    [../]
  [../]
  [./polar_y]
    order = FIRST
    family = LAGRANGE
    block = '0'
    [./InitialCondition]
      type = ConstantIC
      value = 0.05
    [../]
  [../]
  [./polar_z]
    order = FIRST
    family = LAGRANGE
    block = '0'
    [./InitialCondition]
      type = ConstantIC
      value = 0.05
    [../]
  [../]
  [./potential_int]
    order = FIRST
    family = LAGRANGE
    [./InitialCondition]
      type = ConstantIC
      value = 0.0005
    [../]
  [../]
[]

[Kernels]
  [./bed_x]
    type = BulkEnergyDerivativePSTO
    variable = polar_x
    component = 0
  [../]
  [./bed_y]
    type = BulkEnergyDerivativePSTO
    variable = polar_y
    component = 1
  [../]
  [./bed_z]
    type = BulkEnergyDerivativePSTO
    variable = polar_z
    component = 2
  [../]
  [./polar_x_electric_E]
     type = PolarElectricEStrong
     variable = potential_int
     block = '0'
  [../]
  [./FE_E_int]
     type = Electrostatics
     variable = potential_int
     block = '0'
  [../]
  [./polar_electric_px]
     type = PolarElectricPStrong
     variable = polar_x
     component = 0
  [../]
  [./polar_electric_py]
     type=PolarElectricPStrong
     variable = polar_y
     component = 1
  [../]
  [./polar_electric_pz]
     type = PolarElectricPStrong
     variable = polar_z
     component = 2
  [../]
  [./polar_x_time]
     type = TimeDerivativeScaled
     variable = polar_x
    time_scale = 1.0
  [../]
  [./polar_y_time]
     type = TimeDerivativeScaled
     variable = polar_y
    time_scale = 1.0
  [../]
  [./polar_z_time]
     type = TimeDerivativeScaled
     variable = polar_z
    time_scale = 1.0
  [../]
[]


[BCs]
  [./potential_cube5]
    type = DirichletBC
    boundary = 'front'
    value = 0.0002
    variable = potential_int
  [../]
  [./potential_cube6]
    type = DirichletBC
    boundary = 'back'
    value = 0.0002
    variable = potential_int
  [../]
[]


[Preconditioning]
  [./smp]
    type = SMP
    full = true
    petsc_options_iname = '-ksp_gmres_restart -snes_atol  -snes_rtol -ksp_rtol -pc_type  -pc_hypre_type  '
    petsc_options_value = '    121               1e-10          1e-8      1e-6   hypre      boomeramg   '
  [../]
[]

[Executioner]
  type = Transient
  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.2
    optimal_iterations = 4
    growth_factor = 1.4
    linear_iteration_ratio = 100
    cutback_factor =  0.55
  [../]
  solve_type = 'NEWTON'       #"PJFNK, JFNK, NEWTON"
  scheme = 'implicit-euler'   #"implicit-euler, explicit-euler, crank-nicolson, bdf2, rk-2"
  dtmin = 1e-13
  dtmax = 0.5
  num_steps = 5
[]

[Outputs]
  print_linear_residuals = false
  print_perf_log = true
  [./out]
    type = Exodus
    file_base = out_PSTOfunc_test
    elemental_as_nodal = true
  [../]
[]