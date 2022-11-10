/*
    ARMv8 Optimized Code for Calculating XYZ Speed
    Copyright (C) 2022 Vega
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see https://www.gnu.org/licenses/gpl-3.0.txt
*/

/*
x0 = new XYZ coordinates
x1 = old XYZ coordinates

It is assumed that this snippet of code will be executed at consistent time intervals. It is also assumed there is a "W" component present in memory after the Z coordinate (XYZW). The "W" component is usually a constant value 1.0. When "W" is a static (non-changing) value, it has zero effect on our calculations. If this is not the case, there are two extra instructions that need to be un-commented.*/

/*Load new XYZW*/
ldr q0, [x0]

/*Load old XYZW*/
ldr q1, [x1]

/*Un-comment if "W" component is non-static*/
/*mov v0.4s[3], wzr*/
/*mov v1.4s[3], wzr*/

/*XYZ Speed = sqrt{[(x2 - x1)^2] + [(y2 - y1)^2] + [(z2 - z1)^2]}*/
fsub v0.4s, v0.4s, v1.4s
fmul v0.4s, v0.4s, v0.4s
faddp v0.4s, v0.4s, v0.4s
faddp s0, v0.2s
fsqrt s0, s0
ret

/*Result (speed) is in s0*/
