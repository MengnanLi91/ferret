
[Mesh]
  file = exodus_trilayer_8_8_8.e
[]

[GlobalParams]
  #NOTE: We use a nanometer, nanonewton, attocoulomb unit system

  len_scale = 1.0
  alpha1 = -0.1722883 # T = 298 K
  alpha11 = -0.07253
  alpha111 = 0.26
  alpha12 = 0.75
  alpha112 = 0.61
  alpha123 = -3.67

  G110 = 0.173
  G11/G110 = 0.6
  G12/G110 = 0
  G44/G110 = 0.3
  G44P/G110 = 0.3

  #miscellaneous GlobalParams options
  polar_x = polar_x
  polar_y = polar_y
  polar_z = polar_z
  potential_int = potential_int

  #applied misfit strain, negative compression
  prefactor = -0.008

  q = 0.16 # charge of the electron in attocoulombs
  n = n
  p = p
[]

[Variables]
  [./polar_x]
    block = '1'
    order = FIRST
    family = LAGRANGE
    [./InitialCondition]
      type = RandomIC
      min = -0.5e-6
      max = 0.5e-6
    [../]
  [../]
  [./polar_y]
    block = '1'
    order = FIRST
    family = LAGRANGE
    [./InitialCondition]
      type = RandomIC
      min = -0.5e-6
      max = 0.5e-6
    [../]
  [../]
  [./polar_z]
    block = '1'
    order = FIRST
    family = LAGRANGE
    [./InitialCondition]
      type = RandomIC
      min = -0.5e-6
      max = 0.5e-6
    [../]
  [../]
  [./potential_int]
    order = FIRST
    family = LAGRANGE
    block = '1 2'
  [../]

  [./n]
    block = '1 2'
    order = FIRST
    family = LAGRANGE
  [../]

  [./p]
    block = '1 2'
    order = FIRST
    family = LAGRANGE
  [../]
[]


[Kernels]
  #Bulk energy density
  [./bed_x]
    type = BulkEnergyDerivativeSixth
    variable = polar_x
    component = 0
  [../]
  [./bed_y]
    type = BulkEnergyDerivativeSixth
    variable = polar_y
    component = 1
  [../]
  [./bed_z]
    type = BulkEnergyDerivativeSixth
    variable = polar_z
    component = 2
  [../]
  ##Wall energy penalty
[./walled_x]
    type = WallEnergyDerivative
    variable = polar_x
    component = 0
 [../]
 [./walled_y]
    type = WallEnergyDerivative
    variable = polar_y
    component = 1
  [../]
  [./walled_z]
     type = WallEnergyDerivative
     variable = polar_z
     component = 2
  [../]
  ##Electrostatics
  [./polar_x_electric_E]
     type = PolarElectricEStrong
     variable = potential_int
     #permittivity = 0.0575522155 #er = 6.5
     block = '1'
  [../]
  [./FE_E_int]
     type = Electrostatics
     variable = potential_int
     block = '1'
     permittivity = 0.0575522155 #er = 6.5
  [../]

  [./semi_E_int]
     type = Electrostatics
     variable = potential_int
     block  = '2'
     permittivity = 0.44270935 #er = 50
  [../]

  [./poten_Na_2]
     type = AcceptorIonContribution
       variable = potential_int
     block  = '2'
       Na = 0.00001
  [../]

  [./free_block_1]
     type = FreeChargeContribution
     variable = potential_int
     block  = '1'
  [../]
  [./free_block_2]
     type = FreeChargeContribution
     variable = potential_int
     block  = '2'
  [../]
  [./hole_block_1]
     type = HoleChargeContribution
     variable = potential_int
     block  = '1'
  [../]
  [./hole_block_2]
     type = HoleChargeContribution
     variable = potential_int
     block  = '2'
  [../]
  #
  [./n_NPD_1]
     type = NerstPlanckDiffusive
     block = '1'
     variable = n
     D_m = -6.46e-6
  [../]
  [./p_NPD_1]
     type = NerstPlanckDiffusive
     block = '1'
     variable = p
     D_m = -6.46e-6
  [../]
  [./n_NED_1]
     type = NerstPlanckDrivingTerm
     block = '1'
     variable = n
     mu_m = 2.5e-4
  [../]
  [./p_NED_1]
     type = NerstPlanckDrivingTerm
     block = '1'
     variable = p
     mu_m = -2.5e-4
  [../]



  [./n_NPD_2]
     type = NerstPlanckDiffusive
     block = '2'
     variable = n
     D_m = 0.0
  [../]
  [./p_NPD_2]
     type = NerstPlanckDiffusive
     block = '2'
     variable = p
     D_m = -3.0e-3
  [../]
  [./n_NED_2]
     type = NerstPlanckDrivingTerm
     block = '2'
     variable = n
     mu_m = 0.0
  [../]
  [./p_NED_2]
     type = NerstPlanckDrivingTerm
     block = '2'
     variable = p
     mu_m = 0.116
     #mu_m = 1.16e17
  [../]



  [./polar_electric_px]
     type = PolarElectricPStrong
     variable = polar_x
     component = 0
  [../]
  [./polar_electric_py]
     type = PolarElectricPStrong
     variable = polar_y
     component = 1
  [../]
  [./polar_electric_pz]
     type = PolarElectricPStrong
     variable = polar_z
     component = 2
  [../]

  ##Time dependence
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

  #[./n_time]
  #   type = TimeDerivativeScaled
  #   variable = n
  #  time_scale = 1.0
  #[../]
  #[./p_time]
  #   type = TimeDerivativeScaled
  #  variable = p
  #  time_scale = 1.0
  #[../]
