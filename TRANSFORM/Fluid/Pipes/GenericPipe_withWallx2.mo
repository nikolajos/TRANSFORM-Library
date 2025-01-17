within TRANSFORM.Fluid.Pipes;
model GenericPipe_withWallx2
  import Modelica.Fluid.Types.Dynamics;
  import TRANSFORM.Math.linspace_2Dedge;
  import TRANSFORM.Math.linspaceRepeat_2Dedge;
  outer TRANSFORM.Fluid.SystemTF systemTF;
  //extends TRANSFORM.Fluid.Pipes.ClosureModels.Geometry.PipeWithWallIcons;
  // Geometry Model
  replaceable model Geometry =
      TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.StraightPipe
    constrainedby
    TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.Pipe_Wallx2.PartialPipeWithWall
                                                                                      "Geometry"
    annotation (Dialog(group="Geometry"),choicesAllMatching=true);
  Geometry geometry
    annotation (Placement(transformation(extent={{-78,82},{-62,98}})));
  extends BaseClasses.GenericPipe_Record_multiSurface(
    final nV=pipe.geometry.nV,
    use_HeatTransfer=true);
  input SI.Acceleration g_n=Modelica.Constants.g_n "Gravitational acceleration"
    annotation (Dialog(tab="Advanced", group="Inputs"));
  replaceable package Material =
      TRANSFORM.Media.Solids.SS316                     constrainedby
    TRANSFORM.Media.Interfaces.Solids.PartialAlloy
    "Wall material properties" annotation (choicesAllMatching=true);
  replaceable package Material_2 =
      Material                     constrainedby TRANSFORM.Media.Interfaces.Solids.PartialAlloy
    "Wall material properties" annotation (choicesAllMatching=true);
  parameter Boolean counterCurrent=false "Swap wall vector order";
  parameter Boolean use_HeatTransferOuter=false "= true to use outer wall heat port" annotation (Dialog(group="Heat Transfer"));
  final parameter Integer nVs[3](min=1) = {geometry.nR,geometry.nZ,geometry.nR_2}
    "Number of discrete volumes";
  // Initialization: Wall
  parameter Dynamics energyDynamics_wall=Dynamics.DynamicFreeInitial
    "Formulation of energy balances"
    annotation (Dialog(tab="Initialization: Wall", group="Dynamics"));
  parameter SI.Temperature Ts_start_wall[nVs[1],nVs[2]]=linspace_2Dedge(
      T_a1_start,
      T_b1_start,
      T_a2_start,
      T_b2_start,
      nVs[1],
      nVs[2],
      {exposeState_outerWall,exposeState_a,true,exposeState_b}) "Temperature" annotation (Dialog(
        tab="Initialization: Wall", group="Start Value: Temperature"));
  parameter SI.Temperature T_a1_start=Material.T_reference
    "Temperature at port a1" annotation (Dialog(tab="Initialization: Wall",
        group="Start Value: Temperature"));
  parameter SI.Temperature T_b1_start=T_a1_start "Temperature at port b1"
    annotation (Dialog(tab="Initialization: Wall", group="Start Value: Temperature"));
  parameter SI.Temperature T_a2_start=Material.T_reference
    "Temperature at port a2" annotation (Dialog(tab="Initialization: Wall",
        group="Start Value: Temperature"));
  parameter SI.Temperature T_b2_start=T_a2_start "Temperature at port b2"
    annotation (Dialog(tab="Initialization: Wall", group="Start Value: Temperature"));
  // Initialization: Wall_2
  parameter Dynamics energyDynamics_wall_2=energyDynamics_wall
    "Formulation of energy balances"
    annotation (Dialog(tab="Initialization: Wall", group="Dynamics"));
  parameter SI.Temperature Ts_start_wall_2[nVs[3],nVs[2]]=linspace_2Dedge(
      T_a1_start_2,
      T_b1_start_2,
      T_a2_start_2,
      T_b2_start_2,
      nVs[3],
      nVs[2],
      {exposeState_outerWall,exposeState_a,true,exposeState_b}) "Temperature" annotation (Dialog(
        tab="Initialization: Wall", group="Start Value: Temperature"));
  parameter SI.Temperature T_a1_start_2=T_a1_start
    "Temperature at port a1" annotation (Dialog(tab="Initialization: Wall",
        group="Start Value: Temperature"));
  parameter SI.Temperature T_b1_start_2=T_a1_start_2 "Temperature at port b1"
    annotation (Dialog(tab="Initialization: Wall", group="Start Value: Temperature"));
  parameter SI.Temperature T_a2_start_2=T_a2_start
    "Temperature at port a2" annotation (Dialog(tab="Initialization: Wall",
        group="Start Value: Temperature"));
  parameter SI.Temperature T_b2_start_2=T_a2_start_2 "Temperature at port b2"
    annotation (Dialog(tab="Initialization: Wall", group="Start Value: Temperature"));
  // Advanced
  parameter Boolean exposeState_outerWall=false
    "=true, T is calculated at outer wall else Q_flow" annotation (Dialog(group=
         "Model Structure", tab="Advanced"));
  replaceable model InternalHeatModel_wall =
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration
    constrainedby
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.PartialInternalHeatGeneration
    "Internal heat generation" annotation (Dialog(group="Heat Transfer"),
      choicesAllMatching=true);
  replaceable model InternalHeatModel_wall_2 =
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.GenericHeatGeneration
    constrainedby
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.PartialInternalHeatGeneration
    "Internal heat generation" annotation (Dialog(group="Heat Transfer"),
      choicesAllMatching=true);
  GenericPipe_MultiTransferSurface
              pipe(
    nParallel=nParallel,
    redeclare package Medium = Medium,
    redeclare model FlowModel = FlowModel,
    use_HeatTransfer=use_HeatTransfer,
    redeclare model HeatTransfer = HeatTransfer,
    redeclare model InternalHeatGen = InternalHeatGen,
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    traceDynamics=traceDynamics,
    ps_start=ps_start,
    use_Ts_start=use_Ts_start,
    Ts_start=Ts_start,
    hs_start=hs_start,
    Xs_start=Xs_start,
    Cs_start=Cs_start,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    T_a_start=T_a_start,
    T_b_start=T_b_start,
    h_a_start=h_a_start,
    h_b_start=h_b_start,
    X_a_start=X_a_start,
    X_b_start=X_b_start,
    C_a_start=C_a_start,
    C_b_start=C_b_start,
    m_flow_a_start=m_flow_a_start,
    m_flow_b_start=m_flow_b_start,
    m_flows_start=m_flows_start,
    momentumDynamics=momentumDynamics,
    exposeState_a=exposeState_a,
    exposeState_b=exposeState_b,
    g_n=g_n,
    useInnerPortProperties=useInnerPortProperties,
    useLumpedPressure=useLumpedPressure,
    lumpPressureAt=lumpPressureAt,
    redeclare model Geometry = Geometry,
    calc_Wb=calc_Wb)
    annotation (Placement(transformation(extent={{-10,-90},{10,-70}})));
  HeatAndMassTransfer.DiscritizedModels.Conduction_2D wall(
    redeclare package Material = Material,
    nParallel=nParallel,
    redeclare model InternalHeatModel = InternalHeatModel_wall,
    energyDynamics=energyDynamics_wall,
    Ts_start=Ts_start_wall,
    T_a1_start=T_a1_start,
    T_b1_start=T_b1_start,
    T_a2_start=T_a2_start,
    T_b2_start=T_b2_start,
    redeclare model Geometry =
        HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z (
        nR=geometry.nR,
        nZ=geometry.nZ,
        r_outer=wall.geometry.r_inner + sum(geometry.ths_wall)/geometry.nV,
        length_z=sum(geometry.dlengths),
        drs=geometry.drs,
        dzs=geometry.dzs,
        r_inner=geometry.r_inner),
    exposeState_a2=exposeState_a,
    exposeState_b2=exposeState_b,
    exposeState_a1=if pipe.heatTransfer.flagIdeal == 1 then false else true,
    exposeState_b1=not idealContact)                       annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={0,-34})));
  Interfaces.FluidPort_Flow port_a(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Interfaces.FluidPort_Flow port_b(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_a[geometry.nR]
    annotation (Placement(transformation(extent={{-60,-44},{-40,-24}})));
  HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_b[geometry.nR]
    annotation (Placement(transformation(extent={{60,-44},{40,-24}})));
  HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_outer[
    geometry.nZ] if                                                    not use_HeatTransferOuter
    annotation (Placement(transformation(extent={{60,16},{40,36}})));
  HeatAndMassTransfer.BoundaryConditions.Heat.CounterFlow counterFlow(
      counterCurrent=counterCurrent, n=geometry.nZ) if
                                          use_HeatTransferOuter annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,40})));
  HeatAndMassTransfer.Interfaces.HeatPort_Flow heatPorts[geometry.nZ] if use_HeatTransferOuter
    annotation (Placement(transformation(extent={{-10,54},{10,74}}),
        iconTransformation(extent={{-10,40},{10,60}})));
  HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_inner[
    geometry.nZ] if                                                    not use_HeatTransfer
    annotation (Placement(transformation(extent={{60,-62},{40,-42}})));
  // Visualization
  parameter Boolean showName = true annotation(Dialog(tab="Visualization"));
  parameter Boolean showDesignFlowDirection = true annotation(Dialog(tab="Visualization"));
  extends TRANSFORM.Utilities.Visualizers.IconColorMap(showColors=systemTF.showColors, val_min=systemTF.val_min,val_max=systemTF.val_max, val=pipe.summary.T_effective);
  HeatAndMassTransfer.Interfaces.HeatPort_Flow heatPorts_add[geometry.nZ,
    geometry.nSurfaces - 1] if geometry.nSurfaces > 1
    annotation (Placement(transformation(extent={{20,-80},{40,-60}}),
        iconTransformation(extent={{20,-10},{40,10}})));
  HeatAndMassTransfer.DiscritizedModels.Conduction_2D wall_2(
    nParallel=nParallel,
    exposeState_b1=exposeState_outerWall,
    exposeState_a2=exposeState_a,
    exposeState_b2=exposeState_b,
    Ts_start=Ts_start_wall_2,
    T_a1_start=T_a1_start_2,
    T_b1_start=T_b1_start_2,
    T_a2_start=T_a2_start_2,
    T_b2_start=T_b2_start_2,
    energyDynamics=energyDynamics_wall_2,
    redeclare model Geometry =
        HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z (
        nZ=geometry.nZ,
        length_z=sum(geometry.dlengths),
        nR=geometry.nR_2,
        r_outer=wall_2.geometry.r_inner + sum(geometry.ths_wall_2)/geometry.nV,
        drs=geometry.drs_2,
        dzs=geometry.dzs_2,
        r_inner=wall.geometry.r_outer),
    redeclare model InternalHeatModel = InternalHeatModel_wall_2,
    redeclare package Material = Material_2,
    exposeState_a1=true)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={0,10})));
  HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_a1[geometry.nR_2]
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic_b1[geometry.nR_2]
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));
  HeatAndMassTransfer.Interfaces.HeatPort_Flow heatPorts_addWall[geometry.nV] if use_heatPort_addWall "Additional heat source/sink between wall and insulation" annotation (Placement(
        transformation(extent={{20,-26},{40,-6}}),  iconTransformation(extent={{
            20,22},{40,42}})));
  parameter Boolean use_heatPort_addWall = false "=true for additional source/sink for heat between wall and insulation" annotation(Dialog(group="Heat Transfer"));
  HeatAndMassTransfer.Resistances.Heat.Contact contact[geometry.nZ](surfaceArea=
       wall.geometry.crossAreas_1[end, :], Rc_pp=Rc_pps + dRc_pps) if
                                                            not idealContact
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-12})));
  parameter SI.ThermalInsulance Rc_pps[geometry.nZ]=zeros(geometry.nZ)
    "Area specific contact resistance" annotation(Dialog(tab="Advanced"));
  input SI.ThermalInsulance dRc_pps[geometry.nZ]=zeros(geometry.nZ) "change in Rc_pps" annotation(Dialog(group="Inputs",tab="Advanced"));
  final parameter Boolean idealContact = if sum(Rc_pps) < Modelica.Constants.eps then true else false;
