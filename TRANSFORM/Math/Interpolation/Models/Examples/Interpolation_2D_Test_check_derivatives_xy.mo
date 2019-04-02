within TRANSFORM.Math.Interpolation.Models.Examples;
model Interpolation_2D_Test_check_derivatives_xy
  extends TRANSFORM.Icons.Example;
  Math.Interpolation.Models.Interpolation_2D lookupTables_2D(
    tablePath_u1="C:/Users/vmg/Documents/Modelica/MediaLookupTables/Modelica/MediaLookupTables/Resources/data/lookupTables/ParaHydrogen/pT/p.csv",
    tablePath_u2="C:/Users/vmg/Documents/Modelica/MediaLookupTables/Modelica/MediaLookupTables/Resources/data/lookupTables/ParaHydrogen/pT/T.csv",
    tablePath_y="C:/Users/vmg/Documents/Modelica/MediaLookupTables/Modelica/MediaLookupTables/Resources/data/lookupTables/ParaHydrogen/pT/h.csv")
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=5400,
    duration=1,
    offset=100)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Blocks.Sources.Ramp     ramp1(
    height=1e6,
    duration=1,
    offset=102341.14021054539)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
Real dy;

equation
  dy = der(lookupTables_2D.y);

  connect(ramp.y, lookupTables_2D.u2) annotation (Line(points={{-39,-20},{-26,-20},
          {-26,-6},{-12,-6}}, color={0,0,127}));
  connect(ramp1.y, lookupTables_2D.u1) annotation (Line(points={{-39,20},{-26,20},
          {-26,6},{-12,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Interpolation_2D_Test_check_derivatives_xy;