[]


[BCs]


  [./bot_potential_int]
    variable = potential_int
    type = DirichletBC
    value = 0.0
    boundary = '1'
  [../]
  [./top_potential_int]
    variable = potential_int
    type = DirichletBC
    value = 0.0
    boundary = '2'
  [../]

  [./bot_p]
    variable = p
    type = DirichletBC
    value = 0.0007 #overpotential?
    boundary = '1'
  [../]
  [./top_p]
    variable = p
    type = DirichletBC
    value = 0.0007
    boundary = '2'
  [../]

  [./bot_n]
    variable = n
    type = DirichletBC
    value = 0.0015
    boundary = '1'
  [../]
  [./top_n]
    variable = n
    type = DirichletBC
    value = 0.0015
    boundary = '2'
  [../]


  [./Periodic]
    [./TB_FE_n_pbc]
      variable = n
      primary = '3'
      secondary = '4'
      translation = '0 8 0'
    [../]
    [./TB_FE_p_pbc]
      variable = p
      primary = '3'
      secondary = '4'
      translation = '0 8 0'
    [../]


    [./TB_FE_polar_x_pbc]
      variable = polar_x
      primary = '3'
      secondary = '4'
      translation = '0 8 0'
    [../]
    [./TB_FE_polar_y_pbc]
      variable = polar_y
      primary = '3'
      secondary = '4'
      translation = '0 8 0'
    [../]
    [./TB_FE_polar_z_pbc]
      variable = polar_z
      primary = '3'
      secondary = '4'
      translation = '0 8 0'
    [../]
    [./TB_FE_potential_int_pbc]
      variable = potential_int
      primary = '3'
      secondary = '4'
      translation = '0 8 0'
    [../]
  #
    [./TBsemi_n_pbc]
      variable = n
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]
    [./TBsemi_p_pbc]
      variable = p
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]

    [./TBsemi_potential_int_pbc]
      variable = potential_int
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]

    [./RL_FE_n_pbc]
      variable = n
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]
    [./RL_FE_p_pbc]
      variable = p
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]


    [./RL_FE_polar_x_pbc]
      variable = polar_x
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]
    [./RL_FE_polar_y_pbc]
      variable = polar_y
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]
    [./RL_FE_polar_z_pbc]
      variable = polar_z
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]
    [./RL_FE_potential_int_pbc]
      variable = potential_int
      primary = '5'
      secondary = '6'
      translation = '8 0 0'
    [../]


    [./RLsemi_n_pbc]
      variable = n
      primary = '11'
      secondary = '12'
      translation = '8 0 0'
    [../]
    [./RLsemi_p_pbc]
      variable = p
      primary = '11'
      secondary = '12'
      translation = '8 0 0'
    [../]

    [./RLsub_potential_int_pbc]
      variable = potential_int
      primary = '11'
      secondary = '12'
      translation = '8 0 0'
    [../]
  [../]
[]


[Postprocessors]
   [./Fbulk]
      type = BulkEnergy
      block = '1'
      execute_on = 'timestep_end'
    [../]
    [./Fwall]
      type = WallEnergy
      block = '1'
      execute_on = 'timestep_end'
    [../]
    [./Felec]
      block = '1'
      type = ElectrostaticEnergy
      execute_on = 'timestep_end'
    [../]
    [./perc_change]
     type = PercentChangePostprocessor
     postprocessor = Fbulk
   [../]
[]


#[UserObjects]
# [./kill]
#  type = Terminator
#  expression = 'perc_change <= 1.0e-3'
# [../]
#[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
    petsc_options = '-snes_ksp_ew -snes_converged_reason -ksp_converged_reason'
    petsc_options_iname = '-ksp_gmres_restart  -snes_atol -snes_rtol -ksp_rtol -pc_type '
    petsc_options_value = '        200            1e-10     1e-8      1e-6    bjacobi   '
  [../]
[]

[Debug]
  show_var_residual_norms = false
[]

[Executioner]

  type = Transient

  [./TimeStepper]
    type = IterationAdaptiveDT
    dt = 0.01
    optimal_iterations = 13 #should be 5 probably
    growth_factor = 1.5
    linear_iteration_ratio = 1000
    cutback_factor =  0.85
  [../]

  solve_type = 'NEWTON'       #"PJFNK, JFNK, NEWTON"
  scheme = 'implicit-euler'   #"implicit-euler, explicit-euler, crank-nicolson, bdf2, rk-2"
  #dt = 0.5
  dtmin = 1e-13
  dtmax = 0.85
[]

[Outputs]
  print_linear_residuals = true
  print_perf_log = true
  [./out]
    type = Exodus
    file_base = outPTO_trilayer_085_8_8_8_real
    elemental_as_nodal = true
    interval = 1
  [../]
[]