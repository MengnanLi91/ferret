/**
 * @file   CoupledEnergy.h
 * @author J. Mangeri <mangerij@anl.gov>
 *
 */

#ifndef COUPLEDENERGY_H
#define COUPLEDENERGY_H

#include "AuxKernel.h"
#include "RankTwoTensor.h"
#include "ElementIntegralPostprocessor.h"
#include "ElectrostrictiveTensorR4.h"

//Forward Declarations
class CoupledEnergy;

template<>
InputParameters validParams<CoupledEnergy>();


class CoupledEnergy : public ElementIntegralPostprocessor
{
public:
  CoupledEnergy(const std::string & name, InputParameters parameters);

protected:
  virtual Real computeQpIntegral();

private:
  const MaterialProperty<ElectrostrictiveTensorR4> & _electrostrictive_tensor;
  const VariableGradient & _disp_x_grad;
  const VariableGradient & _disp_y_grad;
  const VariableGradient & _disp_z_grad;
  const VariableValue & _polar_x;
  const VariableValue & _polar_y;
  const VariableValue & _polar_z;
  const Real _strain_scale;
  const Real _artificial;
  const Real _len_scale;
};

#endif