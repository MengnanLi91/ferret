/**
   This file is part of FERRET, an add-on module for MOOSE

   FERRET is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.

   For help with FERRET please contact J. Mangeri <mangeri@fzu.cz>
   and be sure to track new changes at bitbucket.org/mesoscience/ferret

**/

#ifndef GLOBALRVEUSEROBJECT_H
#define GLOBALRVEUSEROBJECT_H

#include "GlobalStrainUserObject.h"
#include "RankFourTensor.h"
#include "RankTwoTensor.h"

class GlobalRVEUserObject;

template <> InputParameters validParams<GlobalRVEUserObject>();

class GlobalRVEUserObject : public GlobalStrainUserObject {
public:
  GlobalRVEUserObject(const InputParameters &parameters);

  void initialize() override;
  void execute() override;
  void threadJoin(const UserObject &uo) override;
  void finalize() override;
  // virtual const RankTwoTensor & getResidual() const;
  // virtual const RankFourTensor & getJacobian() const;
  // virtual const VectorValue<bool> & getPeriodicDirections() const;

  /**
   * Calculate additional applied stresses
   */
  // virtual void computeEigenstress(){} override;

protected:
  // RankTwoTensor _eigenstress_tensor;

  RankTwoTensor _residual;
  RankFourTensor _jacobian;

  const VariableValue &_antiferrodis_A_x;
  const VariableValue &_antiferrodis_A_y;
  const VariableValue &_antiferrodis_A_z;
  const VariableValue &_polar_x;
  const VariableValue &_polar_y;
  const VariableValue &_polar_z;
  const Real _C11;
  const Real _C12;
  const Real _C44;
  const Real _Q11;
  const Real _Q12;
  const Real _Q44;
  const Real _R11;
  const Real _R12;
  const Real _R44;
};

#endif // GLOBALRVEUSEROBJECT_H