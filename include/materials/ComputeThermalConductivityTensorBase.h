#ifndef COMPUTETHERMALCONDUCTIVITYTENSORBASE_H
#define COMPUTETHERMALCONDUCTIVITYTENSORBASE_H

#include "Material.h"
#include "RankTwoTensor.h"

/**
 * ComputeThermalConductivityTensorBase the base class for computing thermal conductivity tensors
 */
class ComputeThermalConductivityTensorBase : public Material
{
public:
  ComputeThermalConductivityTensorBase(const InputParameters & parameters);

  static InputParameters validParams();

protected:
  virtual void computeQpProperties();
  virtual void computeQpThermalConductivityTensor() = 0;

  std::string _base_name;
  std::string _thC_tensor_name;

  MaterialProperty<RankTwoTensor> & _thC_tensor;
};

#endif // COMPUTEThermalConductivityTENSORBASE_H