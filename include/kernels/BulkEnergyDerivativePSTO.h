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

#ifndef BULKENERGYDERIVATIVEPSTO_H
#define BULKENERGYDERIVATIVEPSTO_H

#include "Kernel.h"

class BulkEnergyDerivativePSTO;

template<>
InputParameters validParams<BulkEnergyDerivativePSTO>();

class BulkEnergyDerivativePSTO: public Kernel
{
public:

  BulkEnergyDerivativePSTO(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();
  virtual Real computeQpOffDiagJacobian(unsigned int jvar);

  const unsigned int _component;
  const unsigned int _polar_x_var;
  const unsigned int _polar_y_var;
  const unsigned int _polar_z_var;
  const VariableValue & _polar_x;
  const VariableValue & _polar_y;
  const VariableValue & _polar_z;
  const Real _a1, _T, _Tc, _a2, _a3, _a4, _a5, _eps, _x1, _x2, _x3, _x4, _x5, _x6;
};
#endif //BULKENERGYDERIVATIVEPSTO_H