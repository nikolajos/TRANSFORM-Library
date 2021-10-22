within TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume;
model Annulus
  parameter SI.Length length = 1.0 "Cylinder length" annotation (Dialog(group="Inputs"));
  parameter SI.Area crossArea_inner = 0.0 "Inner cross sectional area" annotation (Dialog(group="Inputs"));
  parameter SI.Area crossArea_outer = 0.0 "Outer cross sectional area" annotation (Dialog(group="Inputs"));
  parameter SI.Area crossArea = crossArea_outer - crossArea_inner "Total cross sectional area";
  extends
    TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume(
     final V=crossArea*length, dheight=length*sin(angle));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Annulus;
