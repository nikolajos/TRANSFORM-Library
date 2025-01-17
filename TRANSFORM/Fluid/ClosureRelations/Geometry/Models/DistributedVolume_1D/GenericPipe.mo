within TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D;
model GenericPipe
  constant Integer figure=1 "Index for Icon figure" annotation (choices(
      choice=1 "Pipe",
      choice=2 "Annulus",
      choice=3 "Duct"));
  parameter Integer nV(min=1) = 1 "Number of volume nodes";
  parameter Integer nSurfaces=1 "Number of transfer (heat/mass) surfaces";
  parameter SI.Length dimensions[nV]=4*crossAreas ./ perimeters
    "Characteristic dimension (e.g., hydraulic diameter)"
    annotation (Dialog(group="Inputs"));
  parameter SI.Area crossAreas[nV]=pi*dimensions .* dimensions ./ 4
    "Cross sectional area of unit volumes"
    annotation (Dialog(group="Inputs"));
  parameter SI.Length perimeters[nV]=4*crossAreas ./ dimensions
    "Wetted perimeter of unit volumes"
    annotation (Dialog(group="Inputs"));
  parameter SI.Length dlengths[nV]=ones(nV) "Unit cell length"
    annotation (Dialog(group="Inputs"));
  parameter SI.Height[nV] roughnesses=fill(2.5e-5, nV)
    "Average heights of surface asperities"
    annotation (Dialog(group="Inputs"));
  parameter SI.Area surfaceAreas[nV,nSurfaces]={{if j == 1 then perimeters[i]*dlengths[i] else 0 for j in 1:nSurfaces} for i in 1:nV}
    "Discretized area per transfer surface"
    annotation (Dialog(group="Inputs"));
  // Elevation
  parameter SI.Angle[nV] angles(min=fill(-Modelica.Constants.pi/2-0.01, nV),max=fill(Modelica.Constants.pi/2+0.01, nV))=fill(0,nV) "Vertical angle from the horizontal (-pi/2 <= x <= pi/2)"
    annotation (Dialog(group="Inputs Elevation"));
  parameter SI.Length[nV] dheights=dlengths.*sin(angles)  "Height(port_b) - Height(port_a)"
    annotation (Dialog(group="Inputs Elevation"));
  parameter SI.Length height_a=0
    "Elevation at port_a: Reference value only. No impact on calculations."
    annotation (Dialog(group="Inputs Elevation"));
  parameter SI.Length height_b=height_a + sum(dheights)
    "Elevation at port_b: Reference value only. No impact on calculations."
    annotation (Dialog(group="Inputs Elevation", enable=false));
  parameter SI.Volume Vs[nV]=crossAreas .* dlengths "Unit volumes";
  parameter SI.Volume V_total=sum(Vs) "Total volume of component";
  parameter SI.Area surfaceAreas_nVtotal[nV]={sum(surfaceAreas[1, :]) for i in 1:nV}
    "Total surface area for each volume node";
  parameter SI.Area surfaceArea_total=sum(surfaceAreas_nVtotal) "Total surface area";
  parameter Real dxs[nV]=dlengths/sum(dlengths) "Fractional lengths";
initial equation
  for i in 1:nV loop
    assert(dimensions[i] > 0, "Characteristic dimension must be > 0");
    assert(dlengths[i] >= abs(dheights[i]), "Geometry dlengths must be greater or equal to abs(dheights)");
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-100,-100},{100,100}}, fileName="modelica://TRANSFORM/Resources/Images/Icons/Geometry_genericVolume.jpg")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
end GenericPipe;
