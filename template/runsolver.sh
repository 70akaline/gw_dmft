#!/bin/bash
mkdir -p imp
cp delta0_matrix_solver.dat  imp/
cp gbath_tau_matrix_solver.dat  imp/
cp delta0.dat                imp/
cp mu_matrix_solver.dat      imp/
cp mu_vector.dat             imp/
cp Uijkl.dat                 imp/
cp umatrix.dat               imp/
cp Kt.dat                    imp/
rm Swl.dat
rm Gwl.dat
cd imp
sed -i "s/seed.*/seed=`shuf -i 1-1000 -n 1`/" input.ini
sed -i "s/SEED.*/SEED = `shuf -i 1-1000 -n 1`/" alps_parm.dat
mv Swl.dat Swl.dat_old
mv Gwl.dat Gwl.dat_old
mv input.out.h5 input.out.h5_old

echo 'Running runsolver.sh, sleep 5'
sleep 5

############################################################
#mpirun -np 144 hybmat input.ini > out.solver 2>&1
mpirun -np 144 ctint_real input.ini > out.solver 2>&1
#mpirun -np 96 alps_cthyb alps_parm.dat > out.solver 2>&1

echo 'Solver done, sleep 5'
sleep 5
#./getoutput.sh
./getoutput_ctint.sh
#python getoutput_seg.py
############################################################

cd ..
cp imp/Gwl.dat ./
sleep 5