equation
  connect(port_a, pipe.port_a) annotation (Line(
      points={{-100,0},{-60,0},{-60,-80},{-10,-80}},
      color={0,127,255},
      thickness));
  connect(port_b, pipe.port_b) annotation (Line(
      points={{100,0},{60,0},{60,-80},{10,-80}},
      color={0,127,255},
      thickness));
  connect(wall.port_a1, pipe.heatPorts[:,1]) annotation (Line(
      points={{-6.66134e-16,-44},{-6.66134e-16,-58},{0,-58},{0,-75}},
      color={191,0,0},
      thickness));
  connect(wall.port_a2, adiabatic_a.port) annotation (Line(
      points={{-10,-34},{-40,-34}},
      color={191,0,0},
      thickness));
  connect(adiabatic_b.port, wall.port_b2) annotation (Line(
      points={{40,-34},{10,-34}},
      color={191,0,0},
      thickness));
  connect(counterFlow.port_b, heatPorts) annotation (Line(
      points={{6.66134e-16,50},{6.66134e-16,58},{0,58},{0,64}},
      color={191,0,0},
      thickness));
  connect(adiabatic_inner.port, wall.port_a1) annotation (Line(
      points={{40,-52},{-6.66134e-16,-52},{-6.66134e-16,-44}},
      color={191,0,0},
      thickness));
  connect(heatPorts_add, pipe.heatPorts[:,2:geometry.nSurfaces])
    annotation (Line(points={{30,-70},{0,-70},{0,-75}}, color={191,0,0}));
  connect(adiabatic_outer.port, wall_2.port_b1)
    annotation (Line(points={{40,26},{0,26},{0,20}}, color={191,0,0}));
  connect(counterFlow.port_a, wall_2.port_b1)
    annotation (Line(points={{0,30},{0,20}}, color={191,0,0}));
  connect(adiabatic_b1.port, wall_2.port_b2)
    annotation (Line(points={{40,0},{20,0},{20,10},{10,10}}, color={191,0,0}));
  connect(adiabatic_a1.port, wall_2.port_a2) annotation (Line(points={{-40,0},{-20,
          0},{-20,10},{-10,10}}, color={191,0,0}));
  connect(heatPorts_addWall, wall.port_b1) annotation (Line(points={{30,-16},{20,
          -16},{20,-24},{0,-24}}, color={191,0,0}));
  if idealContact then
  connect(wall.port_b1, wall_2.port_a1)
    annotation (Line(points={{0,-24},{0,0}}, color={191,0,0}));
    else
  connect(contact.port_b, wall_2.port_a1)
    annotation (Line(points={{0,-5},{0,0}}, color={191,0,0}));
  connect(contact.port_a, wall.port_b1)
    annotation (Line(points={{0,-19},{0,-24}}, color={191,0,0}));
  end if;
  annotation (defaultComponentName="pipe",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-92,30},{-108,-30}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_a),
        Ellipse(
          extent={{108,30},{92,-30}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_b),
        Ellipse(
          extent={{8,30},{-8,-30}},
          lineColor={191,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=exposeState_outerWall,
          origin={0,50},
          rotation=90),
        Rectangle(
          extent={{-90,40},{90,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor=DynamicSelect({0,127,255}, if showColors then dynColor else {0,127,255})),
        Ellipse(
          extent={{-65,5},{-55,-5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-5,5},{5,-5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{55,5},{65,-5}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,40},{-30,-40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Line(
          points={{30,40},{30,-40}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Text(
          extent={{-149,-68},{151,-108}},
          lineColor={0,0,255},
          textString="%name",
          visible=DynamicSelect(true,showName)),
        Polygon(
          points={{20,-45},{60,-60},{20,-75},{20,-45}},
          lineColor={0,128,255},
          smooth=Smooth.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=DynamicSelect(true,showDesignFlowDirection)),
        Polygon(
          points={{20,-50},{50,-60},{20,-70},{20,-50}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=DynamicSelect(true,showDesignFlowDirection)),
        Line(
          points={{55,-60},{-60,-60}},
          color={0,128,255},
          smooth=Smooth.None,
          visible=DynamicSelect(true,showDesignFlowDirection)),
        Rectangle(
          extent={{-90,40},{90,32}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-90,32},{90,24}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-90,-24},{90,-32}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-90,-32},{90,-40}},
          lineColor={0,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Backward)}),                   Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end GenericPipe_withWallx2;
