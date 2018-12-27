within TRANSFORM.Math;
function smoothMax
  extends Modelica.Icons.Function;
  import Modelica.Math;

  input Real x1 "First argument of smooth max operator";
  input Real x2 "Second argument of smooth max operator";
  input Real dx
  "Approximate difference between x1 and x2, below which regularization starts";
  output Real y "Result of smooth max operator";
algorithm
  y := max(x1, x2) + 0.25*dx*Math.log(exp((4/dx)*(x1 - max(x1, x2))) + exp((4/
    dx)*(x2 - max(x1, x2))));

   annotation (smoothOrder=2,derivative=smoothMax_der, Documentation(info="<html>
<p>An implementation of Kreisselmeier Steinhauser smooth maximum. This does not return the exact value of x1 or x2, only an approximation, though the error diminishes as the transition region is exited.</p>
<p><img src=\"modelica://TRANSFORM/Resources/Images/Information/smoothMax.jpg\"/></p>
</html>"));
end smoothMax;
