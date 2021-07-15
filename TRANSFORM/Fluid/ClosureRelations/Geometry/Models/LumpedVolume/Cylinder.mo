within TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume;
model Cylinder
  import Modelica.Constants.pi;
  parameter SI.Length length = 1.0 "Cylinder length" annotation (Dialog(group="Inputs"));
  parameter SI.Area crossArea = 0.0 "Cross sectional area" annotation (Dialog(group="Inputs"));
  extends
    TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume(
     final V=crossArea*length, dheight=length*sin(angle));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Cylinder;
