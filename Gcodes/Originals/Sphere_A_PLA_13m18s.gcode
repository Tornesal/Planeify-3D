; HEADER_BLOCK_START
; BambuStudio 02.04.00.70
; model printing time: 7m 41s; total estimated time: 13m 18s
; total layer number: 82
; total filament length [mm] : 1110.57
; total filament volume [cm^3] : 2671.22
; total filament weight [g] : 3.37
; filament_density: 1.26,1.26,1.26,1.26,1.26,1.26,1.26
; filament_diameter: 1.75,1.75,1.75,1.75,1.75,1.75,1.75
; max_z_height: 16.40
; filament: 1
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0,0,0,0,0,0,0
; additional_cooling_fan_speed = 75,75,75,75,75,75,75
; apply_scarf_seam_on_circles = 1
; apply_top_surface_compensation = 0
; auto_disable_filter_on_overheat = 0
; auxiliary_fan = 1
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 
; bed_temperature_formula = by_highest_temp
; before_layer_change_gcode = 
; best_object_pos = 0.3,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50,50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0,0,0,0,0,0,0
; change_filament_gcode = ;======== H2C filament_change ========\n;=========== 20251117 ===========\nM993 A2 B2 C2 ; nozzle cam detection allow status save.\nM993 A0 B0 C0 ; nozzle cam detection not allowed.\n\n{if (filament_type[next_extruder] == "PLA") ||  (filament_type[next_extruder] == "PETG")\n ||  (filament_type[next_extruder] == "PLA-CF")  ||  (filament_type[next_extruder] == "PETG-CF")}\nM1015.4 S1 K0 ;disable E air printing detect\n{else}\nM1015.4 S0 ; disable E air printing detect\n{endif}\n\nM620 S[next_extruder]A\nM1002 gcode_claim_action : 4\nM204 S9000\n\nG1 Z{max_layer_z + 3.0} F1200\n\nM400\nM106 P1 S0\nM106 P2 S0\n\n{if toolchange_count == 2}\n; get travel path for change filament\n;M620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\n;M620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\n;M620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\n\n{if wipe_tower_center_pos_valid}\n    M620.14 X[wipe_tower_center_pos_x] Y[wipe_tower_center_pos_y]\n{else}\n    M620.14 X95.5 Y336\n{endif}\n\n{if ((filament_type[current_extruder] == "PLA") || (filament_type[current_extruder] == "PLA-CF") || (filament_type[current_extruder] == "PETG")) && (nozzle_diameter[current_extruder] == 0.2)}\nM620.10 A0 F74.8347 L[flush_length] H{nozzle_diameter[current_extruder]} T{flush_temperatures[current_extruder]} P{nozzle_temperature[current_extruder]} S1\n{else}\nM620.10 A0 F{flush_volumetric_speeds[current_extruder]/2.4053*60*0.8} L[flush_length] H{nozzle_diameter[current_extruder]} T{flush_temperatures[current_extruder]} P{nozzle_temperature[current_extruder]} S1\n{endif}\n\n{if ((filament_type[next_extruder] == "PLA") || (filament_type[next_extruder] == "PLA-CF") || (filament_type[next_extruder] == "PETG")) && (nozzle_diameter[next_extruder] == 0.2)}\nM620.10 A1 F74.8347 L[flush_length] H{nozzle_diameter[next_extruder]} T{flush_temperatures[next_extruder]} P{nozzle_temperature[next_extruder]} S1\n{else}\nM620.10 A1 F{flush_volumetric_speeds[next_extruder]/2.4053*60*0.8} L[flush_length] H{nozzle_diameter[next_extruder]} T{flush_temperatures[next_extruder]} P{nozzle_temperature[next_extruder]} S1\n{endif}\n\n{if long_retraction_when_cut}\nM620.11 P1 I[current_extruder] E-{retraction_distance_when_cut} F{max((flush_volumetric_speeds[current_extruder]/2.4053*60), 200)}\n{else}\nM620.11 P0 I[current_extruder] E0\n{endif}\n\nM620.15 P[filament_pre_cooling_temperature_nc[next_extruder]]\nM620.15 C{new_filament_temp - filament_cooling_before_tower[next_extruder]}\nM620.11 O1 T[filament_retract_length_nc]\n\n{if long_retraction_when_ec}\nM620.11 K1 I[current_extruder] R{retraction_distance_when_ec} F{max((flush_volumetric_speeds[current_extruder]/2.4053*60), 200)}\n{else}\nM620.11 K0 I[current_extruder] R0\n{endif}\n\nM628 S1\n{if filament_type[current_extruder] == "TPU"}\nM620.11 S0 L0 I[current_extruder] E-{retraction_distances_when_cut[current_extruder]} F{max((flush_volumetric_speeds[current_extruder]/2.4053*60), 200)}\n{else}\n{if (filament_type[current_extruder] == "PA") || (filament_type[current_extruder] == "PA-GF")}\nM620.11 S1 L0 I[current_extruder] R4 D2 E-{retraction_distances_when_cut[current_extruder]} F{max((flush_volumetric_speeds[current_extruder]/2.4053*60), 200)}\n{else}\nM620.11 S1 L0 I[current_extruder] R10 D8 E-{retraction_distances_when_cut[current_extruder]} F{max((flush_volumetric_speeds[current_extruder]/2.4053*60), 200)}\n{endif}\n{endif}\nM629\n\n{if filament_type[current_extruder] == "TPU" || filament_type[next_extruder] == "TPU"}\nM620.11 H2 C331\n{else}\nM620.11 H0\n{endif}\n\nT[next_extruder]\n\n;deretract\n{if filament_type[next_extruder] == "TPU"}\n{else}\n{if (filament_type[next_extruder] == "PA") || (filament_type[next_extruder] == "PA-GF")}\n;VG1 E1 F{max(new_filament_e_feedrate, 200)}\n;VG1 E1 F{max(new_filament_e_feedrate/2, 100)}\n{else}\n;VG1 E4 F{max(new_filament_e_feedrate, 200)}\n;VG1 E4 F{max(new_filament_e_feedrate/2, 100)}\n{endif}\n{endif}\n\n; VFLUSH_START\n\n{if flush_length>41.5}\n;VG1 E41.5 F{min(old_filament_e_feedrate,new_filament_e_feedrate)}\n;VG1 E{flush_length-41.5} F{new_filament_e_feedrate}\n{else}\n;VG1 E{flush_length} F{min(old_filament_e_feedrate,new_filament_e_feedrate)}\n{endif}\n\nSYNC T{ceil(flush_length / 125) * 5}\n\n; compensate for heating and cooling\n{if flush_length > 0}\n{if flush_temperatures[next_extruder] > new_filament_temp}\nSYNC T{(flush_temperatures[next_extruder]-(new_filament_temp - filament_cooling_before_tower[next_extruder]))/hotend_cooling_rate[filament_map[next_extruder]-1]}\nSYNC T{(flush_temperatures[next_extruder]-(new_filament_temp - filament_cooling_before_tower[next_extruder]))/hotend_heating_rate[filament_map[next_extruder]-1]}\n{else}\nSYNC T{(new_filament_temp - filament_cooling_before_tower[next_extruder] -flush_temperatures[next_extruder])/hotend_cooling_rate[filament_map[next_extruder]-1]}\nSYNC T{(new_filament_temp - filament_cooling_before_tower[next_extruder] -flush_temperatures[next_extruder])/hotend_heating_rate[filament_map[next_extruder]-1]}\n{endif}\n{endif}\n\n; VFLUSH_END\n\nM1002 set_filament_type:{filament_type[next_extruder]}\n\nM400\nM83\n{if next_extruder < 255}\n\n\nM620.10 R{retract_length_toolchange[filament_map[next_extruder]-1]}\n{if (print_sequence == "by object" && !has_wipe_tower)}\nM628 S0 F1 L10.0\n; VFLUSH_START\n;VG1 E10 F[new_filament_e_feedrate]\n; VFLUSH_END\n{else}\nM628 S0\n{endif}\n;VM109 S[new_filament_temp]\n\nM629\nM400\n\nM983.3 F{filament_max_volumetric_speed[next_extruder]/2.4} A0.4 R{retract_length_toolchange[filament_map[next_extruder]-1]}\n\n\nM400\n{if wipe_avoid_perimeter}\nG387 Y320 J1 F10000\nG1 X{wipe_avoid_pos_x} F30000\n{endif}\nG387 Y295 J1 F30000\nG387 Y265 J1 F18000\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\nM621 S[next_extruder]A\n\nM993 A3 B3 C3 ; nozzle cam detection allow status restore.\n\n{if (filament_type[next_extruder]  == "TPU")}\nM1015.3 S1;enable tpu clog detect\n{else}\nM1015.3 S0;disable tpu clog detect\n{endif}\n\n{if (filament_type[next_extruder] == "PLA") ||  (filament_type[next_extruder] == "PETG")\n ||  (filament_type[next_extruder] == "PLA-CF")  ||  (filament_type[next_extruder] == "PETG-CF")}\nM1015.4 S1 K1 H[nozzle_diameter] ;enable E air printing detect\n{else}\nM1015.4 S0 ; disable E air printing detect\n{endif}\n\nM620.6 I[next_extruder] W1 ;enable ams air printing detect\nM1002 gcode_claim_action : 0\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200,200,200,200,200,200,200
; close_fan_the_first_x_layers = 1,1,1,1,1,1,1
; complete_print_exhaust_fan_speed = 70,70,70,70,70,70,70
; cool_plate_temp = 35,35,35,35,35,35,35
; cool_plate_temp_initial_layer = 35,35,35,35,35,35,35
; cooling_filter_enabled = 0
; counter_coef_1 = 0,0,0,0,0,0,0
; counter_coef_2 = 0.003,0.003,0.003,0.003,0.003,0.003,0.003
; counter_coef_3 = 0.01,0.01,0.01,0.01,0.01,0.01,0.01
; counter_limit_max = 0.088,0.088,0.088,0.088,0.088,0.088,0.088
; counter_limit_min = -0.035,-0.035,-0.035,-0.035,-0.035,-0.035,-0.035
; curr_bed_type = Textured PEI Plate
; default_acceleration = 8000,8000
; default_filament_colour = ;;;;;;
; default_filament_profile = "Bambu PLA Basic @BBL H2C"
; default_jerk = 0
; default_nozzle_volume_type = Standard,Standard
; default_print_profile = 0.20mm Standard @BBL H2C
; deretraction_speed = 30,30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50,50,50,50,50,50,50
; different_settings_to_system = skeleton_infill_density;skin_infill_density;sparse_infill_density;sparse_infill_pattern;;;;;;;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70,70,70,70,70,70,70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_height_slowdown = 0,0
; enable_long_retraction_when_cut = 2
; enable_overhang_bridge_fan = 1,1,1,1,1,1,1
; enable_overhang_speed = 1,1
; enable_pre_heating = 1
; enable_pressure_advance = 0,0,0,0,0,0,0
; enable_prime_tower = 0
; enable_support = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 55,55,55,55,55,55,55
; eng_plate_temp_initial_layer = 55,55,55,55,55,55,55
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;1#0|4#0
; extruder_clearance_dist_to_rod = 50
; extruder_clearance_height_to_lid = 201
; extruder_clearance_height_to_rod = 47.4
; extruder_clearance_max_radius = 96
; extruder_colour = #018001;#018001
; extruder_max_nozzle_count = 1,6
; extruder_nozzle_stats = Standard#1;Standard#6
; extruder_offset = 0x0,0x0
; extruder_printable_area = 0x0,325x0,325x320,0x320#25x0,330x0,330x320,25x320
; extruder_printable_height = 320,325
; extruder_type = Direct Drive,Direct Drive
; extruder_variant_list = "Direct Drive Standard,Direct Drive High Flow";"Direct Drive Standard,Direct Drive High Flow"
; fan_cooling_layer_time = 100,100,100,100,100,100,100
; fan_direction = left
; fan_max_speed = 80,80,80,80,80,80,80
; fan_min_speed = 60,60,60,60,60,60,60
; filament_adaptive_volumetric_speed = 0,0,0,0,0,0,0
; filament_adhesiveness_category = 100,100,100,100,100,100,100
; filament_change_length = 4,4,4,4,4,4,4
; filament_change_length_nc = 4,4,4,4,4,4,4
; filament_colour = #000000;#00D800;#FFFF00;#FF0000;#5E43B7;#0056B8;#FF6A13
; filament_colour_type = 0;1;1;1;1;1;1
; filament_cooling_before_tower = 10,10,10,10,10,10,10
; filament_cost = 24.99,24.99,24.99,24.99,24.99,24.99,24.99
; filament_density = 1.26,1.26,1.26,1.26,1.26,1.26,1.26
; filament_diameter = 1.75,1.75,1.75,1.75,1.75,1.75,1.75
; filament_end_gcode = "; filament end gcode \n";"; filament end gcode \n";"; filament end gcode \n";"; filament end gcode \n";"; filament end gcode \n";"; filament end gcode \n";"; filament end gcode \n"
; filament_extruder_variant = "Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard";"Direct Drive Standard"
; filament_flow_ratio = 0.99,0.99,0.99,0.99,0.99,0.99,0.99
; filament_flush_temp = 0,0,0,0,0,0,0
; filament_flush_volumetric_speed = 0,0,0,0,0,0,0
; filament_ids = GFA00;GFA00;GFA00;GFA00;GFA00;GFA00;GFA00
; filament_is_support = 0,0,0,0,0,0,0
; filament_map = 2,1,1,1,1,1,1
; filament_map_2 = 1,0,0,0,0,0,0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 25,25,25,25,25,25,25
; filament_minimal_purge_on_wipe_tower = 15,15,15,15,15,15,15
; filament_multi_colour = #000000;#00D800;#FFFF00;#FF0000;#5E43B7;#0056B8;#FF6A13
; filament_notes = 
; filament_nozzle_map = 1,0,0,0,0,0,0
; filament_pre_cooling_temperature = 0,0,0,0,0,0,0
; filament_pre_cooling_temperature_nc = 180,180,180,180,180,180,180
; filament_prime_volume = 30,30,30,30,30,30,30
; filament_prime_volume_nc = 30,30,30,30,30,30,30
; filament_printable = 3,3,3,3,3,3,3
; filament_ramming_travel_time = 0,0,0,0,0,0,0
; filament_ramming_travel_time_nc = 1,1,1,1,1,1,1
; filament_ramming_volumetric_speed = -1,-1,-1,-1,-1,-1,-1
; filament_ramming_volumetric_speed_nc = -1,-1,-1,-1,-1,-1,-1
; filament_retract_length_nc = 18,18,18,18,18,18,18
; filament_retraction_length = 0.4,0.4,0.4,0.4,0.4,0.4,0.4
; filament_scarf_gap = 0%,0%,0%,0%,0%,0%,0%
; filament_scarf_height = 10%,10%,10%,10%,10%,10%,10%
; filament_scarf_length = 10,10,10,10,10,10,10
; filament_scarf_seam_type = none,none,none,none,none,none,none
; filament_self_index = 1,1,2,2,3,3,4,4,5,5,6,6,7,7
; filament_settings_id = "Bambu PLA Basic @BBL H2C";"Bambu PLA Basic @BBL H2C";"Bambu PLA Basic @BBL H2C";"Bambu PLA Basic @BBL H2C";"Bambu PLA Basic @BBL H2C";"Bambu PLA Basic @BBL H2C";"Bambu PLA Basic @BBL H2C"
; filament_shrink = 100%,100%,100%,100%,100%,100%,100%
; filament_soluble = 0,0,0,0,0,0,0
; filament_start_gcode = "; filament start gcode\n";"; filament start gcode\n";"; filament start gcode\n";"; filament start gcode\n";"; filament start gcode\n";"; filament start gcode\n";"; filament start gcode\n"
; filament_type = PLA;PLA;PLA;PLA;PLA;PLA;PLA
; filament_velocity_adaptation_factor = 1,1,1,1,1,1,1
; filament_vendor = "Bambu Lab";"Bambu Lab";"Bambu Lab";"Bambu Lab";"Bambu Lab";"Bambu Lab";"Bambu Lab"
; filament_volume_map = 0,0,0,0,0,0,0
; filament_wipe = 1,1,1,1,1,1,1
; filament_wipe_distance = 1,1,1,1,1,1,1
; filament_z_hop_types = Spiral Lift,Spiral Lift,Spiral Lift,Spiral Lift,Spiral Lift,Spiral Lift,Spiral Lift
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0,0,0,0,0,0,0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1,1
; flush_volumes_matrix = 0,569,900,504,480,540,606,214,0,534,322,277,280,414,150,319,0,352,330,240,255,213,494,636,0,408,283,364,90,471,330,306,0,120,499,90,491,630,392,270,0,532,232,304,452,194,291,295,0,0,584,900,519,480,540,621,229,0,549,337,292,295,429,150,334,0,367,330,240,270,228,509,651,0,423,298,379,90,486,330,321,0,120,514,90,506,630,407,270,0,547,247,319,467,209,306,310,0
; flush_volumes_vector = 140,140,140,140,140,140,140,140,140,140,140,140,140,140
; full_fan_speed_layer = 0,0,0,0,0,0,0
; fuzzy_skin = none
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250,250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0,0
; group_algo_with_time = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0,0,0,0,0,0,0
; hole_coef_2 = -0.008,-0.008,-0.008,-0.008,-0.008,-0.008,-0.008
; hole_coef_3 = 0.18,0.18,0.18,0.18,0.18,0.18,0.18
; hole_limit_max = 0.22,0.22,0.22,0.22,0.22,0.22,0.22
; hole_limit_min = 0.088,0.088,0.088,0.088,0.088,0.088,0.088
; host_type = octoprint
; hot_plate_temp = 55,55,55,55,55,55,55
; hot_plate_temp_initial_layer = 55,55,55,55,55,55,55
; hotend_cooling_rate = 2,3
; hotend_heating_rate = 3.6,16
; impact_strength_z = 13.8,13.8,13.8,13.8,13.8,13.8,13.8
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; initial_layer_acceleration = 500,500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105,105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50,50
; initial_layer_travel_acceleration = 6000,6000
; inner_wall_acceleration = 0,0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300,300
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250,250
; ironing_direction = 45
; ironing_flow = 15%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 1,1
; long_retractions_when_ec = 1,1,1,1,1,1,1
; machine_end_gcode = ;===== machine: H2C end =====\n;====== date: 20251111 ======\n\nG392 S0 ;turn off nozzle clog detect\nM993 A0 B0 C0 ; nozzle cam detection not allowed.\n\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG1 E-0.8 F1800 ; retract\nM400\nM211 Z1\nG1 Z{max_layer_z + 0.4} F900 ; lower z a little\nM640.2 R0\n\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    G150.3\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S5 ;wait for last picture to be taken\nM623  ;end of "timelapse_record_flag"\n\nG90\nG1 Z{max_layer_z + 10} F900 ; lower z a little\n\nG90\nM141 S0 ; turn off chamber heating\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\nM106 P9 S0 ; turn off ext toodhead cooling fan\n\n; pull back filament to AMS\nM620 S65535\n{if long_retraction_when_cut}\nM620.11 P1 I[current_extruder] E-{retraction_distance_when_cut} F{max((flush_volumetric_speeds[current_extruder]/2.4053*60), 200)}\n{else}\nM620.11 P0 I[current_extruder] E0\n{endif}\n\n{if long_retraction_when_ec}\nM620.11 K1 I[current_extruder] R{retraction_distance_when_ec} F{max((flush_volumetric_speeds[current_extruder]/2.4053*60), 200)}\n{else}\nM620.11 K0 I[current_extruder] R0\n{endif}\n\nM620.11 P1 I[current_extruder] E-14\nT65535\nG150.2\nM621 S65535\n\nM620 S65279\nT65279\nG150.2\nM621 S65279\n\nG150.3\n\nM104 S0 T0; turn off hotend\nM104 S0 T1; turn off hotend\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (100.0 - max_layer_z/2) > 0}\n    {if (max_layer_z + 100.0 - max_layer_z/2) < 320}\n        G1 Z{max_layer_z + 100.0 - max_layer_z/2} F600\n        G1 Z{max_layer_z + 98.0 - max_layer_z/2}\n    {else}\n        G1 Z320 F600\n        G1 Z320\n    {endif}\n{else}\n    {if (max_layer_z + 4.0) < 320}\n        G1 Z{max_layer_z + 4.0} F600\n        G1 Z{max_layer_z + 2.0}\n    {else}\n        G1 Z320 F600\n        G1 Z320\n    {endif}\n{endif}\nM400 P100\nM17 R ; restore z current\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM1015.4 S0 K0 ;disable air printing detect\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A53 B10 L99 C53 D10 M99 E53 F10 N99 \nM1006 A57 B10 L99 C57 D10 M99 E57 F10 N99 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A53 B10 L99 C53 D10 M99 E53 F10 N99 \nM1006 A57 B10 L99 C57 D10 M99 E57 F10 N99 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A48 B10 L99 C48 D10 M99 E48 F10 N99 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A60 B10 L99 C60 D10 M99 E60 F10 N99 \nM1006 W\n;=====printer finish  sound=========\nM400\nM18\n\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 15
; machine_max_acceleration_e = 5000,5000,5000,5000
; machine_max_acceleration_extruding = 20000,20000,20000,20000
; machine_max_acceleration_retracting = 5000,5000,5000,5000
; machine_max_acceleration_travel = 9000,9000,9000,9000
; machine_max_acceleration_x = 20000,20000,20000,20000
; machine_max_acceleration_y = 20000,20000,20000,20000
; machine_max_acceleration_z = 500,500,500,500
; machine_max_jerk_e = 2.5,2.5,2.5,2.5
; machine_max_jerk_x = 9,9,9,9
; machine_max_jerk_y = 9,9,9,9
; machine_max_jerk_z = 3,3,3,3
; machine_max_speed_e = 50,50,50,50
; machine_max_speed_x = 1000,1000,1000,1000
; machine_max_speed_y = 1000,1000,1000,1000
; machine_max_speed_z = 30,30,30,30
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = ;===== machine: H2C =========================\n;===== date: 20251210 =====================\n\n;M1002 set_flag extrude_cali_flag=1\n;M1002 set_flag g29_before_print_flag=1\n;M1002 set_flag auto_cali_toolhead_offset_flag=1\n;M1002 set_flag build_plate_detect_flag=1\n\nM993 A0 B0 C0 ; nozzle cam detection not allowed.\n\nM400\n;M73 P99\n\nM960 S10 P1 ; ext fan led\n\n;=====printer start sound ===================\nM17\nM400 S1\nM1006 S1\nM1006 A53 B9 L99 C53 D9 M99 E53 F9 N99 \nM1006 A56 B9 L99 C56 D9 M99 E56 F9 N99 \nM1006 A61 B9 L99 C61 D9 M99 E61 F9 N99 \nM1006 A53 B9 L99 C53 D9 M99 E53 F9 N99 \nM1006 A56 B9 L99 C56 D9 M99 E56 F9 N99 \nM1006 A61 B18 L99 C61 D18 M99 E61 F18 N99 \nM1006 W\n;=====printer start sound ===================\n\n;===== reset machine status =================\nM204 S10000\nM630 S0 P0\n\nG90\nM17 D ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM1002 set_gcode_claim_speed_level 5 ;Reset speed level\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\nG29.1 Z{+0.0} ; clear z-trim value first\nM983.1 M1 \nM901 D4\nM481 S0 ; turn off cutter pos comp\nG28.140 D0; reset pre-extrude z pos\n;===== reset machine status =================\n\nM620 M ;enable remap\nM620 N ;enable hotend remap\nM620 T0 ;print tmpr\nM620 T1 ;sn -> pos\nM620 T2 ;filament_id\n\n;===== start to heat heatbed & hotend==========\n\n    M104 O-80 A\n    M140 D[bed_temperature_initial_layer_single]\n\n;===== start to heat heatbead & hotend==========\n\n;===== avoid end stop =================\nG91\nG380 S2 Z42 F1200\nG380 S2 Z-12 F1200\nG90\n;===== avoid end stop =================\n\n;==== set airduct mode ==== \n\n{if (overall_chamber_temperature >= 40)}\n\n    M145 P1 ; set airduct mode to heating mode for heating\n    M106 P2 S0 ; turn off auxiliary fan\n    M106 P3 S0 ; turn off chamber fan\n\n{else}\n    M145 P0 ; set airduct mode to cooling mode for cooling\n    M106 P2 S178 ; turn on auxiliary fan for cooling\n    M106 P3 S127 ; turn on chamber fan for cooling\n\n    M1002 gcode_claim_action : 29\n    M191 S0 ; wait for chamber temp\n    M106 P2 S0 ; turn off auxiliary fan\n    {if (min_vitrification_temperature <= 50)}\n        {if (nozzle_diameter == 0.2)}\n            M142 P1 R30 S35 T40 U0.3 V0.5 W0.8 O40 ; set PLA/TPU ND0.2 chamber autocooling\n        {else}\n            M142 P1 R30 S40 T45 U0.3 V0.5 W0.8 O45; set PLA/TPU ND0.4 chamber autocooling\n        {endif}\n    {else}\n        {if (!is_all_bbl_filament)}\n            M142 P1 R35 S40 T45 U0.3 V0.5 W0.8 O45 L1 ; set third-party PETG chamber autocooling\n        {else}\n            {if (nozzle_diameter == 0.2)}\n                M142 P1 R35 S45 T50 U0.3 V0.5 W0.8 O50 L1 ; set PETG ND0.2 chamber autocooling\n            {else}\n                M142 P1 R35 S50 T55 U0.3 V0.5 W0.8 O55 L1 ; set PETG ND0.4 chamber autocooling\n            {endif}\n        {endif}\n    {endif}\n{endif}\n;==== set airduct mode ==== \n\n\n;====== cog noise reduction=================\nM982.2 S1 ; turn on cog noise reduction\n\n;===== first homing start =====\nM1002 gcode_claim_action : 13\n\nM640 S\nM640.1 R\nM641\nG28 X T300\nT1000\n\nG150.3\nM972 S24 P0 T2000 ; live-view camera foolproof\nM972 S46 P0 T5000 ; vortek anti-collision\nM640.1 S\nM640.4\n{if (first_non_support_filaments[0] != -1)}\nM640 S\nM640.8 T A{first_non_support_filaments[0]}\nM640.7 L\nM641\n{endif}\n\n\n{if wipe_tower_center_pos_valid}\n    M620.14 X[wipe_tower_center_pos_x] Y[wipe_tower_center_pos_y]\n{else}\n    M620.14 X95.5 Y336\n{endif}\n\n\nG150.1 F18000 ; wipe mouth to avoid filament stick to heatbed\nG150.3 F18000\nM400 P200\n\n{if curr_bed_type=="Textured PEI Plate"}\nM972 S26 P0 C0\n{else}\nM972 S36 P0 C0 X1\n{endif}\nM972 S35 P0 C0\n\nM972 S41 P0 T5000 ; trash can anti-collision\n\nM1009 Q1 L1\nG90\nG1 X175 Y160 F30000\nG28 Z P0 T250\nM1009 Q1 L0\n\n\n;===== first homing end =====\n\nM104 O-80 A\n\n;===== detection start =====\n    \n\nM1002 judge_flag build_plate_detect_flag\nM622 S1\n    M972 S19 P0 C0    ; heatbed presence detection\n    M972 S31 P0 T5000 ; toolhead camera dirty detection\n    M972 S34 P0 T5000 ; heatbed plate offset detection\nM623\n\nT1001\nM972 S14 P0 T5000 ; nozzle type detection\n\nM104 O-80 A ; rise temp in advance\n\n;===== detection end =====\n\nM400\n;M73 P99\n\n;===== prepare print temperature and material ==========\nM400\nM211 X0 Y0 Z0 ;turn off soft endstop\nM975 S1 ; turn on input shaping\n\nG29.2 S0 ; avoid invalid abl data\n\n{if ((filament_type[initial_no_support_extruder] == "PLA") || (filament_type[initial_no_support_extruder] == "PLA-CF") || (filament_type[initial_no_support_extruder] == "PETG")) && (nozzle_diameter[initial_no_support_extruder] == 0.2)}\nM620.10 A0 F74.8347 H{nozzle_diameter[initial_no_support_extruder]} T{flush_temperatures[initial_no_support_extruder]} P{nozzle_temperature_initial_layer[initial_no_support_extruder]} S1\nM620.10 A1 F74.8347 H{nozzle_diameter[initial_no_support_extruder]} T{flush_temperatures[initial_no_support_extruder]} P{nozzle_temperature_initial_layer[initial_no_support_extruder]} S1\n{else}\nM620.10 A0 F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60*0.8} H{nozzle_diameter[initial_no_support_extruder]} T{flush_temperatures[initial_no_support_extruder]} P{nozzle_temperature_initial_layer[initial_no_support_extruder]} S1\nM620.10 A1 F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60*0.8} H{nozzle_diameter[initial_no_support_extruder]} T{flush_temperatures[initial_no_support_extruder]} P{nozzle_temperature_initial_layer[initial_no_support_extruder]} S1\n{endif}\n\nM620.11 P1 I[initial_no_support_extruder] E0\n\n{if long_retraction_when_ec }\nM620.11 K1 I[initial_no_support_extruder] R{retraction_distance_when_ec} F{max((flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60), 200)}\n{else}\nM620.11 K0 I[initial_no_support_extruder] R0\n{endif}\n\nM628 S1\n{if filament_type[initial_no_support_extruder] == "TPU"}\n    M620.11 S0 L0 I[initial_no_support_extruder] E-{retraction_distances_when_cut[initial_no_support_extruder]} F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60}\n{else}\n{if (filament_type[initial_no_support_extruder] == "PA") ||  (filament_type[initial_no_support_extruder] == "PA-GF")}\n    M620.11 S1 L0 I[initial_no_support_extruder] R4 D2 E-{retraction_distances_when_cut[initial_no_support_extruder]} F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60}\n{else}\n    M620.11 S1 L0 I[initial_no_support_extruder] R10 D8 E-{retraction_distances_when_cut[initial_no_support_extruder]} F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60}\n{endif}\n{endif}\nM629\n\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\nM1002 gcode_claim_action : 4\nM1002 set_filament_type:UNKNOWN\nM400\nT[initial_no_support_extruder]\nM400\nM628 S0\nM629\nM400\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\nM621 S[initial_no_support_extruder]A\n\nM104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\nM400\nM106 P1 S0\n\nG91\nG1 Y-16 F60000\nG90\n\nG29.2 S1\n;===== prepare print temperature and material ==========\n\n\nM400\n;M73 P99\n\n;===== xy ofst cali start =====\n\nM1002 judge_flag auto_cali_toolhead_offset_flag\n\nM622 J2\n    M1002 gcode_claim_action : 54\n    M190 D[bed_temperature_initial_layer_single]\n    \n    M1002 gcode_claim_action : 39\n    G383.3 U140 L{initial_no_support_extruder}\n    M500\nM623\n\nM622 J1\n    M1002 gcode_claim_action : 54\n    M190 D[bed_temperature_initial_layer_single]\n\n    M1002 gcode_claim_action : 39\n    G383 O2 U140 L{initial_no_support_extruder}\n    M500\nM623\n\n;===== xy ofst cali end =====\n\n;===== start to heat heatbed & hotend==========\n\n    M1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n    G150.3\n    M104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\n    M140 S[bed_temperature_initial_layer_single]\n\n    ;===== set chamber temperature ==========\n    {if (overall_chamber_temperature >= 40)}\n        M145 P1 ; set airduct mode to heating mode\n        M141 S[overall_chamber_temperature] ; Let Chamber begin to heat\n    {endif}\n    ;===== set chamber temperature ==========\n\n;===== start to heat heatbead & hotend==========\n\n\n\nM400\n;M73 P99\n\n;===== auto extrude cali start =========================\nM975 S1\nM1002 judge_flag extrude_cali_flag\n\nM622 J0\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4} A0.4 ; cali dynamic extrusion compensation\nM623\n\nM622 J1\n    M1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n    M1002 gcode_claim_action : 8\n\n    M109 S{nozzle_temperature[initial_no_support_extruder]}\n\n    G90\n    M83\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4} A0.4 ; cali dynamic extrusion compensation\n\n    M400\n    M106 P1 S255\n    M400 S5\n    M106 P1 S0\n    G150.3\nM623\n\nM622 J2\n    M1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n    M1002 gcode_claim_action : 8\n\n    M109 S{nozzle_temperature[initial_no_support_extruder]}\n\n    G90\n    M83\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4} A0.4 ; cali dynamic extrusion compensation\n\n    M400\n    M106 P1 S255\n    M400 S5\n    M106 P1 S0\n    G150.3\nM623\n\n;===== auto extrude cali end =========================\n\n{if filament_type[initial_no_support_extruder] == "TPU"}\n    G150.2\n    G150.1\n    G150.2\n    G150.1\n    G150.2\n    G150.1\n{else}\n    G150.3\n    M106 P1 S0\n    M400 S2\n    M109 S{nozzle_temperature[initial_no_support_extruder]} ; wait tmpr to extrude\n    M83\n    {if(nozzle_diameter == 0.8)}\n        G1 E60 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60}\n    {else}\n        G1 E45 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60}\n    {endif}\n    G1 E-3 F1800\n    M400 P500\n    G150.2\n    G150.1\n{endif}\n\nG91\nG1 Y-16 F12000 ; move away from the trash bin\nG90\n\nM400\n;M73 P99\n\n;===== wipe right nozzle start =====\n\nM1002 gcode_claim_action : 14\n    G150 T{nozzle_temperature_initial_layer[initial_no_support_extruder]}\n    {if (overall_chamber_temperature >= 40)}\n        G150 T{nozzle_temperature_initial_layer[initial_no_support_extruder] - 80}\n    {endif}\nM106 S255 ; turn on fan to cool the nozzle\n\n;===== wipe left nozzle end =====\n\nM400\n;M73 P99\n\nM1002 judge_flag auto_cali_toolhead_offset_flag\nM622 J0\n    G91\n    G1 Z5 F1200\n    G90\n    M1012.7\n    G383.7 U140 J0\n    M500\nM623\n\n{if (overall_chamber_temperature >= 40)}\n    M1002 gcode_claim_action : 49\n    M191 S[overall_chamber_temperature] ; wait for chamber temp\n{endif}\n\nM400\n;M73 P99\n\n;===== bed leveling ==================================\n\nM1002 judge_flag g29_before_print_flag\n\nM190 S[bed_temperature_initial_layer_single]; ensure bed temp\nM109 S140 A\nM106 S0 ; turn off fan , too noisy\n\nG91\nG1 Z10 F1200\n{if (first_non_support_filaments[0] != -1)}\nM640 S\nM83\nG1 E-2 F1800\nM640.7 U\nM640.7 L\nM640.2 R1\nM641\n{endif}\nG90\nG1 X175 Y160 F30000\n\nM622 J1\n    M1002 gcode_claim_action : 1\n    G29.20 A3\n    G29 A1 O X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]} R \n    M400\n    M500 ; save cali data\nM623\n    \nM622 J2\n    M1002 gcode_claim_action : 1\n    {if has_tpu_in_first_layer}\n        G29.20 A3\n        G29 A1 O X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]} R\n    {else}\n        G29.20 A4\n        G29 A2 O X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]} R\n    {endif}\n    M400\n    M500 ; save cali data\nM623\n\nM622 J0\n    G28 R\nM623\n\n;===== bed leveling end ================================\n\nG39.1 ; cali nozzle wrapped detection pos\nM500\n\nG90\nG1 Z5 F1200\nG1 X270 Y-0.5 F60000\nG28.140 S0 ; cali pre-extrude z pos\n\n;============switch again==================\n\nM211 X0 Y0 Z0 ;turn off soft endstop\nG91\nG1 Z6 F1200\nG90\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\nM620 S[initial_no_support_extruder]A\nM400\nT[initial_no_support_extruder]\nM400\nM628 S0\nM629\nM400\nM621 S[initial_no_support_extruder]A\n\n;============switch again==================\n\nM400\n;M73 P99\n\nM141 S[overall_chamber_temperature]\n\n;===== mech mode sweep start =====\n    M1002 gcode_claim_action : 3\n\n    G90\n    G1 Z5 F1200\n    G1 X165 Y160 F20000\n    M400 P200\n\n    M970.3 Q1 A5 K0 O1\n    M974 Q1 S2 P0\n\n    M970.3 Q0 A5 K0 O1\n    M974 Q0 S2 P0\n\n    M970.2 Q2 K0 W38 Z0.01\n    M974 Q2 S2 P0\n    M500\n\n    M975 S1\n;===== mech mode sweep end =====\n\n;===== wait temperature reaching the reference value =======\n\nM140 S[bed_temperature_initial_layer_single] \nM190 S[bed_temperature_initial_layer_single] \n\n    ;========turn off light and fans =============\n    M960 S1 P0 ; turn off laser\n    M960 S2 P0 ; turn off laser\n    M106 S0 ; turn off fan\n    M106 P2 S0 ; turn off big fan\n    ;==== set ext toodhead cooling fan ==== \n    {if (min_vitrification_temperature <= 50)}\n    M106 P9 S255\n    {endif}\n    ;============set motor current==================\n    M400 S1\n\n;===== wait temperature reaching the reference value =======\n\nM400\n;M73 P99\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n    {if curr_bed_type=="Textured PEI Plate"}\n        G29.1 Z{-0.02} ; for Textured PEI Plate\n    {endif}\n    \nG150.1\n\nM975 S1 ; turn on mech mode supression\nM983.4 S1 ; turn on deformation compensation \nG29.2 S1 ; turn on pos comp\nG29.7 S1\n\nG90\nG1 Z5 F1200\nG1 Y295 F30000\nG1 Y265 F18000\n\n;===== nozzle load line ===============================\n    G29.2 S1 ; ensure z comp turn on\n    G90\n    M83\n    G1 Z5 F1200\n    G1 X270 Y-0.5 F60000\n    G28.14 R0\n    G29.2 S0\n    G91\n    G1 Z0.8 F1200\n    G90\n    G1 X250 F60000\n    M104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\n    \n    ========== record data ==========\n    M1026\n    M1012.8\n    M1012.9\n    G29.9\n    ========== record data ==========\n    \n    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\n    M83\n    G1 E5 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*60}\n    G1 X290 E10 F{filament_max_volumetric_speed[initial_no_support_extruder]/2.4053*4*60}\n    G91\n    G3 Z0.4 I1.217 J0 P1 F60000\n    G90\n    M83\n    G29.2 S1 ; ensure z comp turn on\n;===== noozle load line end ===========================\n\nM400\n;M73 P99\n\nM993 A1 B1 C1 ; nozzle cam detection allowed.\n\n{if (filament_type[initial_no_support_extruder] == "TPU")}\nM1015.3 S1;enable tpu clog detect\n{else}\nM1015.3 S0;disable tpu clog detect\n{endif}\n\n{if (filament_type[initial_no_support_extruder] == "PLA") ||  (filament_type[initial_no_support_extruder] == "PETG")\n ||  (filament_type[initial_no_support_extruder] == "PLA-CF")  ||  (filament_type[initial_no_support_extruder] == "PETG-CF")}\nM1015.4 S1 K1 H[nozzle_diameter] ;enable E air printing detect\n{else}\nM1015.4 S0 K0 H[nozzle_diameter] ;disable E air printing detect\n{endif}\n\nM620.6 I[initial_no_support_extruder] W1 ;enable ams air printing detect\n\nM211 Z1\nG29.99\nM1002 gcode_claim_action : 0\nM400\n\n\n
; machine_switch_extruder_time = 5
; machine_unload_filament_time = 15
; master_extruder_id = 2
; max_bridge_length = 0
; max_layer_height = 0.28,0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08,0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; no_slow_down_for_cooling_on_outwalls = 0,0,0,0,0,0,0
; nozzle_diameter = 0.4,0.4
; nozzle_flush_dataset = 1,1
; nozzle_height = 4
; nozzle_temperature = 220,220,220,220,220,220,220
; nozzle_temperature_initial_layer = 220,220,220,220,220,220,220
; nozzle_temperature_range_high = 240,240,240,240,240,240,240
; nozzle_temperature_range_low = 190,190,190,190,190,190,190
; nozzle_type = hardened_steel,hardened_steel
; nozzle_volume = 130,145
; nozzle_volume_type = Standard,Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000,5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200,200
; overhang_1_4_speed = 0,0
; overhang_2_4_speed = 50,50
; overhang_3_4_speed = 30,30
; overhang_4_4_speed = 10,10
; overhang_fan_speed = 100,100,100,100,100,100,100
; overhang_fan_threshold = 50%,50%,50%,50%,50%,50%,50%
; overhang_threshold_participating_cooling = 95%,95%,95%,95%,95%,95%,95%
; overhang_totally_speed = 10,10
; override_filament_scarf_seam_setting = 0
; physical_extruder_map = 1,0
; post_process = 
; pre_start_fan_time = 2,2,2,2,2,2,2
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02,0.02,0.02,0.02,0.02,0.02,0.02
; prime_tower_brim_width = -1
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 1
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 60
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab H2C 0.4 nozzle"
; print_extruder_id = 1,2
; print_extruder_variant = "Direct Drive Standard";"Direct Drive Standard"
; print_flow_ratio = 1
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL H2C
; printable_area = 0x0,330x0,330x320,0x320
; printable_height = 325
; printer_extruder_id = 1,2
; printer_extruder_variant = "Direct Drive Standard";"Direct Drive Standard"
; printer_model = Bambu Lab H2C
; printer_notes = 
; printer_settings_id = Bambu Lab H2C 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1,1,1,1,1,1,1
; reduce_infill_retraction = 1
; required_nozzle_HRC = 3,3,3,3,3,3,3
; resolution = 0.012
; retract_before_wipe = 0%,0%
; retract_length_toolchange = 2,2
; retract_lift_above = 0,0
; retract_lift_below = 319,319
; retract_restart_extra = 0,0
; retract_restart_extra_toolchange = 0,0
; retract_when_changing_layer = 1,1
; retraction_distances_when_cut = 14,14
; retraction_distances_when_ec = 10,10,10,10,10,10,10
; retraction_length = 0.8,0.8
; retraction_minimum_travel = 1,1
; retraction_speed = 30,30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 7%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 7%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1,1,1,1,1,1,1
; slow_down_layer_time = 4,4,4,4,4,4,4
; slow_down_min_speed = 20,20,20,20,20,20,20
; slowdown_end_acc = 100000,100000
; slowdown_end_height = 400,400
; slowdown_end_speed = 1000,1000
; slowdown_start_acc = 100000,100000
; slowdown_start_height = 0,0
; slowdown_start_speed = 1000,1000
; small_perimeter_speed = 50%,50%
; small_perimeter_threshold = 0,0
; smooth_coefficient = 4
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%,100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 7%
; sparse_infill_filament = 0
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = gyroid
; sparse_infill_speed = 350,350
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 40,40,40,40,40,40,40
; supertack_plate_temp_initial_layer = 40,40,40,40,40,40,40
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 1
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80,80
; support_interface_top_layers = 2
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150,150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 45,45,45,45,45,45,45
; template_custom_gcode = 
; textured_plate_temp = 55,55,55,55,55,55,55
; textured_plate_temp_initial_layer = 55,55,55,55,55,55,55
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;===== machine: H2C timelapse =====\n;======== date: 20251110 ========\n\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\n\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    M993 A2 B2 C2\n    M993 A0 B0 C0\n\n    {if !spiral_mode && !(has_timelapse_safe_pos && timelapse_type == 0) }\n        {if most_used_physical_extruder_id!= curr_physical_extruder_id || timelapse_type == 1}\n            M83\n            G1 Z{max_layer_z + 0.4} F1200\n            M400\n        {endif}\n    {endif}\n\n    {if has_timelapse_safe_pos && timelapse_type == 0 && !spiral_mode}\n        M9711 M{timelapse_type} E{most_used_physical_extruder_id} X{timelapse_pos_x} Y{timelapse_pos_y} Z{layer_z + 0.4} S11 C10 O0 T3000\n    {else}\n        {if spiral_mode}\n            M971 S11 C10 O0\n            M1004 S5 P1  ; external shutter\n        {else}\n            M9711 M{timelapse_type} E{most_used_physical_extruder_id} Z{layer_z + 0.4} S11 C10 O0 T3000\n        {endif}\n    {endif}\n\n    {if !spiral_mode && !(has_timelapse_safe_pos && timelapse_type == 0) }\n        {if most_used_physical_extruder_id!= curr_physical_extruder_id || timelapse_type == 1}\n            G90\n            G1 Z{max_layer_z + 3.0} F1200\n            G1 Y295 F30000\n            G1 Y265 F18000\n            M83\n        {endif}\n    {endif}\n    \n    M993 A3 B3 C3\nM623\n; SKIPPABLE_END\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000,2000
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200,200
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000,10000
; travel_jerk = 9
; travel_speed = 1000,1000
; travel_speed_z = 0,0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab H2S 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%,80%
; volumetric_speed_coefficients = "0 0 0 0 0 0";"0 0 0 0 0 0";"0 0 0 0 0 0";"0 0 0 0 0 0";"0 0 0 0 0 0";"0 0 0 0 0 0";"0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 2
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1,1
; wipe_distance = 2,2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 165
; wipe_tower_y = 250
; wrapping_detection_gcode = ;===== machine: H2C =========================\n;===== date: 20251104 =====================\n\n{if !spiral_mode}\n    {if layer_num == 3 || layer_num == 10 || layer_num == 19}\n        M993 A2 B2 C2 ; nozzle cam detection allow status save.\n        M993 A0 B0 C0 ; nozzle cam detection not allowed.\n\n        M400 P100\n\n        G39\n\n        G90\n        G1 Y295 F30000\n        G1 Y265 F18000\n        \n        M993 A3 B3 C3 ; nozzle cam detection allow status restore.\n    {endif}\n{endif}\n
; wrapping_detection_layers = 20
; wrapping_exclude_area = 145x310,251x310,251x326,145x326
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 1
; z_hop = 0.4,0.4
; z_hop_types = Auto Lift,Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R13
M201 X20000 Y20000 Z500 E5000
M203 X1000 Y1000 Z30 E50
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;===== machine: H2C =========================
;===== date: 20251210 =====================

;M1002 set_flag extrude_cali_flag=1
;M1002 set_flag g29_before_print_flag=1
;M1002 set_flag auto_cali_toolhead_offset_flag=1
;M1002 set_flag build_plate_detect_flag=1

M993 A0 B0 C0 ; nozzle cam detection not allowed.

M400
;M73 P99

M960 S10 P1 ; ext fan led

;=====printer start sound ===================
M17
M400 S1
M1006 S1
M1006 A53 B9 L99 C53 D9 M99 E53 F9 N99 
M1006 A56 B9 L99 C56 D9 M99 E56 F9 N99 
M1006 A61 B9 L99 C61 D9 M99 E61 F9 N99 
M1006 A53 B9 L99 C53 D9 M99 E53 F9 N99 
M1006 A56 B9 L99 C56 D9 M99 E56 F9 N99 
M1006 A61 B18 L99 C61 D18 M99 E61 F18 N99 
M1006 W
;=====printer start sound ===================

;===== reset machine status =================
M204 S10000
M630 S0 P0

G90
M17 D ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M1002 set_gcode_claim_speed_level 5 ;Reset speed level
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
G29.1 Z0 ; clear z-trim value first
M983.1 M1 
M901 D4
M481 S0 ; turn off cutter pos comp
G28.140 D0; reset pre-extrude z pos
;===== reset machine status =================

M620 M ;enable remap
M620 N ;enable hotend remap
M620 T0 ;print tmpr
M620 T1 ;sn -> pos
M620 T2 ;filament_id

;===== start to heat heatbed & hotend==========

    M104 O-80 A
    M140 D55

;===== start to heat heatbead & hotend==========

;===== avoid end stop =================
G91
G380 S2 Z42 F1200
G380 S2 Z-12 F1200
G90
;===== avoid end stop =================

;==== set airduct mode ==== 


    M145 P0 ; set airduct mode to cooling mode for cooling
    M106 P2 S178 ; turn on auxiliary fan for cooling
    M106 P3 S127 ; turn on chamber fan for cooling

    M1002 gcode_claim_action : 29
    M191 S0 ; wait for chamber temp
    M106 P2 S0 ; turn off auxiliary fan
    
        
            M142 P1 R30 S40 T45 U0.3 V0.5 W0.8 O45; set PLA/TPU ND0.4 chamber autocooling
        
    

;==== set airduct mode ==== 


;====== cog noise reduction=================
M982.2 S1 ; turn on cog noise reduction

;===== first homing start =====
M1002 gcode_claim_action : 13

M640 S
M640.1 R
M641
G28 X T300
T1000

G150.3
M972 S24 P0 T2000 ; live-view camera foolproof
M972 S46 P0 T5000 ; vortek anti-collision
M640.1 S
M640.4

M640 S
M640.8 T A0
M640.7 L
M641




    M620.14 X95.5 Y336



G150.1 F18000 ; wipe mouth to avoid filament stick to heatbed
G150.3 F18000
M400 P200


M972 S26 P0 C0

M972 S35 P0 C0

M972 S41 P0 T5000 ; trash can anti-collision

M1009 Q1 L1
G90
G1 X175 Y160 F30000
G28 Z P0 T250
M1009 Q1 L0


;===== first homing end =====

M104 O-80 A

;===== detection start =====
    

M1002 judge_flag build_plate_detect_flag
M622 S1
    M972 S19 P0 C0    ; heatbed presence detection
    M972 S31 P0 T5000 ; toolhead camera dirty detection
    M972 S34 P0 T5000 ; heatbed plate offset detection
M623

T1001
M972 S14 P0 T5000 ; nozzle type detection

M104 O-80 A ; rise temp in advance

;===== detection end =====

M400
;M73 P99

;===== prepare print temperature and material ==========
M400
M211 X0 Y0 Z0 ;turn off soft endstop
M975 S1 ; turn on input shaping

G29.2 S0 ; avoid invalid abl data


M620.10 A0 F498.898 H0.4 T240 P220 S1
M620.10 A1 F498.898 H0.4 T240 P220 S1


M620.11 P1 I0 E0


M620.11 K1 I0 R10 F623.623


M628 S1


    M620.11 S1 L0 I0 R10 D8 E-14 F623.623


M629

M620 S0A   ; switch material if AMS exist
M1002 gcode_claim_action : 4
M1002 set_filament_type:UNKNOWN
M400
T0
M400
M628 S0
M629
M400
M1002 set_filament_type:PLA
M621 S0A

M104 S220
M400
M106 P1 S0

G91
G1 Y-16 F60000
G90

G29.2 S1
;===== prepare print temperature and material ==========


M400
;M73 P99

;===== xy ofst cali start =====

M1002 judge_flag auto_cali_toolhead_offset_flag

M622 J2
    M1002 gcode_claim_action : 54
    M190 D55
    
    M1002 gcode_claim_action : 39
    G383.3 U140 L0
    M500
M623

M622 J1
    M1002 gcode_claim_action : 54
    M190 D55

    M1002 gcode_claim_action : 39
    G383 O2 U140 L0
    M500
M623

;===== xy ofst cali end =====

;===== start to heat heatbed & hotend==========

    M1002 set_filament_type:PLA
    G150.3
    M104 S220
    M140 S55

    ;===== set chamber temperature ==========
    
    ;===== set chamber temperature ==========

;===== start to heat heatbead & hotend==========



M400
;M73 P99

;===== auto extrude cali start =========================
M975 S1
M1002 judge_flag extrude_cali_flag

M622 J0
    M983.3 F10.4167 A0.4 ; cali dynamic extrusion compensation
M623

M622 J1
    M1002 set_filament_type:PLA
    M1002 gcode_claim_action : 8

    M109 S220

    G90
    M83
    M983.3 F10.4167 A0.4 ; cali dynamic extrusion compensation

    M400
    M106 P1 S255
    M400 S5
    M106 P1 S0
    G150.3
M623

M622 J2
    M1002 set_filament_type:PLA
    M1002 gcode_claim_action : 8

    M109 S220

    G90
    M83
    M983.3 F10.4167 A0.4 ; cali dynamic extrusion compensation

    M400
    M106 P1 S255
    M400 S5
    M106 P1 S0
    G150.3
M623

;===== auto extrude cali end =========================


    G150.3
    M106 P1 S0
    M400 S2
    M109 S220 ; wait tmpr to extrude
    M83
    
        G1 E45 F623.623
    
M73 P6 R12
    G1 E-3 F1800
    M400 P500
    G150.2
    G150.1


G91
M73 P8 R12
G1 Y-16 F12000 ; move away from the trash bin
G90

M400
;M73 P99

;===== wipe right nozzle start =====

M1002 gcode_claim_action : 14
    G150 T220
    
M106 S255 ; turn on fan to cool the nozzle

;===== wipe left nozzle end =====

M400
;M73 P99

M1002 judge_flag auto_cali_toolhead_offset_flag
M622 J0
    G91
    G1 Z5 F1200
    G90
    M1012.7
    G383.7 U140 J0
    M500
M623



M400
;M73 P99

;===== bed leveling ==================================

M1002 judge_flag g29_before_print_flag

M190 S55; ensure bed temp
M109 S140 A
M106 S0 ; turn off fan , too noisy

G91
G1 Z10 F1200

M640 S
M83
M73 P41 R7
G1 E-2 F1800
M640.7 U
M640.7 L
M640.2 R1
M641

G90
G1 X175 Y160 F30000

M622 J1
    M1002 gcode_claim_action : 1
    G29.20 A3
    G29 A1 O X187.22 Y139.162 I33 J33 R 
    M400
    M500 ; save cali data
M623
    
M622 J2
    M1002 gcode_claim_action : 1
    
        G29.20 A4
        G29 A2 O X187.22 Y139.162 I33 J33 R
    
    M400
    M500 ; save cali data
M623

M622 J0
    G28 R
M623

;===== bed leveling end ================================

G39.1 ; cali nozzle wrapped detection pos
M500

G90
G1 Z5 F1200
G1 X270 Y-0.5 F60000
G28.140 S0 ; cali pre-extrude z pos

;============switch again==================

M211 X0 Y0 Z0 ;turn off soft endstop
G91
G1 Z6 F1200
G90
M1002 set_filament_type:PLA
M620 S0A
M400
T0
M400
M628 S0
M629
M400
M621 S0A

;============switch again==================

M400
;M73 P99

M141 S0

;===== mech mode sweep start =====
    M1002 gcode_claim_action : 3

    G90
    G1 Z5 F1200
    G1 X165 Y160 F20000
    M400 P200

    M970.3 Q1 A5 K0 O1
    M974 Q1 S2 P0

    M970.3 Q0 A5 K0 O1
    M974 Q0 S2 P0

    M970.2 Q2 K0 W38 Z0.01
    M974 Q2 S2 P0
    M500

    M975 S1
;===== mech mode sweep end =====

;===== wait temperature reaching the reference value =======

M140 S55 
M190 S55 

    ;========turn off light and fans =============
    M960 S1 P0 ; turn off laser
    M960 S2 P0 ; turn off laser
    M106 S0 ; turn off fan
    M106 P2 S0 ; turn off big fan
    ;==== set ext toodhead cooling fan ==== 
    
    M106 P9 S255
    
    ;============set motor current==================
    M400 S1

;===== wait temperature reaching the reference value =======

M400
;M73 P99

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
    
        G29.1 Z-0.02 ; for Textured PEI Plate
    
    
G150.1

M975 S1 ; turn on mech mode supression
M983.4 S1 ; turn on deformation compensation 
G29.2 S1 ; turn on pos comp
G29.7 S1

G90
G1 Z5 F1200
G1 Y295 F30000
G1 Y265 F18000

;===== nozzle load line ===============================
    G29.2 S1 ; ensure z comp turn on
    G90
    M83
    G1 Z5 F1200
    G1 X270 Y-0.5 F60000
    G28.14 R0
    G29.2 S0
    G91
    G1 Z0.8 F1200
    G90
    G1 X250 F60000
    M104 S220
    
    ========== record data ==========
    M1026
    M1012.8
    M1012.9
    G29.9
    ========== record data ==========
    
    M109 S220
    M83
    G1 E5 F623.623
    G1 X290 E10 F2494.49
    G91
    G3 Z0.4 I1.217 J0 P1 F60000
    G90
    M83
    G29.2 S1 ; ensure z comp turn on
;===== noozle load line end ===========================

M400
;M73 P99

M993 A1 B1 C1 ; nozzle cam detection allowed.


M1015.3 S0;disable tpu clog detect



M1015.4 S1 K1 H0.4 ;enable E air printing detect


M620.6 I0 W1 ;enable ams air printing detect

M211 Z1
G29.99
M1002 gcode_claim_action : 0
M400


; MACHINE_START_GCODE_END
M104 T1 S0 N0 ;Multi extruder pre cooling
; filament start gcode
;VT0
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.4 F1800
; layer num/total_layer_count: 1/82
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
M106 P2 S0
; OBJECT_ID: 202
G1 X219.35 Y155.662 F60000
M204 S6000
M73 P42 R7
G1 Z.4
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X219.113 Y158.376 E.10252
G1 X218.408 Y161.008 E.10252
G1 X217.256 Y163.478 E.10252
G1 X215.694 Y165.709 E.10252
G1 X213.767 Y167.636 E.10252
G1 X211.535 Y169.199 E.10252
G1 X209.066 Y170.35 E.10252
G1 X206.434 Y171.056 E.10252
G1 X203.72 Y171.293 E.10252
G1 X201.005 Y171.055 E.10252
G1 X198.374 Y170.35 E.10252
G1 X195.904 Y169.199 E.10252
G1 X193.672 Y167.636 E.10252
G1 X191.746 Y165.709 E.10252
G1 X190.183 Y163.478 E.10251
G1 X189.031 Y161.008 E.10252
G1 X188.326 Y158.376 E.10252
G1 X188.089 Y155.662 E.10252
G1 X188.326 Y152.948 E.10252
G1 X189.031 Y150.316 E.10252
G1 X190.183 Y147.847 E.10252
G1 X191.746 Y145.615 E.10252
G1 X193.672 Y143.688 E.10252
G1 X195.904 Y142.125 E.10252
G1 X198.373 Y140.974 E.10252
G1 X201.005 Y140.269 E.10252
G1 X203.743 Y140.033 E.1034
G1 X206.434 Y140.269 E.10162
G1 X209.066 Y140.974 E.10252
G1 X211.535 Y142.125 E.10252
G1 X213.767 Y143.688 E.10252
G1 X215.694 Y145.615 E.10252
G1 X217.256 Y147.847 E.10251
G1 X218.408 Y150.316 E.10252
G1 X219.113 Y152.948 E.10252
G1 X219.345 Y155.602 E.10026
M204 S6000
G1 X219.809 Y155.662 F60000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X219.565 Y158.456 E.10553
G1 X218.839 Y161.165 E.10553
G1 X217.654 Y163.707 E.10553
G1 X216.045 Y166.004 E.10553
G1 X214.062 Y167.988 E.10553
G1 X211.707 Y169.623 E.10789
G1 X209.223 Y170.781 E.10312
G1 X206.513 Y171.507 E.10553
G1 X203.72 Y171.752 E.10553
G1 X200.926 Y171.507 E.10553
G1 X198.217 Y170.781 E.10553
G1 X195.675 Y169.596 E.10553
G1 X193.332 Y167.942 E.1079
G1 X191.394 Y166.004 E.10312
G1 X189.785 Y163.707 E.10552
G1 X188.6 Y161.165 E.10553
G1 X187.874 Y158.456 E.10553
G1 X187.63 Y155.662 E.10553
G1 X187.874 Y152.868 E.10553
G1 X188.6 Y150.159 E.10553
G1 X189.785 Y147.617 E.10553
G1 X191.394 Y145.32 E.10553
G1 X193.377 Y143.337 E.10553
G1 X195.675 Y141.728 E.10553
G1 X198.217 Y140.543 E.10553
G1 X200.926 Y139.817 E.10553
G1 X203.783 Y139.578 E.10789
G1 X206.513 Y139.817 E.10312
G1 X209.223 Y140.543 E.10553
G1 X211.764 Y141.728 E.10553
G1 X214.062 Y143.337 E.10553
G1 X216.045 Y145.32 E.10553
G1 X217.654 Y147.617 E.10552
G1 X218.839 Y150.159 E.10553
G1 X219.565 Y152.868 E.10553
G1 X219.804 Y155.602 E.10327
; WIPE_START
G1 X219.721 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G17
G3 Z.6 I1.078 J-.565 P1  F60000
G1 X212.671 Y143.144 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50296
G1 F6300
M204 S500
G1 X215.4 Y145.873 E.14613
G1 X216.919 Y148.042 E.10029
G1 X211.339 Y142.463 E.29881
G1 X210.12 Y141.894 E.05094
G1 X217.487 Y149.261 E.39454
G1 X218.047 Y150.472 E.05052
G1 X208.91 Y141.334 E.48938
G1 X208.021 Y141.096 E.03484
G1 X218.285 Y151.361 E.54973
G1 X218.524 Y152.249 E.03484
G1 X207.132 Y140.858 E.61008
G1 X206.366 Y140.653 E.03004
G1 X206.268 Y140.644 E.00374
G1 X218.738 Y153.114 E.66784
G1 X218.8 Y153.827 E.0271
G1 X205.555 Y140.582 E.70936
G1 X204.842 Y140.519 E.0271
G1 X218.862 Y154.54 E.75088
G1 X218.925 Y155.253 E.0271
M73 P43 R7
G1 X204.129 Y140.457 E.79241
G2 X203.468 Y140.447 I-.359 J1.885 E.02515
G1 X218.938 Y155.917 E.82852
G1 X218.886 Y156.515 E.02274
G1 X202.869 Y140.498 E.8578
G1 X202.27 Y140.55 E.02277
G1 X218.834 Y157.113 E.88708
G1 X218.781 Y157.712 E.02274
G1 X201.671 Y140.601 E.91636
G1 X201.072 Y140.653 E.02277
G1 X218.729 Y158.31 E.94563
G1 X218.591 Y158.823 E.02012
G1 X200.559 Y140.79 E.96574
G1 X200.046 Y140.928 E.02012
G1 X218.454 Y159.336 E.98586
G1 X218.316 Y159.849 E.02012
G1 X199.533 Y141.065 E1.00598
G1 X199.019 Y141.203 E.02012
G1 X218.179 Y160.362 E1.02609
G1 X218.041 Y160.875 E.02011
G1 X198.506 Y141.34 E1.0462
G1 X198.063 Y141.547 E.01854
G1 X217.834 Y161.319 E1.05889
G1 X217.627 Y161.763 E.01854
G1 X197.619 Y141.754 E1.07157
G1 X197.175 Y141.961 E.01854
G1 X217.42 Y162.206 E1.08425
G1 X217.214 Y162.65 E.01854
G1 X196.732 Y142.168 E1.09693
G1 X196.288 Y142.375 E.01854
G1 X217.007 Y163.094 E1.10961
G3 X216.765 Y163.502 I-1.28 J-.482 E.01808
G1 X195.879 Y142.617 E1.11854
G1 X195.497 Y142.885 E.01769
M73 P44 R7
G1 X216.497 Y163.885 E1.12468
G1 X216.229 Y164.268 E.01769
G1 X195.114 Y143.153 E1.13083
G1 X194.731 Y143.421 E.01769
G1 X215.961 Y164.65 E1.13697
G1 X215.693 Y165.033 E.01769
G1 X194.349 Y143.689 E1.14312
G1 X193.966 Y143.957 E.01769
G1 X215.425 Y165.416 E1.14926
G1 X215.106 Y165.747 E.01743
G1 X193.634 Y144.275 E1.14995
G1 X193.309 Y144.601 E.01742
G1 X214.781 Y166.073 E1.14995
G1 X214.456 Y166.398 E.01742
G1 X192.984 Y144.926 E1.14995
G1 X192.658 Y145.251 E.01742
G1 X214.13 Y166.723 E1.14995
G1 X213.805 Y167.049 E.01742
G1 X192.333 Y145.577 E1.14995
G1 X192.014 Y145.908 E.01743
G1 X213.473 Y167.367 E1.14926
G1 X213.091 Y167.635 E.01769
G1 X191.746 Y146.291 E1.14312
G1 X191.478 Y146.674 E.01769
G1 X212.708 Y167.903 E1.13697
G1 X212.325 Y168.171 E.01769
G1 X191.21 Y147.056 E1.13083
G1 X190.942 Y147.439 E.01769
G1 X211.943 Y168.439 E1.12469
G1 X211.56 Y168.707 E.01769
G1 X190.675 Y147.822 E1.11854
G2 X190.433 Y148.23 I1.038 J.89 E.01808
M73 P45 R7
G1 X211.151 Y168.949 E1.10962
G1 X210.708 Y169.156 E.01854
G1 X190.226 Y148.674 E1.09694
G1 X190.019 Y149.118 E.01854
G1 X210.264 Y169.363 E1.08425
G1 X209.82 Y169.57 E.01854
G1 X189.812 Y149.561 E1.07157
G1 X189.605 Y150.005 E.01854
G1 X209.377 Y169.777 E1.05889
G1 X208.933 Y169.984 E.01854
G1 X189.398 Y150.449 E1.04621
G1 X189.26 Y150.962 E.02011
G1 X208.42 Y170.121 E1.0261
G1 X207.907 Y170.259 E.02012
G1 X189.123 Y151.475 E1.00598
G1 X188.986 Y151.988 E.02012
G1 X207.394 Y170.396 E.98587
G1 X206.881 Y170.534 E.02012
G1 X188.848 Y152.501 E.96575
G1 X188.711 Y153.014 E.02012
G1 X206.367 Y170.671 E.94563
G1 X205.769 Y170.724 E.02273
G1 X188.658 Y153.612 E.91642
G1 X188.606 Y154.211 E.02274
G1 X205.171 Y170.776 E.88718
G1 X204.573 Y170.828 E.02274
G1 X188.553 Y154.809 E.85795
G1 X188.501 Y155.407 E.02274
G1 X203.975 Y170.881 E.82871
G3 X203.311 Y170.867 I-.294 J-1.89 E.02528
G1 X188.514 Y156.071 E.79242
G1 X188.577 Y156.784 E.0271
G1 X202.598 Y170.805 E.7509
M73 P46 R7
G1 X201.885 Y170.742 E.0271
G1 X188.639 Y157.497 E.70937
G1 X188.702 Y158.21 E.0271
G1 X201.172 Y170.68 E.66785
G1 X201.073 Y170.671 E.00375
G1 X200.307 Y170.466 E.03003
G1 X188.915 Y159.074 E.6101
G1 X189.154 Y159.963 E.03484
G1 X199.418 Y170.228 E.54975
G1 X198.53 Y169.99 E.03484
G1 X189.392 Y160.852 E.4894
G1 X189.952 Y162.062 E.05051
G1 X197.319 Y169.43 E.39457
G1 X196.1 Y168.862 E.05094
G1 X190.52 Y163.282 E.29884
G1 X192.039 Y165.451 E.10028
G1 X194.768 Y168.18 E.14619
; WIPE_START
G1 X194.061 Y167.473 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z0.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 2/82
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S198.9
M106 P2 S191
; open powerlost recovery
M1003 S1
; OBJECT_ID: 202
M204 S10000
G1 X219.589 Y155.662 F60000
G1 Z.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F18000
M204 S8000
G1 X219.348 Y158.418 E.0927
G1 X218.632 Y161.09 E.0927
G1 X217.463 Y163.597 E.0927
G1 X215.876 Y165.863 E.0927
G1 X213.92 Y167.819 E.0927
G1 X211.654 Y169.405 E.09269
G1 X209.147 Y170.574 E.0927
G1 X206.475 Y171.29 E.0927
G1 X203.72 Y171.531 E.0927
G1 X200.964 Y171.29 E.0927
G1 X198.292 Y170.574 E.0927
G1 X195.785 Y169.405 E.0927
G1 X193.519 Y167.819 E.0927
G1 X191.563 Y165.863 E.0927
G1 X189.976 Y163.597 E.09269
G1 X188.807 Y161.09 E.0927
G1 X188.091 Y158.418 E.0927
G1 X187.85 Y155.662 E.0927
G1 X188.091 Y152.906 E.0927
G1 X188.807 Y150.234 E.0927
G1 X189.976 Y147.727 E.0927
G1 X191.563 Y145.461 E.0927
G1 X193.519 Y143.505 E.0927
G1 X195.785 Y141.919 E.0927
G1 X198.292 Y140.75 E.0927
G1 X200.964 Y140.034 E.0927
G1 X203.72 Y139.793 E.0927
G1 X203.963 Y139.814 E.00817
G1 X206.475 Y140.034 E.08452
G1 X209.147 Y140.75 E.0927
G1 X211.654 Y141.919 E.0927
G1 X213.92 Y143.505 E.0927
G1 X215.876 Y145.461 E.0927
G1 X217.463 Y147.727 E.09269
G1 X218.632 Y150.234 E.0927
G1 X219.348 Y152.906 E.0927
G1 X219.584 Y155.602 E.09069
M204 S10000
G1 X219.983 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X219.735 Y158.486 E.088
G1 X219.002 Y161.224 E.08799
G1 X217.804 Y163.793 E.08799
G1 X216.178 Y166.116 E.088
G1 X214.173 Y168.12 E.08799
G1 X211.851 Y169.746 E.08799
G1 X209.282 Y170.944 E.088
G1 X206.544 Y171.678 E.08799
G1 X203.72 Y171.925 E.088
G1 X200.896 Y171.678 E.088
G1 X198.157 Y170.944 E.08799
G1 X195.588 Y169.746 E.08799
G1 X193.266 Y168.12 E.088
G1 X191.261 Y166.116 E.08799
G1 X189.635 Y163.794 E.08799
G1 X188.437 Y161.224 E.088
G1 X188.365 Y160.956 E.00863
G1 X187.704 Y158.486 E.07936
G1 X187.457 Y155.662 E.088
G1 X187.704 Y152.838 E.08799
G1 X188.437 Y150.1 E.08799
G1 X189.635 Y147.531 E.08799
G1 X191.261 Y145.208 E.088
G1 X193.266 Y143.204 E.08799
G1 X195.588 Y141.578 E.088
G1 X198.157 Y140.38 E.08799
G1 X200.896 Y139.646 E.08799
G1 X203.72 Y139.399 E.088
G1 X203.997 Y139.423 E.00864
G1 X206.544 Y139.646 E.07936
G1 X209.282 Y140.38 E.08799
G1 X211.851 Y141.578 E.08799
G1 X214.173 Y143.204 E.088
G1 X216.178 Y145.208 E.08799
G1 X217.804 Y147.531 E.08799
G1 X219.002 Y150.1 E.088
G1 X219.735 Y152.838 E.08799
G1 X219.977 Y155.602 E.08613
; WIPE_START
M204 S8000
G1 X219.894 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.8 I-1.048 J-.619 P1  F60000
G1 X213.013 Y168.254 Z.8
G1 Z.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42037
G1 F15000
M204 S8000
G1 X215.621 Y165.647 E.11458
G1 X216.868 Y163.866 E.06754
G1 X211.923 Y168.81 E.21725
G1 X211.487 Y169.116 E.01655
G1 X210.732 Y169.468 E.02588
G1 X217.525 Y162.675 E.2985
G1 X217.992 Y161.674 E.03429
G1 X209.732 Y169.934 E.36294
G1 X209.033 Y170.26 E.02397
G1 X208.813 Y170.319 E.00706
G1 X218.376 Y160.756 E.42022
G1 X218.572 Y160.027 E.02346
G1 X208.084 Y170.514 E.46084
G1 X207.355 Y170.71 E.02346
G1 X218.767 Y159.297 E.50147
G1 X218.963 Y158.568 E.02346
G1 X206.626 Y170.905 E.5421
G1 X206.417 Y170.961 E.00671
G1 X206 Y170.997 E.01303
G1 X219.055 Y157.942 E.57367
G1 X219.106 Y157.357 E.01825
G1 X205.415 Y171.049 E.60163
G1 X204.83 Y171.1 E.01825
G1 X219.157 Y156.772 E.62958
G1 X219.208 Y156.187 E.01825
G1 X204.245 Y171.151 E.65754
G1 X203.669 Y171.192 E.01792
G1 X219.25 Y155.612 E.68464
G1 X219.207 Y155.121 E.01531
G1 X203.178 Y171.15 E.70432
G1 X202.688 Y171.107 E.01531
G1 X219.164 Y154.63 E.724
G1 X219.121 Y154.139 E.01531
G1 X202.197 Y171.064 E.74368
G1 X201.706 Y171.021 E.01531
G1 X219.078 Y153.648 E.76337
G1 X219.035 Y153.157 E.01531
G1 X201.215 Y170.978 E.78305
G3 X200.767 Y170.892 I.018 J-1.314 E.01426
G1 X218.95 Y152.709 E.799
G1 X218.837 Y152.288 E.01354
G1 X200.346 Y170.78 E.81255
G1 X199.925 Y170.667 E.01354
M73 P47 R7
G1 X218.724 Y151.867 E.82609
G1 X218.612 Y151.446 E.01354
G1 X199.504 Y170.554 E.83963
G1 X199.083 Y170.441 E.01354
G1 X218.499 Y151.025 E.85317
G1 X218.386 Y150.604 E.01354
G1 X198.662 Y170.328 E.86672
G3 X198.263 Y170.193 I.184 J-1.198 E.01314
G1 X218.251 Y150.206 E.87829
G1 X218.081 Y149.841 E.01248
G1 X197.899 Y170.023 E.88682
G1 X197.535 Y169.854 E.01248
G1 X217.911 Y149.477 E.89536
G1 X217.741 Y149.113 E.01248
G1 X197.171 Y169.684 E.9039
G1 X196.807 Y169.514 E.01248
G1 X217.572 Y148.749 E.91244
G1 X217.402 Y148.385 E.01248
G1 X196.443 Y169.344 E.92097
G1 X196.079 Y169.175 E.01248
G1 X217.232 Y148.021 E.92951
G2 X217.03 Y147.69 I-1.041 J.408 E.01213
G1 X195.747 Y168.972 E.93518
G1 X195.433 Y168.752 E.01191
G1 X216.81 Y147.376 E.93931
G1 X216.59 Y147.062 E.01191
G1 X195.119 Y168.533 E.94345
G1 X194.805 Y168.313 E.01191
G1 X216.37 Y146.748 E.94759
G1 X216.15 Y146.434 E.01191
G1 X194.492 Y168.093 E.95172
G1 X194.178 Y167.873 E.01191
G1 X215.931 Y146.12 E.95586
G1 X215.711 Y145.806 E.01191
G1 X193.864 Y167.653 E.95999
G3 X193.577 Y167.406 I.558 J-.935 E.01182
G1 X215.463 Y145.52 E.9617
G1 X215.196 Y145.253 E.01173
G1 X193.31 Y167.139 E.9617
G1 X193.044 Y166.872 E.01173
G1 X214.93 Y144.986 E.9617
G1 X214.663 Y144.719 E.01173
G1 X192.777 Y166.605 E.9617
G1 X192.51 Y166.338 E.01173
M73 P47 R6
G1 X214.396 Y144.452 E.9617
G1 X214.129 Y144.185 E.01173
G1 X192.243 Y166.071 E.9617
G1 X191.976 Y165.804 E.01173
G1 X213.862 Y143.918 E.9617
G2 X213.576 Y143.671 I-.845 J.688 E.01182
G1 X191.728 Y165.518 E.95999
G1 X191.509 Y165.204 E.01191
G1 X213.262 Y143.451 E.95586
G1 X212.948 Y143.231 E.01191
G1 X191.289 Y164.89 E.95172
G1 X191.069 Y164.576 E.01191
G1 X212.634 Y143.011 E.94759
G1 X212.32 Y142.792 E.01191
G1 X190.849 Y164.262 E.94345
G1 X190.629 Y163.948 E.01191
G1 X212.006 Y142.572 E.93932
G1 X211.692 Y142.352 E.01191
G1 X190.409 Y163.634 E.93518
G3 X190.207 Y163.303 I.838 J-.74 E.01213
G1 X211.36 Y142.149 E.92951
G1 X210.996 Y141.98 E.01248
G1 X190.037 Y162.939 E.92098
G1 X189.867 Y162.575 E.01248
G1 X210.632 Y141.81 E.91244
G1 X210.268 Y141.64 E.01248
G1 X189.698 Y162.211 E.9039
G1 X189.528 Y161.847 E.01248
G1 X209.904 Y141.47 E.89536
G1 X209.54 Y141.301 E.01248
G1 X189.358 Y161.483 E.88683
G1 X189.188 Y161.119 E.01248
G1 X209.176 Y141.131 E.87829
G2 X208.778 Y140.996 I-.583 J1.063 E.01314
G1 X189.053 Y160.72 E.86672
G1 X188.94 Y160.299 E.01354
G1 X208.357 Y140.883 E.85318
G1 X207.936 Y140.77 E.01354
G1 X188.828 Y159.878 E.83964
G1 X188.715 Y159.457 E.01354
G1 X207.515 Y140.657 E.82609
G1 X207.094 Y140.544 E.01354
G1 X188.602 Y159.036 E.81255
G1 X188.489 Y158.615 E.01354
G1 X206.673 Y140.432 E.79901
G2 X206.224 Y140.346 I-.466 J1.229 E.01426
G1 X188.404 Y158.167 E.78305
G1 X188.361 Y157.676 E.01531
G1 X205.733 Y140.303 E.76337
G1 X205.243 Y140.26 E.01531
G1 X188.318 Y157.185 E.74369
G1 X188.275 Y156.694 E.01531
G1 X204.752 Y140.217 E.72401
G1 X204.261 Y140.175 E.01531
G1 X188.232 Y156.203 E.70433
G1 X188.189 Y155.713 E.01531
M73 P48 R6
G1 X203.77 Y140.132 E.68465
G1 X203.195 Y140.173 E.01792
G1 X188.231 Y155.137 E.65754
G1 X188.282 Y154.552 E.01825
G1 X202.61 Y140.224 E.62959
G1 X202.025 Y140.275 E.01825
G1 X188.333 Y153.967 E.60164
G1 X188.384 Y153.382 E.01825
G1 X201.44 Y140.327 E.57368
G1 X201.022 Y140.363 E.01303
G1 X200.814 Y140.419 E.0067
G1 X188.477 Y152.756 E.54211
G1 X188.672 Y152.027 E.02346
G1 X200.084 Y140.614 E.50148
G1 X199.355 Y140.81 E.02346
G1 X188.867 Y151.298 E.46086
G1 X189.063 Y150.569 E.02346
G1 X198.626 Y141.005 E.42023
G1 X198.406 Y141.064 E.00707
G1 X197.708 Y141.39 E.02396
G1 X189.447 Y149.65 E.36296
G1 X189.914 Y148.65 E.03429
G1 X196.707 Y141.856 E.29852
G1 X195.952 Y142.208 E.02589
G1 X195.516 Y142.514 E.01654
G1 X190.571 Y147.459 E.21729
G1 X191.818 Y145.678 E.06754
G1 X194.427 Y143.07 E.11462
; WIPE_START
G1 X193.719 Y143.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z0.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 3/82
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.571 Y155.662 F60000
G1 Z.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F18000
M204 S8000
G1 X219.331 Y158.415 E.09259
G1 X218.615 Y161.084 E.09259
G1 X217.448 Y163.588 E.0926
G1 X215.863 Y165.851 E.09259
G1 X213.909 Y167.805 E.09259
G1 X211.646 Y169.39 E.09259
G1 X211.245 Y169.577 E.0148
G1 X209.141 Y170.558 E.0778
G1 X206.472 Y171.273 E.09259
G1 X203.72 Y171.514 E.09259
G1 X200.967 Y171.273 E.09259
G1 X198.298 Y170.558 E.09259
G1 X195.794 Y169.39 E.0926
G1 X193.53 Y167.805 E.09259
G1 X191.576 Y165.851 E.09259
G1 X189.991 Y163.588 E.09259
G1 X189.805 Y163.188 E.0148
G1 X188.824 Y161.084 E.0778
G1 X188.109 Y158.415 E.09259
G1 X187.868 Y155.662 E.09259
G1 X188.109 Y152.909 E.09259
G1 X188.824 Y150.24 E.0926
G1 X189.991 Y147.736 E.09259
G1 X191.576 Y145.473 E.0926
G1 X193.53 Y143.519 E.09259
G1 X195.794 Y141.934 E.0926
G1 X198.298 Y140.766 E.0926
G1 X200.967 Y140.051 E.09259
G1 X203.72 Y139.81 E.09259
G1 X204.159 Y139.849 E.0148
G1 X206.472 Y140.051 E.0778
G1 X209.141 Y140.766 E.09259
G1 X211.646 Y141.934 E.0926
G1 X213.909 Y143.519 E.0926
G1 X215.863 Y145.473 E.09259
G1 X217.448 Y147.736 E.09259
G1 X218.615 Y150.24 E.0926
G1 X219.331 Y152.909 E.09259
G1 X219.566 Y155.602 E.09058
; COOLING_NODE: 0
M204 S10000
G1 X219.965 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5512
M204 S5000
G1 X219.718 Y158.483 E.0879
G1 X218.985 Y161.218 E.0879
G1 X217.789 Y163.785 E.0879
G1 X216.164 Y166.104 E.0879
G1 X214.162 Y168.107 E.0879
G1 X211.842 Y169.731 E.0879
G1 X211.411 Y169.932 E.01477
G1 X209.276 Y170.928 E.07313
G1 X206.541 Y171.661 E.0879
G1 X203.72 Y171.908 E.0879
G1 X200.899 Y171.661 E.0879
G1 X198.163 Y170.928 E.0879
G1 X195.597 Y169.731 E.0879
G1 X193.277 Y168.107 E.0879
G1 X191.275 Y166.104 E.0879
G1 X189.651 Y163.785 E.0879
G1 X189.449 Y163.353 E.01477
G1 X188.454 Y161.218 E.07313
G1 X187.721 Y158.483 E.0879
G1 X187.474 Y155.662 E.0879
G1 X187.721 Y152.841 E.0879
G1 X188.454 Y150.106 E.0879
G1 X188.655 Y149.674 E.01477
G1 X189.651 Y147.539 E.07313
G1 X191.275 Y145.22 E.0879
G1 X193.277 Y143.217 E.0879
G1 X195.597 Y141.593 E.0879
G1 X198.163 Y140.396 E.0879
G1 X200.899 Y139.663 E.0879
G1 X203.72 Y139.417 E.0879
G1 X204.194 Y139.458 E.01477
G1 X206.541 Y139.663 E.07313
G1 X209.276 Y140.396 E.0879
G1 X211.842 Y141.593 E.0879
G1 X214.162 Y143.217 E.0879
G1 X216.164 Y145.22 E.0879
G1 X217.789 Y147.539 E.0879
G1 X218.985 Y150.106 E.0879
G1 X219.718 Y152.841 E.0879
G1 X219.96 Y155.602 E.08604
; WIPE_START
G1 F12000
M204 S8000
G1 X219.876 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1 I1.149 J-.402 P1  F60000
G1 X216.305 Y146.39 Z1
G1 Z.6
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42455
G1 F15000
M204 S8000
G1 X213.683 Y143.767 E.1165
G1 X211.883 Y142.507 E.06904
G1 X216.875 Y147.499 E.22179
G1 X217.158 Y147.903 E.01551
G1 X217.524 Y148.687 E.02718
G1 X210.694 Y141.858 E.30342
G1 X209.683 Y141.386 E.03505
G1 X217.995 Y149.699 E.3693
G1 X218.301 Y150.355 E.02274
G1 X218.37 Y150.614 E.00842
G1 X208.768 Y141.011 E.42662
G1 X208.031 Y140.814 E.02398
G1 X218.568 Y151.351 E.46816
G1 X218.766 Y152.088 E.02398
G1 X207.293 Y140.616 E.50969
G1 X206.556 Y140.418 E.02398
G1 X218.963 Y152.825 E.55122
G1 X219.001 Y152.967 E.00462
G1 X219.043 Y153.445 E.01506
G1 X205.937 Y140.339 E.58229
G1 X205.345 Y140.287 E.01865
G1 X219.095 Y154.036 E.61087
G1 X219.146 Y154.628 E.01865
G1 X204.754 Y140.235 E.63944
G1 X204.162 Y140.183 E.01865
G1 X219.198 Y155.219 E.66802
G1 X219.237 Y155.662 E.01396
G1 X219.226 Y155.787 E.00394
G1 X203.595 Y140.156 E.69447
G1 X203.098 Y140.199 E.01565
G1 X219.183 Y156.283 E.71459
G1 X219.139 Y156.779 E.01565
G1 X202.602 Y140.242 E.73471
G1 X202.106 Y140.286 E.01565
G1 X219.096 Y157.276 E.75483
G1 X219.052 Y157.772 E.01565
G1 X201.61 Y140.329 E.77495
G1 X201.113 Y140.373 E.01565
G1 X219.009 Y158.268 E.79507
G1 X219.001 Y158.357 E.00278
G1 X218.907 Y158.707 E.01138
G1 X200.675 Y140.474 E.81003
G1 X200.249 Y140.588 E.01384
G1 X218.793 Y159.132 E.82387
G1 X218.679 Y159.558 E.01384
G1 X199.824 Y140.702 E.83771
G1 X199.398 Y140.816 E.01384
G1 X218.565 Y159.983 E.85156
G1 X218.451 Y160.409 E.01384
G1 X198.972 Y140.93 E.8654
G1 X198.547 Y141.044 E.01384
G1 X218.337 Y160.835 E.87924
G3 X218.184 Y161.221 I-1.172 J-.242 E.01312
G1 X198.161 Y141.198 E.88959
G1 X197.792 Y141.37 E.01276
G1 X218.012 Y161.589 E.89832
G1 X217.84 Y161.957 E.01276
G1 X197.424 Y141.541 E.90704
G1 X197.056 Y141.713 E.01276
G1 X217.669 Y162.325 E.91577
G1 X217.497 Y162.693 E.01276
G1 X196.688 Y141.884 E.9245
G1 X196.32 Y142.056 E.01276
G1 X217.326 Y163.061 E.93323
G1 X217.153 Y163.428 E.01274
G1 X195.953 Y142.229 E.94185
G1 X195.636 Y142.451 E.01217
M73 P49 R6
G1 X216.93 Y163.746 E.94607
G1 X216.708 Y164.063 E.01217
G1 X195.318 Y142.673 E.9503
G1 X195.001 Y142.896 E.01217
G1 X216.486 Y164.381 E.95453
G1 X216.264 Y164.698 E.01217
G1 X194.684 Y143.118 E.95876
G1 X194.366 Y143.34 E.01217
G1 X216.041 Y165.015 E.96299
G1 X215.819 Y165.333 E.01217
G1 X194.049 Y143.563 E.96721
G1 X193.733 Y143.787 E.01216
G1 X215.595 Y165.648 E.97126
G1 X215.325 Y165.918 E.01199
G1 X193.463 Y144.057 E.97126
G1 X193.194 Y144.327 E.01199
G1 X215.055 Y166.188 E.97126
G1 X214.785 Y166.458 E.01199
G1 X192.924 Y144.596 E.97126
G1 X192.654 Y144.866 E.01199
G1 X214.515 Y166.728 E.97126
G1 X214.245 Y166.998 E.01199
G1 X192.384 Y145.136 E.97126
G1 X192.114 Y145.406 E.01199
G1 X213.976 Y167.267 E.97126
G1 X213.706 Y167.537 E.01199
G1 X191.844 Y145.676 E.97126
G1 X191.62 Y145.991 E.01216
G1 X213.39 Y167.762 E.96721
G1 X213.073 Y167.984 E.01217
G1 X191.398 Y146.309 E.96299
G1 X191.175 Y146.626 E.01217
G1 X212.756 Y168.206 E.95876
G1 X212.438 Y168.428 E.01217
G1 X190.953 Y146.944 E.95453
G1 X190.731 Y147.261 E.01217
G1 X212.121 Y168.651 E.9503
G1 X211.803 Y168.873 E.01217
G1 X190.509 Y147.578 E.94607
G1 X190.286 Y147.896 E.01217
G1 X211.486 Y169.095 E.94185
G1 X211.119 Y169.268 E.01274
G1 X190.114 Y148.263 E.93322
G1 X189.942 Y148.631 E.01276
G1 X210.751 Y169.44 E.9245
G1 X210.383 Y169.611 E.01276
G1 X189.77 Y148.999 E.91577
G1 X189.599 Y149.367 E.01276
G1 X210.015 Y169.783 E.90704
G1 X209.647 Y169.955 E.01276
G1 X189.427 Y149.735 E.89831
G1 X189.255 Y150.103 E.01276
G1 X209.279 Y170.126 E.88959
G3 X208.892 Y170.28 I-.628 J-1.018 E.01312
G1 X189.102 Y150.489 E.87924
G1 X188.988 Y150.915 E.01384
G1 X208.467 Y170.394 E.8654
G1 X208.041 Y170.508 E.01384
G1 X188.874 Y151.341 E.85155
G1 X188.76 Y151.766 E.01384
G1 X207.615 Y170.622 E.83771
G1 X207.19 Y170.736 E.01384
G1 X188.646 Y152.192 E.82387
G1 X188.532 Y152.618 E.01384
G1 X206.764 Y170.85 E.81002
G1 X206.414 Y170.944 E.01138
G1 X206.326 Y170.951 E.00279
G1 X188.43 Y153.056 E.79506
G1 X188.387 Y153.552 E.01565
G1 X205.829 Y170.995 E.77494
G1 X205.333 Y171.038 E.01565
G1 X188.343 Y154.048 E.75482
G1 X188.3 Y154.545 E.01565
G1 X204.837 Y171.082 E.7347
G1 X204.341 Y171.125 E.01565
G1 X188.257 Y155.041 E.71458
G1 X188.213 Y155.537 E.01565
G1 X203.844 Y171.169 E.69446
G1 X203.72 Y171.179 E.00393
G1 X203.277 Y171.141 E.01396
G1 X188.241 Y156.105 E.66801
G1 X188.293 Y156.696 E.01865
G1 X202.685 Y171.089 E.63944
G1 X202.094 Y171.037 E.01865
G1 X188.344 Y157.288 E.61086
G1 X188.396 Y157.879 E.01865
G1 X201.502 Y170.985 E.58228
G1 X201.025 Y170.944 E.01506
G1 X200.883 Y170.906 E.00462
G1 X188.476 Y158.499 E.55121
G1 X188.674 Y159.236 E.02398
G1 X200.146 Y170.708 E.50968
G1 X199.408 Y170.51 E.02398
G1 X188.871 Y159.973 E.46815
G1 X189.069 Y160.71 E.02398
G1 X198.671 Y170.313 E.42662
G1 X198.412 Y170.244 E.00841
G1 X197.756 Y169.938 E.02275
G1 X189.444 Y161.626 E.36928
G1 X189.916 Y162.637 E.03505
G1 X196.745 Y169.466 E.30341
G1 X195.961 Y169.1 E.02717
G1 X195.556 Y168.817 E.01552
G1 X190.565 Y163.825 E.22177
G1 X191.825 Y165.626 E.06904
G1 X194.447 Y168.247 E.11648
; WIPE_START
G1 X193.74 Y167.54 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z1 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 4/82
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S201.45
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.554 Y155.662 F60000
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5275
M204 S8000
G1 X219.313 Y158.412 E.09249
G1 X218.599 Y161.078 E.09249
G1 X217.433 Y163.579 E.0925
G1 X215.849 Y165.84 E.09249
G1 X213.898 Y167.792 E.09249
G1 X211.637 Y169.375 E.09249
G1 X209.135 Y170.542 E.09249
G1 X206.469 Y171.256 E.09249
G1 X203.72 Y171.496 E.09249
M73 P50 R6
G1 X200.97 Y171.256 E.09249
G1 X198.304 Y170.542 E.09249
G1 X195.802 Y169.375 E.0925
G1 X193.541 Y167.792 E.09249
G1 X191.59 Y165.84 E.09249
G1 X190.007 Y163.579 E.09249
G1 X188.84 Y161.078 E.09249
G1 X188.126 Y158.412 E.09249
G1 X187.885 Y155.662 E.09249
G1 X188.126 Y152.912 E.09249
G1 X188.84 Y150.246 E.09249
G1 X190.007 Y147.745 E.09249
G1 X191.59 Y145.484 E.09249
G1 X193.541 Y143.532 E.09249
G1 X195.802 Y141.949 E.09249
G1 X198.304 Y140.783 E.09249
G1 X200.97 Y140.068 E.09249
G1 X203.72 Y139.828 E.09249
G1 X204.356 Y139.883 E.02142
G1 X206.469 Y140.068 E.07107
G1 X209.135 Y140.783 E.09249
G1 X211.637 Y141.949 E.0925
G1 X213.898 Y143.532 E.09249
G1 X215.849 Y145.484 E.09249
G1 X217.433 Y147.745 E.09249
G1 X218.599 Y150.246 E.09249
G1 X219.313 Y152.912 E.09249
G1 X219.549 Y155.602 E.09048
; COOLING_NODE: 0
M204 S10000
G1 X219.948 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5275
M204 S5000
G1 X219.701 Y158.48 E.08781
G1 X218.969 Y161.212 E.0878
G1 X217.773 Y163.776 E.08781
G1 X216.151 Y166.093 E.0878
G1 X214.151 Y168.093 E.08781
G1 X211.834 Y169.716 E.08781
G1 X209.27 Y170.911 E.08781
G1 X206.538 Y171.643 E.0878
G1 X203.72 Y171.89 E.08781
G1 X200.902 Y171.643 E.08781
G1 X198.169 Y170.911 E.0878
G1 X195.606 Y169.716 E.08781
G1 X193.288 Y168.093 E.0878
G1 X191.288 Y166.093 E.08781
G1 X189.666 Y163.776 E.08781
G1 X188.47 Y161.212 E.08781
G1 X187.738 Y158.48 E.0878
G1 X187.492 Y155.662 E.08781
G1 X187.738 Y152.844 E.08781
G1 X188.47 Y150.112 E.08781
G1 X188.755 Y149.501 E.02091
G1 X189.666 Y147.548 E.06689
G1 X191.288 Y145.231 E.08781
G1 X193.288 Y143.231 E.08781
G1 X195.606 Y141.608 E.08781
G1 X198.169 Y140.413 E.08781
G1 X200.902 Y139.681 E.0878
G1 X203.72 Y139.434 E.08781
G1 X204.391 Y139.493 E.02091
G1 X206.538 Y139.681 E.0669
G1 X209.27 Y140.413 E.0878
G1 X211.834 Y141.608 E.08781
G1 X214.151 Y143.231 E.0878
G1 X216.151 Y145.231 E.08781
G1 X217.773 Y147.548 E.08781
G1 X218.969 Y150.112 E.08781
G1 X219.701 Y152.844 E.0878
G1 X219.942 Y155.602 E.08594
; WIPE_START
G1 F12000
M204 S8000
G1 X219.859 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.2 I1.182 J-.291 P1  F60000
G1 X218.943 Y152.876 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5275
M204 S8000
G1 X219.102 Y154.495 E.05452
G2 X217.395 Y156.13 I135.282 J143.036 E.07921
G2 X216.621 Y158.47 I2.433 J2.102 E.08475
G2 X217.959 Y161.627 I4.925 J-.225 E.11735
G1 X217.13 Y163.404 E.06572
G1 X215.582 Y165.615 E.09045
G1 X213.673 Y167.524 E.09045
G1 X213.277 Y167.801 E.01621
G2 X211.402 Y164.086 I-5.379 J.383 E.14319
G3 X209.566 Y162.214 I5.379 J-7.11 E.08817
G3 X209.267 Y159.406 I3.481 J-1.791 E.09681
G3 X211.012 Y156.598 I5.784 J1.649 E.11223
G2 X212.848 Y154.726 I-5.38 J-7.111 E.08817
G2 X213.147 Y151.918 I-3.481 J-1.791 E.09681
G2 X211.402 Y149.11 I-5.785 J1.65 E.11223
G3 X209.566 Y147.239 I5.379 J-7.11 E.08817
G3 X209.267 Y144.431 I3.481 J-1.791 E.09681
G3 X210.742 Y141.916 I5.445 J1.504 E.09881
G1 X209.016 Y141.111 E.06383
G1 X206.409 Y140.413 E.09045
G1 X204.326 Y140.23 E.07005
G2 X203.408 Y140.204 I-.532 J2.589 E.03092
G2 X201.714 Y142.559 I2.423 J3.531 E.09917
G2 X203.525 Y147.239 I5.201 J.677 E.17533
G3 X205.36 Y149.11 I-5.38 J7.111 E.08817
G3 X205.66 Y151.918 I-3.481 J1.791 E.09681
G3 X203.914 Y154.726 I-5.785 J-1.65 E.11223
G2 X202.079 Y156.598 I5.379 J7.111 E.08817
G2 X201.779 Y159.406 I3.481 J1.791 E.09681
G2 X203.525 Y162.214 I5.785 J-1.65 E.11223
G3 X205.36 Y164.086 I-5.38 J7.111 E.08817
G3 X205.66 Y166.893 I-3.481 J1.791 E.09681
G3 X203.914 Y169.701 I-5.785 J-1.65 E.11223
G2 X202.484 Y171.039 I8.377 J10.395 E.06569
G1 X201.031 Y170.912 E.04888
G1 X198.424 Y170.213 E.09045
G1 X197.734 Y169.892 E.02549
G2 X198.172 Y166.893 I-3.211 J-2 E.10447
G2 X196.427 Y164.086 I-5.784 J1.649 E.11224
G3 X194.591 Y162.214 I5.38 J-7.111 E.08817
G3 X194.292 Y159.406 I3.481 J-1.791 E.09681
G3 X196.037 Y156.598 I5.784 J1.649 E.11223
G2 X197.873 Y154.726 I-5.38 J-7.111 E.08817
G2 X198.172 Y151.918 I-3.481 J-1.791 E.09681
G2 X196.427 Y149.11 I-5.784 J1.649 E.11223
G3 X194.591 Y147.239 I5.379 J-7.111 E.08817
G3 X194.292 Y144.431 I3.481 J-1.791 E.09681
G3 X194.91 Y142.999 I3.707 J.752 E.05265
G1 X195.977 Y142.252 E.04364
G1 X196.273 Y142.114 E.01093
M204 S10000
G1 X189.308 Y150.068 F60000
G1 F5275
M204 S8000
G1 X189.996 Y148.592 E.05457
G3 X190.614 Y149.578 I-3.225 J2.709 E.03914
G3 X189.803 Y153.79 I-4.674 J1.284 E.14889
G3 X188.264 Y155.332 I-8.874 J-7.321 E.0731
G1 X188.235 Y155.662 E.01111
G1 X188.348 Y156.954 E.04345
; WIPE_START
G1 F18423.913
G1 X188.261 Y155.958 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z1.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 5/82
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.536 Y155.662 F60000
G1 Z1
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5301
M204 S8000
G1 X219.296 Y158.409 E.09239
G1 X218.583 Y161.072 E.09239
G1 X217.417 Y163.57 E.09239
G1 X215.836 Y165.829 E.09239
G1 X213.886 Y167.778 E.09239
G1 X211.628 Y169.36 E.09239
G1 X210.869 Y169.714 E.02805
G1 X209.129 Y170.525 E.06434
G1 X206.466 Y171.239 E.09239
G1 X203.72 Y171.479 E.09239
G1 X200.973 Y171.239 E.09239
G1 X198.31 Y170.525 E.09239
G1 X195.811 Y169.36 E.09239
G1 X193.553 Y167.778 E.09239
G1 X191.603 Y165.829 E.09239
G1 X190.022 Y163.57 E.09239
G1 X189.668 Y162.812 E.02805
G1 X188.857 Y161.072 E.06434
G1 X188.143 Y158.409 E.09239
G1 X187.903 Y155.662 E.09239
G1 X188.143 Y152.915 E.09239
G1 X188.36 Y152.107 E.02805
G1 X188.857 Y150.252 E.06434
G1 X190.022 Y147.754 E.09239
G1 X191.603 Y145.495 E.09239
G1 X193.553 Y143.546 E.09239
G1 X195.811 Y141.964 E.09239
G1 X198.31 Y140.799 E.09239
G1 X200.973 Y140.085 E.09239
G1 X203.72 Y139.845 E.09239
G1 X204.553 Y139.918 E.02805
G1 X206.466 Y140.085 E.06434
G1 X209.129 Y140.799 E.09239
G1 X211.628 Y141.964 E.09239
G1 X213.886 Y143.546 E.09239
G1 X215.836 Y145.495 E.09239
G1 X217.417 Y147.754 E.09239
G1 X218.583 Y150.252 E.09239
G1 X219.296 Y152.915 E.09239
G1 X219.531 Y155.602 E.09038
; COOLING_NODE: 0
M204 S10000
G1 X219.93 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5301
M204 S5000
G1 X219.684 Y158.477 E.08771
G1 X218.952 Y161.206 E.08771
G1 X217.758 Y163.767 E.08771
G1 X216.137 Y166.082 E.08771
G1 X214.139 Y168.08 E.08771
G1 X211.825 Y169.701 E.08771
G1 X211.035 Y170.069 E.02705
G1 X209.264 Y170.895 E.06066
G1 X206.534 Y171.626 E.08771
G1 X203.72 Y171.873 E.08771
G1 X200.905 Y171.626 E.08771
G1 X198.175 Y170.895 E.08771
G1 X195.614 Y169.701 E.08771
G1 X193.3 Y168.08 E.08771
G1 X191.302 Y166.082 E.08771
G1 X189.681 Y163.767 E.08771
G1 X189.313 Y162.978 E.02705
G1 X188.487 Y161.206 E.06066
G1 X187.755 Y158.477 E.08771
G1 X187.509 Y155.662 E.08771
G1 X187.755 Y152.847 E.08771
G1 X187.981 Y152.005 E.02705
G1 X188.487 Y150.118 E.06066
G1 X189.681 Y147.557 E.08771
G1 X191.302 Y145.242 E.08771
G1 X193.3 Y143.244 E.08771
G1 X195.614 Y141.623 E.08771
G1 X198.175 Y140.429 E.08771
G1 X200.905 Y139.698 E.08771
G1 X203.72 Y139.452 E.08771
G1 X204.588 Y139.528 E.02705
G1 X206.534 Y139.698 E.06066
G1 X209.264 Y140.429 E.08771
G1 X211.825 Y141.623 E.08771
G1 X214.139 Y143.244 E.08771
G1 X216.137 Y145.242 E.08771
G1 X217.758 Y147.557 E.08771
G1 X218.952 Y150.118 E.08771
G1 X219.684 Y152.847 E.08771
G1 X219.925 Y155.602 E.08585
; WIPE_START
G1 F12000
M204 S8000
G1 X219.841 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.4 I1.182 J-.292 P1  F60000
G1 X218.893 Y152.755 Z1.4
G1 Z1
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5301
M204 S8000
G1 X219.074 Y154.37 E.05446
G3 X217.593 Y155.662 I-8.847 J-8.646 E.06593
G2 X216.624 Y157.066 I2.279 J2.609 E.05776
G2 X217.725 Y161.278 I4.972 J.95 E.1508
G1 X217.984 Y161.532 E.01215
G1 X217.115 Y163.396 E.06892
G1 X215.568 Y165.604 E.09035
G1 X213.662 Y167.511 E.09034
G1 X213.358 Y167.724 E.01244
G2 X212.177 Y165.022 I-5.727 J.894 E.09992
G2 X210.105 Y163.15 I-12.777 J12.058 E.09366
G3 X209.136 Y161.746 I2.279 J-2.61 E.05776
G3 X210.238 Y157.534 I4.972 J-.95 E.1508
G3 X212.309 Y155.662 I12.778 J12.059 E.09366
G2 X213.278 Y154.258 I-2.279 J-2.609 E.05776
G2 X212.177 Y150.046 I-4.972 J-.95 E.1508
G2 X210.105 Y148.174 I-12.779 J12.06 E.09366
G3 X209.136 Y146.771 I2.279 J-2.609 E.05776
G3 X210.83 Y141.977 I4.894 J-.967 E.17878
G1 X209.01 Y141.128 E.06732
G1 X206.405 Y140.43 E.09034
G1 X204.523 Y140.265 E.06332
G2 X203.146 Y140.245 I-.746 J3.896 E.0464
G2 X201.649 Y142.091 I2.588 J3.629 E.08062
G2 X202.75 Y146.303 I4.972 J.95 E.1508
G2 X204.822 Y148.174 I12.78 J-12.06 E.09366
G3 X205.791 Y149.578 I-2.279 J2.609 E.05776
G3 X204.689 Y153.79 I-4.972 J.95 E.1508
G3 X202.618 Y155.662 I-12.778 J-12.059 E.09366
G2 X201.649 Y157.066 I2.279 J2.609 E.05776
G2 X202.75 Y161.278 I4.972 J.95 E.1508
G2 X204.822 Y163.15 I12.779 J-12.059 E.09366
M73 P51 R6
G3 X205.791 Y164.554 I-2.279 J2.609 E.05776
G3 X204.689 Y168.765 I-4.972 J.95 E.1508
G3 X202.264 Y171.002 I-132.008 J-140.682 E.11055
G1 X201.034 Y170.894 E.04139
G1 X198.43 Y170.197 E.09034
G1 X197.928 Y169.963 E.01853
G2 X198.303 Y169.233 I-1.588 J-1.277 E.02767
G2 X197.202 Y165.022 I-4.972 J-.95 E.1508
G2 X195.13 Y163.15 I-12.778 J12.058 E.09366
G3 X194.161 Y161.746 I2.279 J-2.61 E.05776
G3 X195.262 Y157.534 I4.972 J-.95 E.1508
G3 X197.334 Y155.662 I12.779 J12.06 E.09366
G2 X198.303 Y154.258 I-2.279 J-2.609 E.05776
G2 X197.202 Y150.046 I-4.972 J-.95 E.1508
G2 X195.13 Y148.174 I-12.78 J12.06 E.09366
G3 X194.161 Y146.771 I2.279 J-2.609 E.05776
G3 X194.989 Y142.965 I4.796 J-.949 E.13424
G3 X196.359 Y142.093 I3.157 J3.448 E.05469
M204 S10000
G1 X189.404 Y149.903 F60000
G1 F5301
M204 S8000
G1 X190.092 Y148.428 E.05457
G3 X190.815 Y149.578 I-2.242 J2.213 E.04591
G3 X190.343 Y152.854 I-4.757 J.986 E.11317
G3 X188.3 Y155.111 I-7.511 J-4.745 E.10252
G2 X188.346 Y156.734 I4.622 J.682 E.05466
; WIPE_START
G1 F18423.913
G1 X188.259 Y155.737 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z1.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 6/82
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.519 Y155.662 F60000
G1 Z1.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5483
M204 S8000
G1 X219.279 Y158.406 E.09229
G1 X218.566 Y161.066 E.09229
G1 X218.129 Y162.004 E.03468
G1 X217.402 Y163.562 E.05761
G1 X215.823 Y165.818 E.09229
G1 X213.875 Y167.765 E.09229
G1 X211.619 Y169.345 E.09229
G1 X209.123 Y170.509 E.09229
G1 X206.463 Y171.221 E.09229
G1 X203.72 Y171.461 E.09229
G1 X200.976 Y171.221 E.09229
G1 X198.316 Y170.509 E.09229
G1 X195.82 Y169.345 E.09229
G1 X193.564 Y167.765 E.09229
G1 X191.617 Y165.818 E.09229
G1 X190.037 Y163.562 E.09229
G1 X189.6 Y162.624 E.03467
G1 X188.873 Y161.066 E.05761
G1 X188.16 Y158.406 E.09229
G1 X187.92 Y155.662 E.09229
G1 X188.16 Y152.919 E.09229
G1 X188.873 Y150.258 E.09229
G1 X189.31 Y149.321 E.03468
G1 X190.037 Y147.762 E.05761
G1 X191.617 Y145.506 E.09229
G1 X193.564 Y143.559 E.09229
G1 X195.82 Y141.979 E.09229
G1 X198.316 Y140.815 E.09229
G1 X200.976 Y140.103 E.09229
G1 X203.72 Y139.863 E.09229
G1 X204.75 Y139.953 E.03467
G1 X206.463 Y140.103 E.05761
G1 X209.123 Y140.815 E.09229
G1 X211.619 Y141.979 E.09229
G1 X213.875 Y143.559 E.09229
G1 X215.823 Y145.506 E.09229
G1 X217.402 Y147.762 E.09229
G1 X218.566 Y150.258 E.09229
G1 X219.279 Y152.919 E.09229
G1 X219.514 Y155.602 E.09028
; COOLING_NODE: 0
M204 S10000
G1 X219.912 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5372
M204 S5000
G1 X219.913 Y155.662 E.00001
G1 X219.667 Y158.474 E.08762
G1 X218.936 Y161.2 E.08762
G1 X218.484 Y162.169 E.03318
G1 X217.743 Y163.759 E.05443
G1 X216.124 Y166.071 E.08762
G1 X214.128 Y168.067 E.08762
G1 X211.816 Y169.686 E.08762
G1 X209.258 Y170.878 E.08762
G1 X206.531 Y171.609 E.08762
G1 X203.72 Y171.855 E.08762
G1 X200.908 Y171.609 E.08762
G1 X198.181 Y170.878 E.08762
G1 X195.623 Y169.686 E.08762
G1 X193.311 Y168.067 E.08762
G1 X191.315 Y166.071 E.08762
G1 X189.696 Y163.758 E.08762
G1 X189.244 Y162.79 E.03318
G1 X188.503 Y161.2 E.05443
G1 X187.773 Y158.474 E.08762
G1 X187.527 Y155.662 E.08762
G1 X187.773 Y152.85 E.08762
G1 X188.503 Y150.124 E.08762
G1 X188.955 Y149.155 E.03319
G1 X189.696 Y147.566 E.05443
G1 X191.315 Y145.253 E.08762
G1 X193.311 Y143.258 E.08762
G1 X195.623 Y141.639 E.08762
G1 X198.181 Y140.446 E.08762
G1 X200.908 Y139.715 E.08762
G1 X203.72 Y139.469 E.08762
G1 X204.785 Y139.562 E.03318
G1 X206.531 Y139.715 E.05443
G1 X209.258 Y140.446 E.08762
G1 X211.816 Y141.639 E.08762
G1 X214.128 Y143.258 E.08762
G1 X216.124 Y145.253 E.08761
G1 X217.743 Y147.566 E.08762
G1 X218.936 Y150.124 E.08762
G1 X219.667 Y152.85 E.08762
G1 X219.907 Y155.602 E.08574
; WIPE_START
G1 F12000
M204 S8000
G1 X219.913 Y155.662 E-.02294
G1 X219.831 Y156.598 E-.35706
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.6 I1.181 J-.294 P1  F60000
G1 X218.855 Y152.682 Z1.6
G1 Z1.2
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5483
M204 S8000
G1 X218.935 Y152.979 E.01029
G1 X219.05 Y154.295 E.04427
G3 X217.304 Y155.662 I-26.323 J-31.818 E.0743
G2 X216.401 Y157.066 I1.795 J2.147 E.05681
G2 X217.998 Y161.46 I5.217 J.591 E.16236
G1 X217.099 Y163.387 E.07126
G1 X215.555 Y165.593 E.09024
G1 X213.651 Y167.497 E.09024
G1 X213.44 Y167.645 E.00863
G2 X212.092 Y165.022 I-5.857 J1.351 E.09985
G2 X209.817 Y163.15 I-13.306 J13.855 E.09883
G3 X208.913 Y161.746 I1.795 J-2.147 E.05681
G3 X210.322 Y157.534 I5.369 J-.546 E.15338
G3 X212.598 Y155.662 I13.303 J13.851 E.09883
G2 X213.501 Y154.258 I-1.795 J-2.147 E.05681
G2 X212.092 Y150.046 I-5.369 J-.546 E.15338
G2 X209.817 Y148.174 I-13.308 J13.857 E.09883
G3 X208.913 Y146.771 I1.795 J-2.147 E.05681
G3 X210.889 Y142.023 I5.329 J-.567 E.17972
G1 X209.004 Y141.144 E.06972
G1 X206.402 Y140.447 E.09024
G1 X204.72 Y140.3 E.05659
G2 X202.846 Y140.289 I-.968 J5.307 E.0631
G2 X201.426 Y142.091 I1.813 J2.89 E.07843
G2 X202.835 Y146.303 I5.369 J.546 E.15338
G2 X205.11 Y148.174 I13.305 J-13.853 E.09883
G3 X206.013 Y149.578 I-1.795 J2.147 E.05681
G3 X204.604 Y153.79 I-5.369 J.546 E.15338
G3 X202.329 Y155.662 I-13.303 J-13.851 E.09883
G2 X201.426 Y157.066 I1.795 J2.147 E.05681
G2 X202.835 Y161.278 I5.369 J.546 E.15338
G2 X205.11 Y163.15 I13.305 J-13.853 E.09883
G3 X206.013 Y164.554 I-1.794 J2.147 E.05681
G3 X204.604 Y168.765 I-5.369 J.546 E.15338
G3 X202.329 Y170.637 I-13.305 J-13.853 E.09883
G1 X202.012 Y170.962 E.01522
G1 X201.037 Y170.877 E.03282
G1 X198.435 Y170.18 E.09024
G1 X198.153 Y170.049 E.01043
G2 X198.526 Y169.233 I-1.505 J-1.18 E.03032
G2 X197.117 Y165.022 I-5.369 J-.546 E.15338
G2 X194.842 Y163.15 I-13.303 J13.851 E.09883
G3 X193.938 Y161.746 I1.795 J-2.147 E.05681
G3 X195.347 Y157.534 I5.369 J-.546 E.15338
G3 X197.622 Y155.662 I13.305 J13.853 E.09883
G2 X198.526 Y154.258 I-1.795 J-2.147 E.05681
G2 X197.117 Y150.046 I-5.369 J-.546 E.15338
G2 X194.842 Y148.174 I-13.305 J13.853 E.09883
G3 X194.094 Y147.239 I1.773 J-2.183 E.04045
G3 X194.203 Y144.431 I4.012 J-1.251 E.09601
G3 X196.444 Y142.073 I3.488 J1.071 E.11298
M204 S10000
G1 X189.51 Y149.716 F60000
G1 F5483
M204 S8000
G1 X190.198 Y148.24 E.05457
G3 X190.882 Y149.11 I-1.655 J2.004 E.03738
G3 X190.774 Y151.918 I-4.012 J1.251 E.09601
G3 X188.336 Y154.906 I-6.217 J-2.584 E.13106
G1 X188.27 Y155.662 E.02543
G1 X188.505 Y158.345 E.09025
G1 X189.202 Y160.946 E.09024
G1 X190.315 Y163.335 E.08833
G3 X190.931 Y164.231 I-1.786 J1.886 E.0367
G1 X191.865 Y165.565 E.05457
; WIPE_START
G1 F18423.913
G1 X191.291 Y164.746 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z1.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 7/82
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.501 Y155.662 F60000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5535
M204 S8000
G1 X219.262 Y158.403 E.09219
G1 X218.55 Y161.06 E.09218
G1 X217.387 Y163.553 E.09219
G1 X215.809 Y165.806 E.09219
G1 X213.864 Y167.752 E.09218
G1 X211.611 Y169.33 E.09219
G1 X209.117 Y170.492 E.09219
G1 X207.927 Y170.811 E.0413
G1 X206.46 Y171.204 E.05089
G1 X203.72 Y171.444 E.09219
G1 X200.979 Y171.204 E.09219
G1 X198.322 Y170.492 E.09218
G1 X195.829 Y169.33 E.09219
G1 X193.575 Y167.752 E.09219
G1 X191.63 Y165.806 E.09218
G1 X190.052 Y163.553 E.09219
G1 X188.889 Y161.06 E.09219
G1 X188.57 Y159.869 E.0413
G1 X188.177 Y158.403 E.05089
G1 X187.938 Y155.662 E.09219
G1 X188.177 Y152.922 E.09219
G1 X188.889 Y150.264 E.09218
G1 X189.41 Y149.147 E.0413
G1 X190.052 Y147.771 E.05089
G1 X191.63 Y145.518 E.09218
G1 X193.575 Y143.572 E.09219
G1 X195.829 Y141.995 E.09219
G1 X198.322 Y140.832 E.09219
G1 X200.979 Y140.12 E.09218
G1 X203.72 Y139.88 E.09219
G1 X204.947 Y139.988 E.0413
G1 X206.46 Y140.12 E.05089
G1 X209.117 Y140.832 E.09218
G1 X211.611 Y141.995 E.09219
G1 X213.864 Y143.572 E.09218
G1 X215.809 Y145.518 E.09219
G1 X217.387 Y147.771 E.09219
G1 X218.55 Y150.264 E.09219
G1 X219.262 Y152.922 E.09218
G1 X219.496 Y155.602 E.09018
; COOLING_NODE: 0
M204 S10000
G1 X219.895 Y155.661 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5365
M204 S5000
G1 X219.895 Y155.662 E.00003
G1 X219.649 Y158.471 E.08752
G1 X218.92 Y161.194 E.08752
G1 X217.728 Y163.75 E.08752
G1 X216.111 Y166.059 E.08752
G1 X214.117 Y168.053 E.08752
G1 X211.807 Y169.67 E.08752
G1 X209.252 Y170.862 E.08752
G1 X208.028 Y171.19 E.03932
G1 X206.528 Y171.592 E.0482
G1 X203.72 Y171.838 E.08752
G1 X200.911 Y171.592 E.08752
G1 X198.187 Y170.862 E.08752
G1 X195.632 Y169.67 E.08752
G1 X193.322 Y168.053 E.08752
G1 X191.328 Y166.059 E.08752
G1 X189.711 Y163.75 E.08752
G1 X188.52 Y161.194 E.08752
G1 X188.192 Y159.971 E.03932
G1 X187.79 Y158.471 E.0482
G1 X187.544 Y155.662 E.08752
G1 X187.79 Y152.853 E.08752
G1 X188.52 Y150.13 E.08752
G1 X189.055 Y148.982 E.03932
G1 X189.711 Y147.574 E.0482
G1 X191.328 Y145.265 E.08752
G1 X193.322 Y143.271 E.08752
G1 X195.632 Y141.654 E.08752
G1 X198.187 Y140.462 E.08752
G1 X200.911 Y139.732 E.08752
G1 X203.72 Y139.487 E.08752
G1 X204.982 Y139.597 E.03932
G1 X206.528 Y139.732 E.0482
G1 X209.252 Y140.462 E.08752
G1 X211.807 Y141.654 E.08752
M73 P52 R6
G1 X214.117 Y143.271 E.08752
G1 X216.111 Y145.265 E.08752
G1 X217.728 Y147.574 E.08752
G1 X218.92 Y150.13 E.08752
G1 X219.649 Y152.853 E.08752
G1 X219.89 Y155.601 E.08563
; WIPE_START
G1 F12000
M204 S8000
G1 X219.895 Y155.662 E-.02313
G1 X219.813 Y156.598 E-.35687
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.8 I1.181 J-.295 P1  F60000
G1 X218.812 Y152.59 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5535
M204 S8000
G1 X218.917 Y152.982 E.01359
G1 X219.024 Y154.2 E.04097
G3 X216.958 Y155.662 I-24.583 J-32.548 E.08482
G2 X216.152 Y157.066 I1.372 J1.722 E.05556
G2 X218.014 Y161.384 I5.925 J.005 E.16205
G1 X217.084 Y163.378 E.07373
G1 X215.541 Y165.582 E.09015
G1 X213.523 Y167.565 E.09484
G2 X212.447 Y165.489 I-6.484 J2.044 E.07875
G2 X209.471 Y163.15 I-11.889 J12.059 E.12712
G3 X208.664 Y161.746 I1.372 J-1.722 E.05556
G3 X209.968 Y158.002 I5.999 J-.01 E.13539
G3 X212.944 Y155.662 I11.89 J12.06 E.12712
G2 X213.75 Y154.258 I-1.372 J-1.722 E.05556
G2 X212.447 Y150.514 I-5.999 J-.01 E.13539
G2 X209.471 Y148.174 I-11.89 J12.06 E.12712
G3 X208.664 Y146.771 I1.372 J-1.722 E.05556
G3 X210.964 Y142.077 I5.779 J-.078 E.18174
G1 X208.998 Y141.16 E.07269
G1 X206.399 Y140.464 E.09014
G1 X204.917 Y140.335 E.04987
G2 X202.487 Y140.338 I-1.206 J6.892 E.08185
G2 X201.176 Y142.091 I1.192 J2.258 E.07581
G2 X202.48 Y145.835 I5.999 J.01 E.13539
G2 X205.456 Y148.174 I11.89 J-12.059 E.12712
G3 X206.263 Y149.578 I-1.372 J1.722 E.05556
G3 X204.959 Y153.322 I-6 J.01 E.13539
G3 X201.983 Y155.662 I-11.89 J-12.06 E.12712
G2 X201.176 Y157.066 I1.372 J1.722 E.05556
G2 X202.48 Y160.81 I5.999 J.01 E.13539
G2 X205.456 Y163.15 I11.89 J-12.06 E.12712
G3 X206.263 Y164.554 I-1.372 J1.722 E.05556
G3 X204.959 Y168.297 I-6 J.01 E.13539
G3 X201.983 Y170.637 I-11.891 J-12.061 E.12712
G1 X201.71 Y170.919 E.01314
G1 X201.04 Y170.86 E.02254
G1 X198.429 Y170.158 E.0906
G2 X198.775 Y169.233 I-1.471 J-1.078 E.0335
G2 X197.471 Y165.489 I-5.999 J-.01 E.13539
G2 X194.496 Y163.15 I-11.889 J12.058 E.12712
G3 X193.689 Y161.746 I1.372 J-1.722 E.05556
G3 X194.992 Y158.002 I6 J-.01 E.13539
G3 X197.968 Y155.662 I11.89 J12.06 E.12712
G2 X198.775 Y154.258 I-1.372 J-1.722 E.05556
G2 X197.471 Y150.514 I-5.999 J-.01 E.13539
G2 X194.496 Y148.174 I-11.89 J12.059 E.12712
G3 X193.689 Y146.771 I1.372 J-1.722 E.05556
G3 X194.143 Y144.431 I5.945 J-.061 E.08042
G3 X196.425 Y142.101 I3.769 J1.409 E.11252
M204 S10000
G1 X189.617 Y149.528 F60000
G1 F5535
M204 S8000
G1 X190.305 Y148.053 E.05457
G3 X191.288 Y149.578 I-1.116 J1.798 E.06285
G3 X188.37 Y154.718 I-5.917 J.038 E.20735
G1 X188.287 Y155.662 E.03177
G1 X188.522 Y158.342 E.09015
G1 X189.218 Y160.94 E.09014
G1 X190.137 Y162.911 E.07288
G3 X191.291 Y164.715 I-1.017 J1.922 E.07503
G2 X192.301 Y165.985 I4.106 J-2.229 E.05465
; WIPE_START
G1 F18423.913
G1 X191.898 Y165.582 E-.21675
G1 X191.651 Y165.23 E-.16325
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z1.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 8/82
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.484 Y155.662 F60000
G1 Z1.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5612
M204 S8000
G1 X219.244 Y158.399 E.09208
G1 X218.533 Y161.054 E.09208
G1 X217.372 Y163.544 E.09208
G1 X215.796 Y165.795 E.09208
G1 X213.853 Y167.738 E.09208
G1 X212.681 Y168.559 E.04793
G1 X211.602 Y169.314 E.04416
G1 X209.111 Y170.476 E.09208
G1 X206.457 Y171.187 E.09208
G1 X203.72 Y171.426 E.09208
G1 X200.982 Y171.187 E.09208
G1 X198.328 Y170.476 E.09208
G1 X195.837 Y169.314 E.09208
G1 X193.586 Y167.738 E.09208
G1 X191.643 Y165.795 E.09208
G1 X190.823 Y164.624 E.04793
G1 X190.067 Y163.544 E.04416
G1 X188.906 Y161.054 E.09208
G1 X188.195 Y158.399 E.09208
G1 X187.955 Y155.662 E.09208
G1 X188.195 Y152.925 E.09208
G1 X188.906 Y150.27 E.09208
G1 X190.067 Y147.78 E.09209
G1 X191.643 Y145.529 E.09208
G1 X193.586 Y143.586 E.09208
G1 X195.837 Y142.01 E.09208
G1 X198.328 Y140.848 E.09208
G1 X200.982 Y140.137 E.09208
G1 X203.72 Y139.898 E.09208
G1 X205.144 Y140.022 E.04793
G1 X206.457 Y140.137 E.04416
G1 X209.111 Y140.848 E.09208
G1 X211.602 Y142.01 E.09208
G1 X213.853 Y143.586 E.09208
G1 X215.796 Y145.529 E.09208
G1 X217.372 Y147.78 E.09208
G1 X218.533 Y150.27 E.09209
G1 X218.903 Y151.652 E.04792
G1 X219.244 Y152.925 E.04416
G1 X219.479 Y155.602 E.09007
; COOLING_NODE: 0
M204 S10000
G1 X219.877 Y155.661 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5360
M204 S5000
G1 X219.878 Y155.662 E.00005
G1 X219.632 Y158.468 E.08743
G1 X218.903 Y161.188 E.08743
G1 X217.713 Y163.741 E.08743
G1 X216.097 Y166.048 E.08743
G1 X214.106 Y168.04 E.08743
G1 X212.906 Y168.88 E.04546
G1 X211.799 Y169.655 E.04197
G1 X209.246 Y170.846 E.08743
G1 X206.525 Y171.575 E.08743
G1 X203.72 Y171.82 E.08743
G1 X200.914 Y171.575 E.08743
G1 X198.193 Y170.846 E.08743
G1 X195.641 Y169.655 E.08743
G1 X193.333 Y168.04 E.08743
G1 X191.342 Y166.048 E.08743
G1 X190.502 Y164.849 E.04546
G1 X189.726 Y163.741 E.04197
G1 X188.536 Y161.188 E.08743
G1 X187.807 Y158.468 E.08743
G1 X187.562 Y155.662 E.08743
G1 X187.807 Y152.856 E.08743
G1 X188.536 Y150.136 E.08743
G1 X189.726 Y147.583 E.08743
G1 X191.342 Y145.276 E.08743
G1 X193.333 Y143.284 E.08742
G1 X195.641 Y141.669 E.08743
G1 X198.193 Y140.479 E.08743
G1 X200.914 Y139.75 E.08743
G1 X203.72 Y139.504 E.08743
G1 X205.178 Y139.632 E.04546
G1 X206.525 Y139.75 E.04197
G1 X209.246 Y140.479 E.08743
G1 X211.799 Y141.669 E.08743
G1 X214.106 Y143.284 E.08743
G1 X216.097 Y145.276 E.08743
G1 X217.713 Y147.583 E.08743
G1 X218.903 Y150.136 E.08743
G1 X219.632 Y152.856 E.08743
G1 X219.872 Y155.601 E.08552
; WIPE_START
G1 F12000
M204 S8000
G1 X219.878 Y155.662 E-.02336
G1 X219.796 Y156.597 E-.35664
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2 I1.181 J-.295 P1  F60000
G1 X218.772 Y152.506 Z2
G1 Z1.6
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5612
M204 S8000
G3 X218.999 Y154.113 I-4.444 J1.448 E.05467
G3 X216.507 Y155.662 I-115.535 J-183.112 E.09833
G2 X215.895 Y156.598 I.819 J1.203 E.03845
G2 X218.025 Y161.32 I6.047 J.115 E.17939
G1 X217.069 Y163.369 E.07576
G1 X215.528 Y165.571 E.09004
G1 X213.607 Y167.485 E.09087
G2 X211.322 Y164.554 I-5.582 J1.995 E.12669
G3 X209.019 Y163.15 I87.307 J-145.804 E.09038
G3 X208.408 Y162.214 I.819 J-1.203 E.03845
G3 X211.092 Y157.066 I6.062 J-.113 E.20287
G2 X213.395 Y155.662 I-87.252 J-145.713 E.09038
G2 X214.007 Y154.726 I-.819 J-1.203 E.03845
G2 X211.322 Y149.578 I-6.062 J-.113 E.20288
G3 X209.019 Y148.174 I87.167 J-145.572 E.09038
G3 X208.408 Y147.239 I.819 J-1.203 E.03845
G3 X211.039 Y142.132 I6.05 J-.114 E.2006
G1 X208.992 Y141.177 E.0757
G1 X206.396 Y140.481 E.09004
G1 X203.72 Y140.247 E.09004
G1 X201.978 Y140.4 E.05859
G2 X200.92 Y141.623 I.936 J1.879 E.05563
G2 X203.605 Y146.771 I6.062 J.113 E.20287
G3 X205.908 Y148.174 I-87.296 J145.785 E.09038
G3 X206.519 Y149.11 I-.819 J1.203 E.03845
G3 X203.834 Y154.258 I-6.062 J.113 E.20288
G2 X201.532 Y155.662 I87.252 J145.713 E.09038
G2 X200.92 Y156.598 I.819 J1.203 E.03845
G2 X203.605 Y161.746 I6.062 J.113 E.20287
G3 X205.908 Y163.15 I-87.155 J145.554 E.09038
G3 X206.519 Y164.086 I-.819 J1.203 E.03845
G3 X203.834 Y169.233 I-6.062 J.113 E.20288
G2 X201.532 Y170.637 I87.182 J145.597 E.09038
G3 X201.043 Y170.843 I-.325 J-.089 E.02046
G1 X198.791 Y170.239 E.0781
G1 X199.032 Y169.701 E.01975
G2 X196.347 Y164.554 I-6.062 J-.113 E.20287
G3 X194.044 Y163.15 I87.437 J-146.017 E.09038
G3 X193.432 Y162.214 I.819 J-1.203 E.03845
G3 X196.117 Y157.066 I6.062 J-.113 E.20287
G2 X198.42 Y155.662 I-87.21 J-145.644 E.09038
G2 X199.032 Y154.726 I-.819 J-1.203 E.03845
G2 X196.347 Y149.578 I-6.062 J-.113 E.20287
G3 X194.044 Y148.174 I87.296 J-145.785 E.09038
G3 X193.432 Y147.239 I.819 J-1.203 E.03845
G3 X194.071 Y144.431 I6.068 J-.096 E.09743
G3 X196.477 Y142.096 I4.021 J1.736 E.11528
M204 S10000
G1 X189.732 Y149.322 F60000
G1 F5612
M204 S8000
G1 X190.439 Y147.857 E.05451
G1 X190.932 Y148.174 E.01968
G3 X191.544 Y149.11 I-.819 J1.203 E.03845
G3 X188.403 Y154.544 I-6.128 J.082 E.2208
G1 X188.305 Y155.662 E.03761
G1 X188.539 Y158.339 E.09004
G1 X189.234 Y160.934 E.09004
G1 X189.993 Y162.562 E.06018
G3 X190.932 Y163.15 I-4.604 J8.4 E.03714
G3 X191.544 Y164.086 I-.819 J1.203 E.03845
G1 X191.52 Y165.012 E.03106
G2 X192.581 Y166.24 I4.012 J-2.393 E.05464
; WIPE_START
G1 F18423.913
G1 X191.911 Y165.571 E-.3597
G1 X191.881 Y165.527 E-.0203
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 9/82
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.466 Y155.662 F60000
G1 Z1.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5732
M204 S8000
G1 X219.227 Y158.396 E.09198
G1 X218.517 Y161.048 E.09198
G1 X217.357 Y163.535 E.09198
G1 X215.782 Y165.784 E.09198
G1 X213.841 Y167.725 E.09198
G1 X211.593 Y169.299 E.09198
G1 X209.105 Y170.459 E.09198
G1 X207.533 Y170.881 E.05455
G1 X206.454 Y171.17 E.03743
G1 X203.72 Y171.409 E.09198
G1 X200.985 Y171.17 E.09198
G1 X198.334 Y170.459 E.09198
G1 X195.846 Y169.299 E.09198
G1 X193.598 Y167.725 E.09198
G1 X191.657 Y165.784 E.09198
G1 X190.082 Y163.536 E.09198
G1 X188.922 Y161.048 E.09198
G1 X188.501 Y159.475 E.05455
G1 X188.212 Y158.396 E.03743
G1 X187.973 Y155.662 E.09198
G1 X188.212 Y152.928 E.09198
G1 X188.922 Y150.276 E.09198
M73 P53 R6
G1 X190.082 Y147.789 E.09198
G1 X191.657 Y145.54 E.09198
G1 X193.598 Y143.599 E.09198
G1 X195.846 Y142.025 E.09198
G1 X198.334 Y140.865 E.09198
G1 X200.985 Y140.154 E.09198
G1 X203.72 Y139.915 E.09198
G1 X205.341 Y140.057 E.05455
G1 X206.454 Y140.154 E.03743
G1 X209.105 Y140.865 E.09198
G1 X211.593 Y142.025 E.09198
G1 X213.841 Y143.599 E.09198
G1 X215.782 Y145.54 E.09198
G1 X217.357 Y147.789 E.09198
G1 X218.517 Y150.276 E.09198
G1 X219.227 Y152.928 E.09198
G1 X219.461 Y155.602 E.08997
; COOLING_NODE: 0
M204 S10000
G1 X219.86 Y155.66 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5352
M204 S5000
G1 X219.86 Y155.662 E.00007
G1 X219.615 Y158.465 E.08733
G1 X218.887 Y161.182 E.08733
G1 X217.698 Y163.732 E.08733
G1 X216.084 Y166.037 E.08733
G1 X214.094 Y168.026 E.08733
G1 X211.79 Y169.64 E.08733
G1 X209.24 Y170.829 E.08733
G1 X206.522 Y171.557 E.08733
G1 X203.72 Y171.803 E.08733
G1 X200.917 Y171.557 E.08733
G1 X198.199 Y170.829 E.08733
G1 X195.649 Y169.64 E.08733
G1 X193.345 Y168.026 E.08733
G1 X191.355 Y166.037 E.08733
G1 X189.741 Y163.732 E.08733
G1 X188.552 Y161.182 E.08733
G1 X187.824 Y158.465 E.08733
G1 X187.579 Y155.662 E.08733
G1 X187.824 Y152.859 E.08733
G1 X188.552 Y150.142 E.08733
G1 X189.742 Y147.592 E.08733
G1 X191.355 Y145.287 E.08733
G1 X193.345 Y143.298 E.08733
G1 X195.649 Y141.684 E.08733
G1 X198.199 Y140.495 E.08733
G1 X200.917 Y139.767 E.08733
G1 X203.72 Y139.522 E.08733
G1 X205.375 Y139.666 E.0516
G1 X206.522 Y139.767 E.03574
G1 X209.24 Y140.495 E.08733
G1 X211.79 Y141.684 E.08733
G1 X214.094 Y143.298 E.08733
G1 X216.084 Y145.287 E.08733
G1 X217.698 Y147.592 E.08733
G1 X218.887 Y150.142 E.08733
G1 X219.615 Y152.859 E.08733
G1 X219.855 Y155.6 E.0854
; WIPE_START
G1 F12000
M204 S8000
G1 X219.86 Y155.662 E-.02364
G1 X219.778 Y156.596 E-.35636
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.2 I1.18 J-.296 P1  F60000
G1 X218.734 Y152.434 Z2.2
G1 Z1.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5732
M204 S8000
G3 X218.975 Y154.038 I-4.43 J1.484 E.05465
G3 X215.771 Y155.662 I-31.304 J-57.805 E.12038
G1 X215.446 Y156.13 E.0191
G2 X215.671 Y157.534 I3.092 J.223 E.04808
G2 X218.031 Y161.266 I7.189 J-1.933 E.15022
G1 X217.054 Y163.361 E.07745
G1 X215.515 Y165.559 E.08994
G1 X213.686 Y167.388 E.08665
G2 X211.16 Y164.554 I-5.554 J2.408 E.12941
G2 X208.283 Y163.15 I-89.057 J178.823 E.10726
G1 X207.958 Y162.682 E.0191
G3 X208.184 Y161.278 I3.092 J-.223 E.04808
G3 X211.255 Y157.066 I6.805 J1.736 E.17895
G3 X214.131 Y155.662 I89.15 J179.015 E.10726
G1 X214.456 Y155.194 E.0191
G2 X214.231 Y153.79 I-3.092 J-.223 E.04808
G2 X211.16 Y149.578 I-6.805 J1.736 E.17895
G2 X208.283 Y148.174 I-89.18 J179.075 E.10726
G1 X207.958 Y147.706 E.0191
G3 X208.184 Y146.303 I3.092 J-.223 E.04808
G3 X211.113 Y142.185 I6.787 J1.729 E.17324
G1 X208.986 Y141.193 E.07867
G1 X206.393 Y140.499 E.08993
G1 X203.72 Y140.265 E.08994
G1 X201.192 Y140.486 E.08503
G2 X200.47 Y141.155 I.26 J1.004 E.03435
G2 X200.696 Y142.559 I3.092 J.223 E.04808
G2 X203.767 Y146.771 I6.805 J-1.736 E.17895
G2 X206.644 Y148.174 I89.15 J-179.015 E.10726
G1 X206.969 Y148.642 E.0191
G3 X206.743 Y150.046 I-3.092 J.223 E.04808
G3 X203.672 Y154.258 I-6.805 J-1.736 E.17895
G3 X200.796 Y155.662 I-89.15 J-179.015 E.10726
G1 X200.47 Y156.13 E.0191
G2 X200.696 Y157.534 I3.092 J.223 E.04808
G2 X203.767 Y161.746 I6.805 J-1.736 E.17895
G2 X206.644 Y163.15 I89.273 J-179.268 E.10726
G1 X206.969 Y163.618 E.0191
G3 X206.743 Y165.022 I-3.092 J.223 E.04808
G3 X203.672 Y169.233 I-6.805 J-1.736 E.17895
G3 X200.796 Y170.637 I-89.212 J-179.14 E.10726
G1 X200.725 Y170.739 E.00417
G1 X199.342 Y170.369 E.04796
G1 X199.481 Y170.169 E.00815
G2 X199.256 Y168.765 I-3.092 J-.223 E.04808
G2 X196.185 Y164.554 I-6.805 J1.736 E.17895
G2 X193.308 Y163.15 I-89.027 J178.763 E.10726
G1 X192.983 Y162.682 E.0191
G3 X193.208 Y161.278 I3.092 J-.223 E.04808
G3 X196.279 Y157.066 I6.805 J1.736 E.17895
G3 X199.156 Y155.662 I89.21 J179.138 E.10726
G1 X199.481 Y155.194 E.0191
G2 X199.256 Y153.79 I-3.092 J-.223 E.04808
G2 X196.185 Y149.578 I-6.805 J1.736 E.17895
G2 X193.308 Y148.174 I-89.15 J179.015 E.10726
G1 X192.983 Y147.706 E.0191
G1 X192.984 Y147.239 E.01568
G3 X193.988 Y144.431 I10.495 J2.168 E.10025
G3 X196.498 Y142.105 I4.325 J2.151 E.11722
M204 S10000
G1 X189.861 Y149.088 F60000
G1 F5732
M204 S8000
G1 X190.385 Y147.963 E.04156
G1 X190.608 Y147.646 E.013
G3 X191.668 Y148.174 I-4.388 J10.129 E.03974
G1 X191.994 Y148.642 E.0191
G3 X191.433 Y150.982 I-6.456 J-.309 E.0811
G3 X188.433 Y154.396 I-5.822 J-2.091 E.15596
G1 X188.322 Y155.662 E.04257
G1 X188.556 Y158.336 E.08994
G1 X188.837 Y159.385 E.03641
G2 X189.893 Y162.305 I8.808 J-1.533 E.10458
G3 X191.668 Y163.15 I-6.958 J16.92 E.06591
G1 X191.994 Y163.618 E.0191
G3 X191.694 Y165.229 I-5.548 J-.198 E.05514
G1 X191.925 Y165.559 E.01349
G1 X192.791 Y166.426 E.04107
; WIPE_START
G1 F18423.913
G1 X192.084 Y165.719 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z2.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 10/82
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.449 Y155.662 F60000
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5561
M204 S8000
G1 X219.21 Y158.393 E.09188
G1 X218.5 Y161.042 E.09188
G1 X217.342 Y163.527 E.09188
G1 X215.769 Y165.773 E.09188
G1 X213.83 Y167.711 E.09188
G1 X212.335 Y168.759 E.06118
G1 X211.584 Y169.284 E.0307
G1 X209.099 Y170.443 E.09188
G1 X206.451 Y171.152 E.09188
G1 X203.72 Y171.391 E.09188
G1 X200.988 Y171.152 E.09188
G1 X198.34 Y170.443 E.09188
G1 X195.855 Y169.284 E.09188
G1 X193.609 Y167.711 E.09188
G1 X191.67 Y165.773 E.09188
G1 X190.098 Y163.527 E.09188
G1 X188.939 Y161.042 E.09188
G1 X188.466 Y159.278 E.06118
G1 X188.229 Y158.393 E.0307
G1 X187.99 Y155.662 E.09188
G1 X188.229 Y152.931 E.09188
G1 X188.939 Y150.282 E.09188
G1 X190.098 Y147.797 E.09188
G1 X191.67 Y145.551 E.09188
G1 X193.609 Y143.613 E.09188
G1 X195.855 Y142.04 E.09188
G1 X198.34 Y140.881 E.09188
G1 X200.988 Y140.172 E.09188
G1 X203.72 Y139.933 E.09188
G1 X205.538 Y140.092 E.06118
G1 X206.451 Y140.172 E.0307
G1 X209.099 Y140.881 E.09188
G1 X211.584 Y142.04 E.09188
G1 X213.83 Y143.613 E.09188
G1 X215.769 Y145.551 E.09188
G1 X217.342 Y147.797 E.09188
G1 X218.5 Y150.282 E.09188
G1 X218.973 Y152.046 E.06118
G1 X219.21 Y152.931 E.0307
G1 X219.444 Y155.602 E.08987
; COOLING_NODE: 0
M204 S10000
G1 X219.842 Y155.659 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5340
M204 S5000
G1 X219.843 Y155.662 E.00009
G1 X219.598 Y158.462 E.08724
G1 X218.87 Y161.176 E.08724
G1 X217.682 Y163.724 E.08724
G1 X216.07 Y166.026 E.08724
G1 X214.083 Y168.013 E.08724
G1 X211.781 Y169.625 E.08724
G1 X209.234 Y170.813 E.08724
G1 X206.519 Y171.54 E.08724
G1 X203.72 Y171.785 E.08724
G1 X200.92 Y171.54 E.08724
G1 X198.205 Y170.813 E.08724
G1 X195.658 Y169.625 E.08724
G1 X193.356 Y168.013 E.08724
G1 X191.369 Y166.026 E.08724
G1 X189.757 Y163.724 E.08724
G1 X188.569 Y161.176 E.08724
G1 X188.088 Y159.38 E.05773
G1 X187.842 Y158.462 E.0295
G1 X187.597 Y155.662 E.08724
G1 X187.842 Y152.862 E.08724
G1 X188.569 Y150.148 E.08724
G1 X189.757 Y147.601 E.08724
G1 X191.369 Y145.298 E.08724
G1 X193.356 Y143.311 E.08724
G1 X195.658 Y141.699 E.08724
G1 X198.205 Y140.511 E.08724
G1 X200.92 Y139.784 E.08724
G1 X203.72 Y139.539 E.08724
G1 X205.572 Y139.701 E.05773
G1 X206.519 Y139.784 E.0295
G1 X209.234 Y140.511 E.08724
G1 X211.781 Y141.699 E.08724
G1 X214.083 Y143.311 E.08724
G1 X216.07 Y145.298 E.08724
G1 X217.682 Y147.601 E.08724
G1 X218.87 Y150.148 E.08724
G1 X219.352 Y151.944 E.05773
G1 X219.598 Y152.862 E.0295
G1 X219.837 Y155.599 E.08528
; WIPE_START
G1 F12000
M204 S8000
G1 X219.843 Y155.662 E-.02395
G1 X219.761 Y156.595 E-.35605
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.4 I1.072 J-.576 P1  F60000
G1 X212.531 Y143.128 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5561
M204 S8000
G1 X211.174 Y142.233 E.05445
G2 X208.399 Y145.276 I3.176 J5.683 E.14041
G3 X207.463 Y147.088 I-15.337 J-6.773 E.06839
G1 X206.995 Y147.472 E.02028
G1 X206.527 Y147.54 E.01585
G3 X200.912 Y143.585 I.63 J-6.859 E.24096
G2 X199.976 Y141.773 I-15.338 J6.774 E.06839
G1 X199.508 Y141.39 E.02028
G1 X199.04 Y141.321 E.01585
G2 X194.36 Y143.759 I.879 J7.398 E.18075
G2 X192.956 Y146.249 I11.146 J7.925 E.09597
G1 X192.488 Y147.088 E.03218
G1 X192.02 Y147.472 E.02028
G3 X190.793 Y147.412 I-.521 J-1.925 E.04186
G1 X190.4 Y147.972 E.02293
G1 X189.267 Y150.402 E.08984
G1 X188.573 Y152.991 E.08983
G1 X188.462 Y154.266 E.04288
G2 X191.552 Y151.073 I-2.741 J-5.745 E.15211
G3 X192.488 Y149.261 I15.339 J6.775 E.06839
G1 X192.956 Y148.877 E.02028
G1 X193.424 Y148.809 E.01585
G3 X199.04 Y152.763 I-.63 J6.859 E.24096
G2 X199.976 Y154.576 I15.338 J-6.774 E.06839
G1 X200.444 Y154.959 E.02028
G1 X200.912 Y155.028 E.01585
G2 X206.527 Y151.073 I-.63 J-6.859 E.24096
G3 X207.463 Y149.261 I15.335 J6.772 E.06839
G1 X207.931 Y148.877 E.02028
G1 X208.399 Y148.809 E.01585
G3 X214.015 Y152.763 I-.63 J6.859 E.24096
G2 X214.951 Y154.576 I15.334 J-6.772 E.06839
G1 X215.419 Y154.959 E.02028
G1 X215.887 Y155.028 E.01585
G2 X218.951 Y153.97 I-.707 J-7.018 E.10961
G1 X219.099 Y155.662 E.0569
G1 X218.866 Y158.333 E.08984
M73 P54 R6
G1 X218.172 Y160.922 E.08983
G1 X218.042 Y161.2 E.01028
G3 X215.887 Y158.561 I3.675 J-5.201 E.11561
G2 X214.951 Y156.748 I-15.335 J6.772 E.06839
G1 X214.483 Y156.365 E.02028
G1 X214.015 Y156.296 E.01585
G2 X208.399 Y160.251 I.63 J6.859 E.24096
G3 X207.463 Y162.063 I-15.338 J-6.774 E.06839
G1 X206.995 Y162.447 E.02028
G1 X206.527 Y162.515 E.01585
G3 X200.912 Y158.561 I.63 J-6.859 E.24096
G2 X199.976 Y156.748 I-15.337 J6.773 E.06839
G1 X199.508 Y156.365 E.02028
G1 X199.04 Y156.296 E.01585
G2 X193.424 Y160.251 I.63 J6.859 E.24096
G3 X192.488 Y162.063 I-15.338 J-6.774 E.06839
G1 X192.02 Y162.447 E.02028
G1 X191.552 Y162.515 E.01585
G3 X189.814 Y162.095 I.543 J-6.048 E.06014
G1 X190.4 Y163.352 E.04647
G1 X191.852 Y165.425 E.08481
G3 X192.488 Y164.236 I10.073 J4.627 E.04522
G1 X192.956 Y163.852 E.02028
G1 X193.424 Y163.784 E.01585
G3 X199.04 Y167.739 I-.63 J6.859 E.24096
G2 X199.976 Y169.551 I15.337 J-6.773 E.06839
G1 X200.444 Y169.934 E.02028
G1 X200.912 Y170.003 E.01585
G2 X206.527 Y166.048 I-.63 J-6.859 E.24096
G3 X207.463 Y164.236 I15.332 J6.771 E.06839
G1 X207.931 Y163.852 E.02028
G1 X208.399 Y163.784 E.01585
G3 X213.764 Y167.285 I-.609 J6.794 E.22347
G1 X212.455 Y168.249 E.05447
; WIPE_START
G1 F18423.913
G1 X213.26 Y167.656 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z2.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 11/82
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.431 Y155.662 F60000
G1 Z2.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5426
M204 S8000
G1 X219.193 Y158.39 E.09178
G1 X218.484 Y161.036 E.09178
G1 X217.326 Y163.518 E.09178
G1 X215.756 Y165.761 E.09178
G1 X213.819 Y167.698 E.09178
G1 X211.576 Y169.269 E.09178
G1 X209.093 Y170.426 E.09178
G1 X206.448 Y171.135 E.09178
G1 X203.72 Y171.374 E.09178
G1 X200.991 Y171.135 E.09178
G1 X198.346 Y170.426 E.09178
G1 X195.864 Y169.269 E.09178
G1 X193.62 Y167.698 E.09178
G1 X191.684 Y165.761 E.09178
G1 X190.113 Y163.518 E.09178
G1 X188.955 Y161.036 E.09178
G1 X188.246 Y158.39 E.09178
G1 X188.008 Y155.662 E.09178
G1 X188.246 Y152.934 E.09178
G1 X188.955 Y150.288 E.09178
G1 X190.113 Y147.806 E.09178
G1 X191.684 Y145.563 E.09178
G1 X193.62 Y143.626 E.09178
G1 X195.864 Y142.055 E.09178
G1 X198.346 Y140.898 E.09178
G1 X200.991 Y140.189 E.09178
G1 X203.72 Y139.95 E.09178
G1 X205.735 Y140.126 E.0678
G1 X206.448 Y140.189 E.02397
G1 X209.093 Y140.898 E.09178
G1 X211.576 Y142.055 E.09178
G1 X213.819 Y143.626 E.09178
G1 X215.756 Y145.563 E.09178
G1 X217.326 Y147.806 E.09178
G1 X218.484 Y150.288 E.09178
G1 X219.008 Y152.243 E.0678
G1 X219.193 Y152.934 E.02397
G1 X219.426 Y155.602 E.08977
; COOLING_NODE: 0
M204 S10000
G1 X219.825 Y155.658 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5323
M204 S5000
G1 X219.825 Y155.662 E.00012
G1 X219.58 Y158.459 E.08714
G1 X218.854 Y161.17 E.08714
G1 X217.667 Y163.715 E.08714
G1 X216.057 Y166.014 E.08714
G1 X214.072 Y168 E.08714
G1 X211.772 Y169.61 E.08714
G1 X209.228 Y170.796 E.08714
G1 X206.516 Y171.523 E.08714
G1 X203.72 Y171.768 E.08714
G1 X200.923 Y171.523 E.08714
G1 X198.211 Y170.796 E.08714
G1 X195.667 Y169.61 E.08714
G1 X193.367 Y168 E.08714
G1 X191.382 Y166.014 E.08714
G1 X189.772 Y163.715 E.08714
G1 X188.585 Y161.17 E.08714
G1 X187.859 Y158.459 E.08714
G1 X187.614 Y155.662 E.08714
G1 X187.859 Y152.865 E.08714
G1 X188.585 Y150.154 E.08714
G1 X189.772 Y147.609 E.08714
G1 X191.382 Y145.31 E.08714
G1 X193.367 Y143.325 E.08714
G1 X195.667 Y141.714 E.08714
G1 X198.211 Y140.528 E.08714
G1 X200.923 Y139.801 E.08714
G1 X203.72 Y139.557 E.08714
G1 X205.769 Y139.736 E.06387
G1 X206.516 Y139.801 E.02327
G1 X209.228 Y140.528 E.08714
G1 X211.772 Y141.714 E.08714
G1 X214.072 Y143.325 E.08714
G1 X216.057 Y145.31 E.08714
G1 X217.667 Y147.609 E.08714
G1 X218.854 Y150.154 E.08714
G1 X219.386 Y152.141 E.06387
G1 X219.58 Y152.865 E.02327
G1 X219.819 Y155.598 E.08516
; WIPE_START
G1 F12000
M204 S8000
G1 X219.825 Y155.662 E-.02429
G1 X219.743 Y156.595 E-.35571
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.6 I1.074 J-.573 P1  F60000
G1 X212.585 Y143.187 Z2.6
G1 Z2.2
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5426
M204 S8000
G1 X211.235 Y142.281 E.05448
G1 X210.271 Y142.838 E.0373
G2 X207.931 Y145.777 I5.355 J6.663 E.12694
G3 X206.527 Y147.122 I-2.402 J-1.102 E.06671
G1 X205.591 Y147.141 E.03137
G3 X202.784 Y146.024 I1.266 J-7.268 E.10199
G3 X200.444 Y143.084 I5.355 J-6.663 E.12694
G2 X199.04 Y141.739 I-2.402 J1.102 E.06671
G1 X198.104 Y141.72 E.03137
G2 X194.36 Y143.683 I.929 J6.322 E.14438
G2 X192.488 Y146.476 I37.823 J27.377 E.11268
G3 X191.009 Y147.133 I-1.316 J-.968 E.05675
G1 X190.415 Y147.981 E.03468
G1 X189.284 Y150.408 E.08974
G1 X188.591 Y152.994 E.08973
G1 X188.489 Y154.156 E.03908
G2 X189.68 Y153.511 I-1.398 J-4.006 E.04559
G2 X192.02 Y150.571 I-5.355 J-6.663 E.12694
G3 X193.424 Y149.227 I2.402 J1.102 E.06671
G1 X194.36 Y149.208 E.03137
G3 X197.168 Y150.325 I-1.267 J7.268 E.10199
G3 X199.508 Y153.265 I-5.355 J6.663 E.12694
G2 X200.912 Y154.61 I2.402 J-1.102 E.06671
G1 X201.848 Y154.629 E.03137
G2 X204.656 Y153.511 I-1.266 J-7.268 E.10199
G2 X206.995 Y150.571 I-5.355 J-6.663 E.12694
G3 X208.399 Y149.227 I2.402 J1.102 E.06671
G1 X209.335 Y149.208 E.03137
G3 X212.143 Y150.325 I-1.267 J7.268 E.10199
G3 X214.483 Y153.265 I-5.355 J6.663 E.12694
G2 X215.887 Y154.61 I2.402 J-1.102 E.06671
G1 X216.823 Y154.629 E.03137
G2 X218.93 Y153.921 I-1.244 J-7.188 E.07477
G1 X219.082 Y155.662 E.05858
G1 X218.848 Y158.33 E.08974
G1 X218.155 Y160.916 E.08973
G1 X218.04 Y161.163 E.00913
G1 X217.759 Y160.999 E.01092
G3 X215.419 Y158.059 I5.355 J-6.663 E.12694
G2 X214.015 Y156.714 I-2.402 J1.102 E.06671
G1 X213.079 Y156.695 E.03137
G2 X210.271 Y157.813 I1.266 J7.268 E.10199
G2 X207.931 Y160.753 I5.355 J6.663 E.12694
G3 X206.527 Y162.097 I-2.402 J-1.102 E.06671
G1 X205.591 Y162.116 E.03137
G3 X202.784 Y160.999 I1.267 J-7.268 E.10199
G3 X200.444 Y158.059 I5.355 J-6.664 E.12694
G2 X199.04 Y156.714 I-2.402 J1.102 E.06671
G1 X198.104 Y156.695 E.03137
G2 X195.296 Y157.813 I1.267 J7.268 E.10199
G2 X192.956 Y160.753 I5.355 J6.663 E.12694
G3 X191.552 Y162.097 I-2.402 J-1.102 E.06671
G3 X189.753 Y161.922 I-.544 J-3.742 E.06117
G1 X190.415 Y163.343 E.05253
G1 X191.951 Y165.537 E.08974
G1 X192.02 Y165.547 E.00233
G3 X193.424 Y164.202 I2.402 J1.102 E.06671
G1 X194.36 Y164.183 E.03137
G3 X197.168 Y165.3 I-1.267 J7.268 E.10199
G3 X199.508 Y168.24 I-5.355 J6.663 E.12694
G2 X200.912 Y169.585 I2.402 J-1.102 E.06671
G1 X201.848 Y169.604 E.03137
G2 X204.656 Y168.486 I-1.267 J-7.268 E.10199
G2 X206.995 Y165.547 I-5.355 J-6.663 E.12694
G3 X208.399 Y164.202 I2.402 J1.102 E.06671
G1 X209.335 Y164.183 E.03137
G3 X213.84 Y167.184 I-.824 J6.118 E.18778
G1 X213.594 Y167.43 E.01165
G1 X212.545 Y168.165 E.04292
; WIPE_START
G1 F18423.913
G1 X213.364 Y167.591 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z2.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 12/82
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.414 Y155.662 F60000
G1 Z2.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5356
M204 S8000
G1 X219.176 Y158.387 E.09167
G1 X218.467 Y161.03 E.09167
G1 X217.311 Y163.509 E.09168
G1 X215.742 Y165.75 E.09167
G1 X213.808 Y167.685 E.09167
G1 X211.567 Y169.254 E.09167
G1 X209.087 Y170.41 E.09168
G1 X206.942 Y170.985 E.07443
G1 X206.445 Y171.118 E.01725
G1 X203.72 Y171.356 E.09167
G1 X200.994 Y171.118 E.09167
G1 X198.352 Y170.41 E.09167
G1 X195.872 Y169.254 E.09168
G1 X193.631 Y167.685 E.09167
G1 X191.697 Y165.75 E.09167
G1 X190.128 Y163.509 E.09167
G1 X188.972 Y161.03 E.09168
G1 X188.397 Y158.884 E.07443
G1 X188.264 Y158.387 E.01725
G1 X188.025 Y155.662 E.09167
G1 X188.264 Y152.937 E.09167
G1 X188.972 Y150.294 E.09167
G1 X190.128 Y147.815 E.09168
G1 X191.697 Y145.574 E.09167
G1 X193.631 Y143.639 E.09167
G1 X195.872 Y142.07 E.09168
G1 X198.352 Y140.914 E.09168
G1 X200.994 Y140.206 E.09167
G1 X203.72 Y139.968 E.09167
G1 X205.932 Y140.161 E.07443
G1 X206.445 Y140.206 E.01725
G1 X209.087 Y140.914 E.09167
G1 X211.567 Y142.07 E.09168
G1 X213.808 Y143.639 E.09167
G1 X215.742 Y145.574 E.09167
G1 X217.311 Y147.815 E.09167
G1 X218.467 Y150.294 E.09168
G1 X219.042 Y152.44 E.07443
G1 X219.176 Y152.937 E.01725
G1 X219.409 Y155.602 E.08966
; COOLING_NODE: 0
M204 S10000
G1 X219.807 Y155.657 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5303
M204 S5000
G1 X219.808 Y155.662 E.00015
G1 X219.563 Y158.456 E.08705
G1 X218.837 Y161.164 E.08705
G1 X217.652 Y163.706 E.08705
G1 X216.044 Y166.003 E.08705
G1 X214.061 Y167.986 E.08705
G1 X211.764 Y169.595 E.08705
G1 X209.222 Y170.78 E.08705
G1 X206.513 Y171.506 E.08705
G1 X203.72 Y171.75 E.08705
G1 X200.926 Y171.506 E.08705
G1 X198.217 Y170.78 E.08705
G1 X195.676 Y169.595 E.08705
G1 X193.378 Y167.986 E.08705
G1 X191.395 Y166.003 E.08705
G1 X189.787 Y163.706 E.08705
G1 X188.602 Y161.164 E.08705
G1 X188.018 Y158.986 E.07001
M73 P54 R5
G1 X187.876 Y158.456 E.01704
G1 X187.632 Y155.662 E.08705
G1 X187.876 Y152.868 E.08705
G1 X188.602 Y150.16 E.08705
G1 X189.787 Y147.618 E.08705
G1 X191.395 Y145.321 E.08705
G1 X193.378 Y143.338 E.08705
G1 X195.676 Y141.729 E.08705
G1 X198.217 Y140.544 E.08705
G1 X200.926 Y139.818 E.08705
G1 X203.72 Y139.574 E.08705
M73 P55 R5
G1 X205.966 Y139.771 E.07001
G1 X206.513 Y139.818 E.01704
G1 X209.222 Y140.544 E.08705
G1 X211.764 Y141.729 E.08705
G1 X214.061 Y143.338 E.08705
G1 X216.044 Y145.321 E.08705
G1 X217.652 Y147.618 E.08705
G1 X218.837 Y150.16 E.08705
G1 X219.421 Y152.338 E.07001
G1 X219.563 Y152.868 E.01704
G1 X219.802 Y155.597 E.08503
; WIPE_START
G1 F12000
M204 S8000
G1 X219.808 Y155.662 E-.02467
G1 X219.726 Y156.594 E-.35533
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.8 I1.075 J-.571 P1  F60000
G1 X212.642 Y143.249 Z2.8
G1 Z2.4
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5356
M204 S8000
G1 X211.3 Y142.33 E.05452
G2 X209.335 Y143.604 I2.755 J6.397 E.07884
G2 X207.463 Y146.062 I16.026 J14.148 E.10361
G3 X206.059 Y146.901 I-1.839 J-1.484 E.05596
G3 X201.848 Y145.257 I-.186 J-5.74 E.15572
G3 X199.976 Y142.799 I16.027 J-14.149 E.10361
G2 X198.572 Y141.961 I-1.839 J1.484 E.05596
G2 X196.232 Y142.359 I-.237 J5.677 E.08013
G2 X194.36 Y143.604 I4.306 J8.502 E.07551
G2 X192.488 Y146.062 I16.027 J14.149 E.10361
G3 X191.217 Y146.867 I-1.802 J-1.44 E.05136
G1 X190.431 Y147.99 E.04593
G1 X189.3 Y150.414 E.08963
G1 X188.608 Y152.997 E.08963
G1 X188.515 Y154.063 E.03583
G2 X190.616 Y152.744 I-2.271 J-5.955 E.08367
G2 X192.488 Y150.287 I-16.024 J-14.147 E.10361
G3 X193.892 Y149.448 I1.839 J1.484 E.05596
G3 X198.104 Y151.092 I.186 J5.74 E.15572
G3 X199.976 Y153.55 I-16.022 J14.146 E.10361
G2 X201.38 Y154.388 I1.839 J-1.484 E.05596
G2 X205.591 Y152.744 I.186 J-5.74 E.15572
G2 X207.463 Y150.287 I-16.025 J-14.148 E.10361
G3 X208.867 Y149.448 I1.839 J1.484 E.05596
G3 X213.079 Y151.092 I.186 J5.74 E.15572
G3 X214.951 Y153.55 I-16.025 J14.148 E.10361
G2 X215.887 Y154.269 I1.826 J-1.407 E.04
G2 X218.908 Y153.879 I.978 J-4.324 E.10422
G1 X219.064 Y155.662 E.05998
G1 X218.831 Y158.327 E.08963
G1 X218.034 Y161.135 E.09783
G1 X217.759 Y160.993 E.01039
G1 X216.823 Y160.232 E.04041
G3 X214.951 Y157.774 I16.025 J-14.147 E.10361
G2 X213.547 Y156.936 I-1.839 J1.484 E.05596
G2 X209.335 Y158.58 I-.186 J5.74 E.15572
G2 X207.463 Y161.037 I16.025 J14.147 E.10361
G3 X206.059 Y161.876 I-1.839 J-1.484 E.05596
G3 X201.848 Y160.232 I-.186 J-5.74 E.15572
G3 X199.976 Y157.774 I16.027 J-14.149 E.10361
G2 X198.572 Y156.936 I-1.839 J1.484 E.05596
G2 X194.36 Y158.58 I-.186 J5.74 E.15572
G2 X192.488 Y161.037 I16.026 J14.148 E.10361
G1 X192.02 Y161.493 E.02189
G3 X189.705 Y161.778 I-1.48 J-2.477 E.08048
G1 X190.431 Y163.334 E.05755
G1 X191.965 Y165.526 E.08964
G1 X192.16 Y165.721 E.00924
G3 X193.892 Y164.423 I2.354 J1.339 E.0746
G3 X198.104 Y166.067 I.186 J5.74 E.15572
G3 X199.976 Y168.525 I-16.021 J14.144 E.10361
G2 X201.38 Y169.363 I1.839 J-1.484 E.05596
G2 X205.591 Y167.72 I.186 J-5.74 E.15572
G2 X207.463 Y165.262 I-16.026 J-14.148 E.10361
G3 X208.867 Y164.423 I1.839 J1.484 E.05596
G3 X213.915 Y167.084 I.142 J5.85 E.19975
G3 X212.634 Y168.081 I-3.467 J-3.134 E.05467
; WIPE_START
G1 F18423.913
G1 X213.453 Y167.508 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z2.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 13/82
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.396 Y155.662 F60000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5303
M204 S8000
G1 X219.158 Y158.384 E.09157
G1 X218.451 Y161.024 E.09157
G1 X217.296 Y163.501 E.09157
G1 X215.729 Y165.739 E.09157
G1 X213.796 Y167.671 E.09157
G1 X211.558 Y169.239 E.09157
G1 X209.081 Y170.394 E.09157
G1 X206.442 Y171.101 E.09157
G1 X203.72 Y171.339 E.09157
G1 X200.997 Y171.101 E.09157
G1 X198.358 Y170.394 E.09157
G1 X195.881 Y169.239 E.09157
G1 X193.643 Y167.671 E.09157
G1 X191.71 Y165.739 E.09157
G1 X190.143 Y163.501 E.09157
G1 X188.988 Y161.024 E.09157
G1 X188.281 Y158.384 E.09157
G1 X188.043 Y155.662 E.09157
G1 X188.281 Y152.94 E.09157
G1 X188.988 Y150.3 E.09157
G1 X190.143 Y147.824 E.09157
G1 X191.71 Y145.585 E.09157
G1 X193.643 Y143.653 E.09157
G1 X195.881 Y142.085 E.09157
G1 X198.358 Y140.931 E.09157
G1 X200.997 Y140.223 E.09157
G1 X203.72 Y139.985 E.09157
G1 X206.129 Y140.196 E.08105
G1 X206.442 Y140.223 E.01052
G1 X209.081 Y140.931 E.09157
G1 X211.558 Y142.085 E.09157
G1 X213.796 Y143.653 E.09157
G1 X215.729 Y145.585 E.09157
G1 X217.296 Y147.824 E.09157
G1 X218.451 Y150.3 E.09157
G1 X219.077 Y152.637 E.08105
G1 X219.158 Y152.94 E.01052
G1 X219.391 Y155.602 E.08956
; COOLING_NODE: 0
M204 S10000
G1 X219.79 Y155.656 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5280
M204 S5000
G1 X219.79 Y155.662 E.00019
G1 X219.546 Y158.453 E.08695
G1 X218.821 Y161.158 E.08695
G1 X217.637 Y163.697 E.08695
G1 X216.03 Y165.992 E.08696
G1 X214.049 Y167.973 E.08695
G1 X211.755 Y169.58 E.08696
G1 X209.216 Y170.763 E.08695
G1 X206.51 Y171.488 E.08695
G1 X203.72 Y171.733 E.08695
G1 X200.929 Y171.488 E.08695
G1 X198.223 Y170.763 E.08695
G1 X195.684 Y169.58 E.08695
G1 X193.39 Y167.973 E.08696
G1 X191.409 Y165.992 E.08695
G1 X189.802 Y163.697 E.08696
G1 X188.618 Y161.158 E.08695
G1 X187.893 Y158.453 E.08695
G1 X187.649 Y155.662 E.08695
G1 X187.893 Y152.871 E.08695
G1 X188.618 Y150.166 E.08695
G1 X189.802 Y147.627 E.08695
G1 X191.409 Y145.332 E.08696
G1 X193.39 Y143.351 E.08695
G1 X195.684 Y141.745 E.08696
G1 X198.223 Y140.561 E.08695
G1 X200.929 Y139.836 E.08695
G1 X203.72 Y139.592 E.08695
G1 X206.163 Y139.805 E.07614
G1 X206.51 Y139.836 E.01081
G1 X209.216 Y140.561 E.08695
G1 X211.755 Y141.745 E.08695
G1 X214.049 Y143.351 E.08696
G1 X216.03 Y145.332 E.08695
G1 X217.637 Y147.627 E.08696
G1 X218.821 Y150.166 E.08695
G1 X219.546 Y152.871 E.08695
G1 X219.784 Y155.596 E.0849
; WIPE_START
G1 F12000
M204 S8000
G1 X219.79 Y155.662 E-.02508
G1 X219.709 Y156.592 E-.35492
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3 I-1.038 J-.636 P1  F60000
G1 X212.724 Y167.997 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5303
M204 S8000
G2 X213.991 Y166.984 I-2.239 J-4.1 E.05465
G2 X209.335 Y164.594 I-4.652 J3.331 E.18216
G2 X207.463 Y165.589 I.226 J2.683 E.07302
G3 X205.591 Y167.802 I-14.88 J-10.688 E.09723
G3 X201.38 Y169.122 I-3.543 J-3.925 E.15258
G3 X199.976 Y168.198 I.869 J-2.848 E.0571
G2 X198.104 Y165.985 I-14.878 J10.687 E.09723
G2 X193.892 Y164.665 I-3.543 J3.925 E.15258
G2 X192.296 Y165.832 I.961 J2.988 E.06741
G1 X191.978 Y165.514 E.01506
G1 X190.446 Y163.326 E.08953
G1 X189.68 Y161.656 E.06155
G2 X192.488 Y160.711 I.618 J-2.807 E.10431
G3 X194.36 Y158.498 I14.88 J10.688 E.09723
G3 X198.572 Y157.177 I3.543 J3.925 E.15258
G3 X199.976 Y158.101 I-.869 J2.848 E.0571
G2 X201.848 Y160.314 I14.881 J-10.689 E.09723
G2 X206.059 Y161.634 I3.543 J-3.925 E.15258
G2 X207.463 Y160.711 I-.869 J-2.849 E.0571
G3 X209.335 Y158.498 I14.879 J10.688 E.09723
G3 X213.547 Y157.177 I3.543 J3.925 E.15258
G3 X214.951 Y158.101 I-.869 J2.848 E.0571
G2 X216.823 Y160.314 I14.879 J-10.688 E.09723
G1 X217.759 Y160.996 E.03881
G1 X218.024 Y161.116 E.00974
G1 X218.814 Y158.324 E.09726
G1 X219.047 Y155.662 E.08953
G1 X218.888 Y153.845 E.06112
G3 X216.823 Y154.218 I-2.043 J-5.408 E.07071
G3 X214.951 Y153.223 I.226 J-2.683 E.07302
G2 X213.079 Y151.01 I-14.88 J10.689 E.09723
G2 X208.867 Y149.69 I-3.543 J3.925 E.15258
G2 X207.463 Y150.614 I.869 J2.848 E.0571
G3 X205.591 Y152.827 I-14.879 J-10.687 E.09723
G3 X201.38 Y154.147 I-3.543 J-3.925 E.15258
G3 X199.976 Y153.223 I.868 J-2.848 E.0571
G2 X198.104 Y151.01 I-14.878 J10.687 E.09723
G2 X193.892 Y149.69 I-3.543 J3.925 E.15258
G2 X192.488 Y150.614 I.869 J2.848 E.0571
G3 X190.616 Y152.827 I-14.878 J-10.687 E.09723
G3 X188.539 Y153.984 I-3.987 J-4.71 E.08019
G1 X188.625 Y153 E.0331
G1 X189.317 Y150.42 E.08953
G1 X190.446 Y147.998 E.08953
G1 X191.484 Y146.516 E.06065
G2 X192.488 Y145.735 I-1.555 J-3.037 E.04288
G3 X194.185 Y143.698 I15.479 J11.167 E.0889
G1 X195.62 Y142.693 E.05872
G3 X199.04 Y142.37 I2.071 J3.658 E.11858
G3 X199.976 Y143.126 I-1.392 J2.68 E.04059
G2 X201.848 Y145.339 I14.88 J-10.688 E.09723
G2 X206.059 Y146.659 I3.543 J-3.925 E.15258
G2 X207.463 Y145.735 I-.869 J-2.848 E.0571
G3 X209.335 Y143.522 I14.88 J10.688 E.09723
G3 X211.361 Y142.378 I4.091 J4.874 E.0784
G1 X209.885 Y141.689 E.05457
; WIPE_START
G1 F18423.913
G1 X210.791 Y142.112 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z3 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 14/82
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.379 Y155.662 F60000
G1 Z2.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5269
M204 S8000
G1 X219.141 Y158.381 E.09147
G1 X218.435 Y161.018 E.09147
G1 X217.281 Y163.492 E.09147
G1 X215.715 Y165.728 E.09147
G1 X213.785 Y167.658 E.09147
G1 X211.549 Y169.223 E.09147
G1 X209.075 Y170.377 E.09147
G1 X206.439 Y171.084 E.09147
G1 X203.72 Y171.321 E.09147
G1 X201 Y171.084 E.09147
G1 X198.364 Y170.377 E.09147
G1 X195.89 Y169.223 E.09147
G1 X193.654 Y167.658 E.09147
G1 X191.724 Y165.728 E.09147
G1 X190.158 Y163.492 E.09147
G1 X189.005 Y161.018 E.09147
G1 X188.298 Y158.381 E.09147
G1 X188.06 Y155.662 E.09147
G1 X188.298 Y152.943 E.09147
G1 X189.005 Y150.306 E.09147
G1 X190.158 Y147.832 E.09147
G1 X191.724 Y145.596 E.09147
G1 X193.654 Y143.666 E.09147
G1 X195.89 Y142.101 E.09147
G1 X198.364 Y140.947 E.09147
M73 P56 R5
G1 X201 Y140.241 E.09147
G1 X203.72 Y140.003 E.09147
G1 X206.326 Y140.231 E.08768
G1 X206.439 Y140.241 E.00379
G1 X209.075 Y140.947 E.09147
G1 X211.549 Y142.101 E.09147
G1 X213.785 Y143.666 E.09147
G1 X215.715 Y145.596 E.09147
G1 X217.281 Y147.832 E.09147
G1 X218.435 Y150.306 E.09147
G1 X219.112 Y152.834 E.08768
G1 X219.141 Y152.943 E.00379
G1 X219.374 Y155.602 E.08946
; COOLING_NODE: 0
M204 S10000
G1 X219.772 Y155.655 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5256
M204 S5000
G1 X219.773 Y155.662 E.00022
G1 X219.529 Y158.45 E.08686
G1 X218.804 Y161.152 E.08686
G1 X217.622 Y163.689 E.08686
G1 X216.017 Y165.981 E.08686
G1 X214.038 Y167.959 E.08686
G1 X211.746 Y169.564 E.08686
G1 X209.21 Y170.747 E.08686
G1 X206.507 Y171.471 E.08686
G1 X203.72 Y171.715 E.08686
G1 X200.932 Y171.471 E.08686
G1 X198.229 Y170.747 E.08686
G1 X195.693 Y169.564 E.08686
G1 X193.401 Y167.959 E.08686
G1 X191.422 Y165.981 E.08686
G1 X189.817 Y163.689 E.08686
G1 X188.635 Y161.152 E.08686
G1 X187.91 Y158.45 E.08686
G1 X187.667 Y155.662 E.08686
G1 X187.91 Y152.874 E.08686
G1 X188.635 Y150.172 E.08686
G1 X189.817 Y147.636 E.08686
G1 X191.422 Y145.343 E.08686
G1 X193.401 Y143.365 E.08686
G1 X195.693 Y141.76 E.08686
G1 X198.229 Y140.577 E.08686
G1 X200.932 Y139.853 E.08686
G1 X203.72 Y139.609 E.08686
G1 X206.36 Y139.84 E.08228
G1 X206.507 Y139.853 E.00458
G1 X209.21 Y140.577 E.08686
G1 X211.746 Y141.76 E.08686
G1 X214.038 Y143.365 E.08686
G1 X216.017 Y145.343 E.08686
G1 X217.622 Y147.636 E.08686
G1 X218.804 Y150.172 E.08686
G1 X219.491 Y152.732 E.08228
G1 X219.529 Y152.874 E.00458
G1 X219.767 Y155.595 E.08477
; WIPE_START
G1 F12000
M204 S8000
G1 X219.773 Y155.662 E-.02552
G1 X219.691 Y156.591 E-.35448
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.2 I-1.04 J-.632 P1  F60000
G1 X212.812 Y167.914 Z3.2
G1 Z2.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5269
M204 S8000
G2 X214.066 Y166.885 I-2.292 J-4.07 E.05464
G2 X210.271 Y164.75 I-4.576 J3.693 E.14946
G2 X207.463 Y165.865 I-.392 J3.104 E.10566
G3 X205.591 Y167.887 I-13.01 J-10.167 E.09244
G3 X201.38 Y168.906 I-3.163 J-3.862 E.1502
G3 X199.976 Y167.921 I1.345 J-3.412 E.058
G2 X198.104 Y165.899 I-13.01 J10.167 E.09244
G2 X193.892 Y164.881 I-3.163 J3.862 E.1502
G2 X192.426 Y165.938 I1.317 J3.371 E.0612
G1 X191.992 Y165.503 E.0206
G1 X190.461 Y163.317 E.08943
G1 X189.632 Y161.54 E.06569
G1 X189.68 Y161.549 E.00163
G2 X192.488 Y160.434 I.392 J-3.104 E.10566
G3 X194.36 Y158.412 I13.012 J10.168 E.09244
G3 X198.572 Y157.393 I3.163 J3.862 E.1502
G3 X199.976 Y158.378 I-1.345 J3.411 E.058
G2 X201.848 Y160.4 I13.011 J-10.167 E.09244
G2 X206.059 Y161.418 I3.163 J-3.862 E.1502
G2 X207.463 Y160.434 I-1.345 J-3.412 E.058
G3 X209.335 Y158.412 I13.012 J10.169 E.09244
G3 X213.547 Y157.393 I3.163 J3.862 E.1502
G3 X214.951 Y158.378 I-1.345 J3.412 E.058
G2 X216.823 Y160.4 I13.009 J-10.166 E.09244
G1 X217.759 Y161.009 E.03743
G1 X218.009 Y161.107 E.009
G1 X218.797 Y158.321 E.09702
G1 X219.029 Y155.662 E.08943
G1 X218.868 Y153.819 E.06201
G3 X216.823 Y154.041 I-1.603 J-5.214 E.06936
G3 X214.951 Y152.946 I.615 J-3.199 E.07409
G2 X213.079 Y150.924 I-13.012 J10.168 E.09244
G2 X208.867 Y149.906 I-3.163 J3.862 E.1502
G2 X207.463 Y150.89 I1.345 J3.412 E.058
G3 X205.591 Y152.912 I-13.012 J-10.168 E.09244
G3 X201.38 Y153.931 I-3.163 J-3.862 E.1502
G3 X199.976 Y152.946 I1.345 J-3.411 E.058
G2 X198.104 Y150.924 I-13.012 J10.168 E.09244
G2 X193.892 Y149.906 I-3.163 J3.862 E.1502
G2 X192.488 Y150.89 I1.345 J3.412 E.058
G3 X190.616 Y152.912 I-13.012 J-10.169 E.09244
G3 X188.562 Y153.92 I-3.617 J-4.774 E.07715
G1 X188.642 Y153.003 E.03084
G1 X189.333 Y150.426 E.08942
G1 X190.461 Y148.007 E.08943
G1 X191.841 Y146.036 E.08064
G2 X193.275 Y144.538 I-4.626 J-5.862 E.06972
G1 X193.879 Y143.934 E.02861
G1 X195.664 Y142.684 E.07303
G3 X199.04 Y142.624 I1.752 J3.592 E.11682
G3 X200.912 Y144.498 I-4.225 J6.091 E.08924
G2 X205.591 Y146.554 I4.279 J-3.387 E.17825
G2 X207.463 Y145.459 I-.615 J-3.199 E.07409
G3 X209.335 Y143.437 I13.011 J10.167 E.09244
G3 X211.406 Y142.426 I3.589 J4.724 E.07772
G1 X209.934 Y141.732 E.05455
; WIPE_START
G1 F18423.913
G1 X210.838 Y142.158 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z3.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 15/82
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.355 Y155.662 F60000
G1 Z3
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5239
M204 S8000
G1 X219.118 Y158.377 E.09133
G1 X218.412 Y161.01 E.09133
G1 X217.26 Y163.48 E.09133
G1 X215.697 Y165.712 E.09133
G1 X213.77 Y167.64 E.09133
G1 X211.537 Y169.203 E.09133
G1 X209.067 Y170.355 E.09133
G1 X206.435 Y171.06 E.09133
G1 X203.72 Y171.298 E.09133
G1 X201.004 Y171.06 E.09133
G1 X198.372 Y170.355 E.09133
G1 X195.902 Y169.203 E.09133
G1 X193.669 Y167.64 E.09133
G1 X191.742 Y165.712 E.09133
G1 X190.179 Y163.48 E.09133
G1 X189.027 Y161.01 E.09133
G1 X188.321 Y158.377 E.09133
G1 X188.084 Y155.662 E.09133
G1 X188.321 Y152.947 E.09133
G1 X189.027 Y150.314 E.09133
G1 X190.179 Y147.844 E.09133
G1 X191.742 Y145.612 E.09133
G1 X193.669 Y143.684 E.09133
G1 X195.902 Y142.121 E.09133
G1 X198.372 Y140.969 E.09133
G1 X201.004 Y140.264 E.09133
G1 X203.72 Y140.026 E.09133
G1 X206.435 Y140.264 E.09133
G1 X209.067 Y140.969 E.09133
G1 X211.537 Y142.121 E.09133
G1 X213.77 Y143.684 E.09133
G1 X215.697 Y145.612 E.09133
G1 X217.26 Y147.844 E.09133
G1 X218.412 Y150.314 E.09133
G1 X219.118 Y152.947 E.09133
G1 X219.35 Y155.602 E.08932
; COOLING_NODE: 0
M204 S10000
G1 X219.748 Y155.654 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5232
M204 S5000
G1 X219.749 Y155.662 E.00024
G1 X219.505 Y158.446 E.08673
G1 X218.782 Y161.144 E.08673
G1 X217.601 Y163.677 E.08673
G1 X215.999 Y165.965 E.08673
G1 X214.023 Y167.941 E.08673
G1 X211.734 Y169.544 E.08673
G1 X209.202 Y170.725 E.08673
G1 X206.503 Y171.448 E.08673
G1 X203.72 Y171.691 E.08673
G1 X200.936 Y171.448 E.08673
G1 X198.237 Y170.725 E.08673
G1 X195.705 Y169.544 E.08673
G1 X193.405 Y167.93 E.08721
G1 X191.441 Y165.965 E.08625
G1 X189.838 Y163.677 E.08673
G1 X188.657 Y161.144 E.08673
G1 X187.934 Y158.445 E.08673
G1 X187.69 Y155.662 E.08673
G1 X187.934 Y152.879 E.08673
G1 X188.657 Y150.18 E.08673
G1 X189.838 Y147.647 E.08673
G1 X191.44 Y145.359 E.08673
G1 X193.416 Y143.383 E.08673
G1 X195.705 Y141.78 E.08673
G1 X198.237 Y140.6 E.08673
G1 X200.936 Y139.876 E.08673
G1 X203.735 Y139.634 E.0872
G1 X206.503 Y139.876 E.08625
G1 X209.202 Y140.6 E.08673
G1 X211.734 Y141.78 E.08673
G1 X214.023 Y143.383 E.08673
G1 X215.999 Y145.359 E.08673
G1 X217.601 Y147.647 E.08673
G1 X218.782 Y150.18 E.08673
G1 X219.505 Y152.879 E.08673
G1 X219.743 Y155.594 E.08462
; WIPE_START
G1 F12000
M204 S8000
G1 X219.749 Y155.662 E-.02577
G1 X219.668 Y156.591 E-.35423
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.4 I-1.042 J-.628 P1  F60000
G1 X212.895 Y167.827 Z3.4
G1 Z3
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5239
M204 S8000
G2 X214.135 Y166.782 I-2.344 J-4.04 E.05464
G2 X210.271 Y164.845 I-4.247 J3.652 E.14869
G2 X207.463 Y166.11 I-.105 J3.516 E.10682
G3 X205.591 Y167.977 I-10.276 J-8.431 E.08874
G3 X201.38 Y168.71 I-2.843 J-3.871 E.14846
G3 X199.976 Y167.676 I1.891 J-4.038 E.0588
G2 X198.104 Y165.809 I-10.276 J8.431 E.08874
G2 X193.892 Y165.077 I-2.843 J3.871 E.14846
G2 X192.562 Y166.04 I1.813 J3.905 E.05537
G1 X192.01 Y165.488 E.02616
G1 X190.481 Y163.305 E.08929
G1 X189.614 Y161.446 E.06875
G1 X189.68 Y161.454 E.00223
G2 X192.488 Y160.189 I.105 J-3.516 E.10682
G3 X194.36 Y158.322 I10.277 J8.432 E.08874
G3 X198.572 Y157.589 I2.843 J3.871 E.14846
G3 X199.976 Y158.623 I-1.891 J4.038 E.0588
G2 X201.848 Y160.49 I10.277 J-8.432 E.08874
G2 X206.059 Y161.222 I2.843 J-3.871 E.14846
G2 X207.463 Y160.189 I-1.891 J-4.039 E.0588
G3 X209.335 Y158.322 I10.277 J8.433 E.08874
G3 X213.547 Y157.589 I2.843 J3.871 E.14847
G3 X214.951 Y158.623 I-1.891 J4.039 E.0588
G2 X216.823 Y160.49 I10.276 J-8.431 E.08874
G1 X217.759 Y161.031 E.03623
G1 X217.984 Y161.104 E.00793
G1 X218.084 Y160.89 E.00792
G1 X218.773 Y158.317 E.08929
G1 X219.006 Y155.662 E.08929
G1 X218.843 Y153.801 E.06261
G3 X214.951 Y152.701 I-1.104 J-3.53 E.14339
G2 X213.079 Y150.834 I-10.277 J8.432 E.08874
G2 X208.867 Y150.102 I-2.843 J3.871 E.14846
G2 X207.463 Y151.135 I1.891 J4.038 E.0588
G3 X205.591 Y153.002 I-10.277 J-8.432 E.08874
G3 X201.38 Y153.735 I-2.843 J-3.871 E.14846
G3 X199.976 Y152.701 I1.891 J-4.038 E.0588
G2 X198.104 Y150.834 I-10.277 J8.432 E.08874
G2 X193.892 Y150.102 I-2.843 J3.871 E.14846
G2 X192.488 Y151.135 I1.891 J4.038 E.0588
G3 X190.616 Y153.002 I-10.277 J-8.432 E.08874
G3 X188.59 Y153.868 I-3.276 J-4.861 E.07427
G1 X188.666 Y153.008 E.02896
G1 X189.355 Y150.434 E.08929
G1 X190.481 Y148.019 E.08929
G1 X192.01 Y145.836 E.08929
G1 X193.894 Y143.952 E.08929
G1 X195.738 Y142.661 E.07543
G3 X199.976 Y143.648 I1.435 J3.433 E.15575
G2 X201.848 Y145.515 I10.277 J-8.433 E.08874
G2 X206.059 Y146.247 I2.843 J-3.871 E.14846
M73 P57 R5
G2 X207.463 Y145.214 I-1.891 J-4.039 E.0588
G3 X209.335 Y143.347 I10.277 J8.433 E.08874
G3 X211.431 Y142.472 I3.169 J4.645 E.07663
G1 X209.962 Y141.771 E.05453
; WIPE_START
G1 F18423.913
G1 X210.865 Y142.202 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z3.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 16/82
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.302 Y155.662 F60000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5205
M204 S8000
G1 X219.065 Y158.368 E.09102
G1 X218.362 Y160.991 E.09102
G1 X217.214 Y163.453 E.09102
G1 X215.656 Y165.678 E.09102
G1 X215.532 Y165.802 E.00589
G1 X213.736 Y167.599 E.08513
G1 X211.511 Y169.156 E.09102
G1 X209.049 Y170.304 E.09102
G1 X206.425 Y171.007 E.09102
G1 X203.72 Y171.244 E.09102
G1 X201.014 Y171.007 E.09102
G1 X198.39 Y170.304 E.09102
G1 X195.929 Y169.156 E.09102
G1 X193.704 Y167.599 E.09102
G1 X191.783 Y165.678 E.09102
G1 X190.225 Y163.453 E.09102
G1 X189.077 Y160.991 E.09102
G1 X188.374 Y158.368 E.09102
G1 X188.138 Y155.662 E.09102
G1 X188.374 Y152.956 E.09102
G1 X189.077 Y150.333 E.09102
G1 X190.225 Y147.871 E.09102
G1 X191.783 Y145.646 E.09102
G1 X193.704 Y143.725 E.09102
G1 X195.929 Y142.168 E.09102
G1 X198.39 Y141.02 E.09102
G1 X201.014 Y140.317 E.09102
G1 X203.72 Y140.08 E.09102
G1 X203.895 Y140.095 E.00589
G1 X206.425 Y140.317 E.08513
G1 X209.049 Y141.02 E.09102
G1 X211.511 Y142.168 E.09102
G1 X213.736 Y143.726 E.09102
G1 X215.656 Y145.646 E.09102
G1 X217.214 Y147.871 E.09102
G1 X218.362 Y150.333 E.09102
G1 X219.065 Y152.956 E.09102
G1 X219.296 Y155.602 E.08901
; COOLING_NODE: 0
M204 S10000
G1 X219.695 Y155.656 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5205
M204 S5000
G1 X219.695 Y155.662 E.00019
G1 X219.452 Y158.436 E.08644
G1 X218.732 Y161.126 E.08644
G1 X217.555 Y163.65 E.08644
G1 X215.958 Y165.931 E.08644
G1 X215.809 Y166.08 E.00652
G1 X213.989 Y167.9 E.07992
G1 X211.707 Y169.497 E.08644
G1 X209.184 Y170.674 E.08644
G1 X206.494 Y171.395 E.08644
G1 X203.72 Y171.638 E.08644
G1 X200.945 Y171.395 E.08644
G1 X198.256 Y170.674 E.08644
G1 X195.732 Y169.497 E.08644
G1 X193.451 Y167.9 E.08644
G1 X191.482 Y165.931 E.08644
G1 X189.884 Y163.65 E.08644
G1 X189.796 Y163.459 E.00652
G1 X188.707 Y161.126 E.07992
G1 X187.987 Y158.436 E.08644
G1 X187.744 Y155.662 E.08644
G1 X187.987 Y152.888 E.08644
G1 X188.707 Y150.198 E.08644
G1 X189.884 Y147.674 E.08644
G1 X191.482 Y145.393 E.08644
G1 X193.451 Y143.424 E.08644
G1 X195.732 Y141.827 E.08644
G1 X198.256 Y140.65 E.08644
G1 X200.945 Y139.929 E.08644
G1 X203.72 Y139.686 E.08644
G1 X203.929 Y139.705 E.00652
G1 X206.494 Y139.929 E.07992
G1 X209.184 Y140.65 E.08644
G1 X211.707 Y141.827 E.08644
G1 X213.989 Y143.424 E.08644
G1 X215.958 Y145.393 E.08644
G1 X217.555 Y147.674 E.08644
G1 X218.732 Y150.198 E.08644
G1 X219.452 Y152.888 E.08644
G1 X219.689 Y155.596 E.08439
; WIPE_START
G1 F12000
M204 S8000
G1 X219.695 Y155.662 E-.02507
G1 X219.614 Y156.593 E-.35493
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.6 I-1.044 J-.625 P1  F60000
G1 X212.958 Y167.718 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5205
M204 S8000
G2 X214.185 Y166.657 I-2.396 J-4.01 E.05464
G2 X209.335 Y165.079 I-3.748 J3.279 E.17941
G2 X207.463 Y166.335 I1.589 J4.391 E.07629
G3 X205.591 Y168.072 I-8.243 J-7.004 E.08578
G3 X201.38 Y168.53 I-2.558 J-3.932 E.1473
G3 X199.976 Y167.452 I2.541 J-4.76 E.05959
G2 X198.104 Y165.714 I-8.244 J7.005 E.08578
G2 X193.892 Y165.256 I-2.558 J3.932 E.1473
G2 X192.715 Y166.117 I2.29 J4.367 E.04905
G1 X192.051 Y165.453 E.03147
G1 X190.528 Y163.278 E.08898
G1 X189.636 Y161.366 E.07072
G1 X189.68 Y161.368 E.00149
G2 X192.488 Y159.964 I-.226 J-3.96 E.10816
G3 X194.36 Y158.227 I8.244 J7.005 E.08578
G3 X198.572 Y157.769 I2.558 J3.932 E.1473
G3 X199.976 Y158.847 I-2.54 J4.76 E.05959
G2 X201.848 Y160.585 I8.244 J-7.005 E.08578
G2 X206.059 Y161.043 I2.558 J-3.932 E.1473
G2 X207.463 Y159.964 I-2.54 J-4.76 E.05959
G3 X209.335 Y158.227 I8.244 J7.005 E.08578
G3 X213.547 Y157.769 I2.558 J3.932 E.1473
G3 X214.951 Y158.847 I-2.541 J4.76 E.05959
G2 X216.823 Y160.585 I8.243 J-7.004 E.08578
G1 X217.925 Y161.105 E.04083
G1 X218.033 Y160.872 E.00862
G1 X218.721 Y158.307 E.08897
G1 X218.952 Y155.662 E.08898
G1 X218.789 Y153.796 E.06275
G1 X218.695 Y153.821 E.00326
G3 X214.951 Y152.477 I-.717 J-3.888 E.13968
G2 X213.079 Y150.739 I-8.244 J7.005 E.08578
G2 X208.867 Y150.281 I-2.558 J3.932 E.1473
G2 X207.463 Y151.36 I2.54 J4.76 E.05959
G3 X205.591 Y153.097 I-8.244 J-7.005 E.08578
G3 X201.38 Y153.555 I-2.558 J-3.932 E.1473
G3 X199.976 Y152.477 I2.54 J-4.76 E.05959
G2 X198.104 Y150.739 I-8.244 J7.005 E.08578
G2 X193.892 Y150.281 I-2.558 J3.932 E.1473
G2 X192.488 Y151.36 I2.54 J4.76 E.05959
G3 X190.616 Y153.097 I-8.244 J-7.005 E.08578
G3 X188.648 Y153.828 I-3.021 J-5.124 E.07074
G1 X188.719 Y153.017 E.02727
G1 X189.406 Y150.452 E.08897
G1 X190.528 Y148.046 E.08898
G1 X192.051 Y145.871 E.08898
G1 X193.928 Y143.993 E.08897
G1 X195.894 Y142.617 E.0804
G3 X199.976 Y143.872 I1.09 J3.722 E.15155
G2 X201.848 Y145.61 I8.244 J-7.005 E.08578
G2 X206.059 Y146.068 I2.558 J-3.932 E.1473
G2 X207.463 Y144.989 I-2.54 J-4.76 E.05959
G3 X209.335 Y143.252 I8.244 J7.005 E.08578
G3 X211.4 Y142.515 I2.844 J4.709 E.07395
G1 X209.931 Y141.815 E.05453
; WIPE_START
G1 F18423.913
G1 X210.834 Y142.245 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z3.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 17/82
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.248 Y155.662 F60000
G1 Z3.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5177
M204 S8000
G1 X219.012 Y158.359 E.0907
G1 X218.312 Y160.973 E.0907
G1 X217.168 Y163.426 E.09071
G1 X215.615 Y165.644 E.0907
G1 X213.701 Y167.558 E.09071
G1 X211.484 Y169.11 E.09071
G1 X211.148 Y169.267 E.01241
G1 X209.031 Y170.254 E.0783
G1 X206.416 Y170.955 E.0907
G1 X203.72 Y171.191 E.09071
G1 X201.023 Y170.955 E.0907
G1 X198.409 Y170.254 E.0907
G1 X195.955 Y169.11 E.09071
G1 X193.738 Y167.558 E.0907
G1 X191.824 Y165.644 E.09071
G1 X190.272 Y163.426 E.09071
G1 X190.115 Y163.091 E.01241
G1 X189.128 Y160.973 E.0783
G1 X188.427 Y158.359 E.09071
G1 X188.191 Y155.662 E.09071
G1 X188.427 Y152.966 E.0907
G1 X189.128 Y150.351 E.09071
G1 X189.284 Y150.015 E.01241
G1 X190.272 Y147.898 E.0783
G1 X191.824 Y145.681 E.0907
G1 X193.738 Y143.767 E.09071
G1 X195.955 Y142.214 E.09071
G1 X198.409 Y141.07 E.09071
G1 X201.023 Y140.37 E.0907
G1 X203.72 Y140.134 E.0907
G1 X204.088 Y140.166 E.01241
G1 X206.416 Y140.37 E.0783
G1 X209.031 Y141.07 E.0907
G1 X211.484 Y142.214 E.09071
G1 X213.701 Y143.767 E.0907
G1 X215.615 Y145.681 E.09071
G1 X217.168 Y147.898 E.09071
G1 X218.312 Y150.351 E.09071
G1 X219.012 Y152.966 E.0907
G1 X219.243 Y155.602 E.08869
; COOLING_NODE: 0
M204 S10000
G1 X219.641 Y155.658 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5177
M204 S5000
G1 X219.642 Y155.662 E.00013
G1 X219.4 Y158.427 E.08615
G1 X218.681 Y161.108 E.08615
G1 X217.508 Y163.623 E.08615
G1 X215.917 Y165.897 E.08615
G1 X213.954 Y167.859 E.08615
G1 X211.681 Y169.451 E.08615
G1 X209.165 Y170.624 E.08615
G1 X206.484 Y171.342 E.08615
G1 X203.72 Y171.584 E.08615
G1 X200.955 Y171.342 E.08615
G1 X198.274 Y170.624 E.08615
G1 X195.759 Y169.451 E.08615
G1 X193.485 Y167.859 E.08615
G1 X191.523 Y165.897 E.08615
G1 X189.931 Y163.623 E.08615
G1 X189.76 Y163.256 E.01256
G1 X188.758 Y161.108 E.07359
G1 X188.039 Y158.427 E.08615
G1 X187.798 Y155.662 E.08615
G1 X188.039 Y152.897 E.08615
G1 X188.758 Y150.216 E.08615
G1 X189.931 Y147.701 E.08615
G1 X191.523 Y145.428 E.08615
G1 X193.485 Y143.465 E.08615
G1 X195.759 Y141.873 E.08615
G1 X198.274 Y140.7 E.08615
G1 X200.955 Y139.982 E.08615
G1 X203.72 Y139.74 E.08615
G1 X204.123 Y139.775 E.01256
G1 X206.484 Y139.982 E.07359
G1 X209.165 Y140.7 E.08615
G1 X211.681 Y141.873 E.08615
G1 X213.954 Y143.465 E.08615
G1 X215.917 Y145.428 E.08615
G1 X217.508 Y147.701 E.08615
G1 X218.681 Y150.216 E.08615
G1 X219.4 Y152.897 E.08615
G1 X219.636 Y155.598 E.08416
; WIPE_START
G1 F12000
M204 S8000
G1 X219.642 Y155.662 E-.02438
G1 X219.56 Y156.594 E-.35562
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.8 I-1.046 J-.621 P1  F60000
G1 X213.021 Y167.608 Z3.8
G1 Z3.4
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5177
M204 S8000
G2 X214.235 Y166.531 I-2.448 J-3.98 E.05466
G2 X209.335 Y165.215 I-3.489 J3.211 E.17939
G1 X208.399 Y165.715 E.03555
G2 X206.527 Y167.474 I15.077 J17.921 E.08612
G3 X201.848 Y168.571 I-3.29 J-3.5 E.16869
G1 X200.912 Y168.072 E.03555
G3 X199.04 Y166.313 I15.077 J-17.921 E.08612
G2 X194.36 Y165.215 I-3.29 J3.5 E.16869
G2 X192.875 Y166.202 I1.311 J3.582 E.0603
G1 X192.092 Y165.419 E.03713
G1 X190.574 Y163.251 E.08866
G1 X189.68 Y161.293 E.07215
M73 P58 R5
G2 X192.488 Y159.753 I-.769 J-4.734 E.10941
G3 X195.296 Y157.713 I5.491 J4.604 E.11748
G3 X199.04 Y158.227 I1.336 J4.155 E.13097
G3 X200.912 Y159.986 I-15.08 J17.925 E.08612
G2 X205.591 Y161.084 I3.29 J-3.5 E.16869
G1 X206.527 Y160.584 E.03555
G2 X208.399 Y158.825 I-15.077 J-17.921 E.08612
G3 X213.079 Y157.728 I3.29 J3.5 E.16869
G1 X214.015 Y158.227 E.03555
G3 X215.887 Y159.986 I-15.078 J17.923 E.08612
G2 X217.859 Y161.119 I3.897 J-4.498 E.07669
G1 X217.983 Y160.853 E.00984
G1 X218.668 Y158.298 E.08866
G1 X218.898 Y155.662 E.08866
G1 X218.735 Y153.794 E.06283
G1 X218.695 Y153.803 E.00138
G3 X215.887 Y153.097 I-.386 J-4.401 E.09885
G3 X214.015 Y151.338 I15.078 J-17.923 E.08612
G2 X209.335 Y150.24 I-3.29 J3.5 E.16869
G1 X208.399 Y150.74 E.03555
G2 X206.527 Y152.499 I15.077 J17.921 E.08612
G3 X201.848 Y153.596 I-3.29 J-3.5 E.16869
G1 X200.912 Y153.097 E.03555
G3 X199.04 Y151.338 I15.077 J-17.921 E.08612
G2 X194.36 Y150.24 I-3.29 J3.5 E.16869
G1 X193.424 Y150.74 E.03555
G2 X191.552 Y152.499 I15.077 J17.921 E.08612
G3 X188.703 Y153.803 I-3.297 J-3.439 E.10698
G1 X188.771 Y153.026 E.02612
G1 X189.456 Y150.471 E.08866
G1 X190.574 Y148.073 E.08866
G1 X192.092 Y145.905 E.08866
G1 X193.963 Y144.034 E.08866
G1 X196.029 Y142.588 E.08451
G3 X199.04 Y143.252 I.744 J3.786 E.1063
G3 X200.912 Y145.011 I-15.077 J17.921 E.08612
G2 X205.591 Y146.109 I3.29 J-3.5 E.16869
G1 X206.527 Y145.609 E.03555
G2 X208.399 Y143.85 I-15.077 J-17.921 E.08612
G3 X211.351 Y142.546 I3.265 J3.396 E.11036
G1 X209.879 Y141.85 E.05454
; WIPE_START
G1 F18423.913
G1 X210.783 Y142.278 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z3.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 18/82
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.194 Y155.662 F60000
G1 Z3.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5157
M204 S8000
G1 X218.959 Y158.349 E.09039
G1 X218.261 Y160.955 E.09039
G1 X217.121 Y163.4 E.0904
G1 X215.574 Y165.609 E.09039
G1 X213.667 Y167.516 E.09039
G1 X211.457 Y169.064 E.09039
G1 X210.945 Y169.302 E.01893
G1 X209.012 Y170.204 E.07146
G1 X206.407 Y170.902 E.09039
G1 X203.72 Y171.137 E.09039
G1 X201.032 Y170.902 E.09039
G1 X198.427 Y170.204 E.09039
G1 X195.982 Y169.064 E.0904
G1 X193.773 Y167.517 E.09039
G1 X191.865 Y165.609 E.09039
G1 X190.318 Y163.399 E.09039
G1 X190.079 Y162.888 E.01893
G1 X189.178 Y160.955 E.07146
G1 X188.48 Y158.349 E.09039
G1 X188.245 Y155.662 E.09039
G1 X188.48 Y152.975 E.09039
G1 X189.178 Y150.369 E.09039
G1 X189.417 Y149.857 E.01893
G1 X190.318 Y147.925 E.07146
G1 X191.865 Y145.715 E.09039
G1 X193.773 Y143.808 E.09039
G1 X195.982 Y142.26 E.09039
G1 X198.427 Y141.12 E.09039
G1 X201.032 Y140.422 E.09039
G1 X203.72 Y140.187 E.09039
G1 X204.282 Y140.236 E.01893
G1 X206.407 Y140.422 E.07146
G1 X209.012 Y141.12 E.09039
G1 X211.457 Y142.26 E.09039
G1 X213.667 Y143.808 E.09039
G1 X215.574 Y145.715 E.09039
G1 X217.121 Y147.925 E.09039
G1 X218.261 Y150.369 E.09039
G1 X218.959 Y152.975 E.09039
G1 X219.189 Y155.602 E.08838
; COOLING_NODE: 0
M204 S10000
G1 X219.588 Y155.66 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5157
M204 S5000
G1 X219.588 Y155.662 E.00007
G1 X219.347 Y158.418 E.08586
G1 X218.631 Y161.089 E.08586
G1 X217.462 Y163.596 E.08586
G1 X215.876 Y165.862 E.08586
G1 X213.92 Y167.818 E.08586
G1 X211.654 Y169.405 E.08586
G1 X211.111 Y169.658 E.0186
G1 X209.147 Y170.573 E.06726
G1 X206.475 Y171.289 E.08586
G1 X203.72 Y171.53 E.08586
G1 X200.964 Y171.289 E.08586
G1 X198.292 Y170.574 E.08586
G1 X195.785 Y169.405 E.08586
G1 X193.52 Y167.818 E.08586
G1 X191.564 Y165.862 E.08586
G1 X189.977 Y163.596 E.08586
G1 X189.724 Y163.053 E.0186
G1 X188.808 Y161.089 E.06726
G1 X188.092 Y158.418 E.08586
G1 X187.851 Y155.662 E.08586
G1 X188.092 Y152.907 E.08586
G1 X188.808 Y150.235 E.08586
G1 X189.977 Y147.728 E.08586
G1 X191.564 Y145.462 E.08586
G1 X193.52 Y143.506 E.08586
G1 X195.785 Y141.92 E.08586
G1 X198.292 Y140.751 E.08586
G1 X200.964 Y140.035 E.08586
G1 X203.72 Y139.794 E.08586
G1 X204.316 Y139.846 E.0186
G1 X206.475 Y140.035 E.06726
G1 X209.147 Y140.751 E.08586
G1 X211.654 Y141.92 E.08586
G1 X213.92 Y143.506 E.08586
G1 X215.875 Y145.462 E.08586
G1 X217.462 Y147.728 E.08586
G1 X218.631 Y150.235 E.08586
G1 X219.347 Y152.907 E.08586
G1 X219.583 Y155.6 E.08392
; WIPE_START
G1 F12000
M204 S8000
G1 X219.588 Y155.662 E-.02372
G1 X219.506 Y156.596 E-.35628
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4 I-1.049 J-.618 P1  F60000
G1 X213.087 Y167.497 Z4
G1 Z3.6
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5157
M204 S8000
G2 X214.287 Y166.404 I-2.501 J-3.949 E.05468
G2 X208.399 Y165.897 I-3.239 J3.174 E.21566
G2 X206.527 Y167.642 I37.582 J42.189 E.08577
G3 X200.912 Y167.89 I-2.961 J-3.341 E.20375
G3 X199.04 Y166.145 I37.591 J-42.199 E.08577
G2 X193.017 Y166.268 I-2.945 J3.318 E.22192
G1 X192.133 Y165.384 E.04187
G1 X190.621 Y163.225 E.08835
G1 X189.688 Y161.224 E.07397
G2 X191.552 Y160.403 I-.634 J-3.967 E.06903
G2 X193.424 Y158.658 I-37.591 J-42.199 E.08577
G3 X199.04 Y158.409 I2.961 J3.341 E.20375
G3 X200.912 Y160.154 I-37.601 J42.21 E.08577
G2 X206.527 Y160.403 I2.961 J-3.341 E.20375
G2 X208.399 Y158.658 I-37.591 J-42.199 E.08577
G3 X214.015 Y158.409 I2.961 J3.341 E.20375
G3 X215.887 Y160.154 I-37.592 J42.2 E.08577
G2 X217.786 Y161.149 I3.749 J-4.846 E.07223
G1 X217.933 Y160.835 E.01161
G1 X218.615 Y158.289 E.08835
G1 X218.845 Y155.662 E.08835
G1 X218.681 Y153.792 E.06292
G3 X215.887 Y152.915 I-.086 J-4.617 E.09986
G3 X214.015 Y151.17 I37.6 J-42.209 E.08577
G2 X208.399 Y150.921 I-2.961 J3.341 E.20375
G2 X206.527 Y152.667 I37.601 J42.21 E.08577
G3 X200.912 Y152.915 I-2.961 J-3.341 E.20375
G3 X199.04 Y151.17 I37.591 J-42.199 E.08577
G2 X193.424 Y150.921 I-2.961 J3.341 E.20375
G2 X191.552 Y152.667 I37.601 J42.21 E.08577
G3 X188.758 Y153.79 I-3.172 J-3.851 E.10252
G1 X188.824 Y153.036 E.02539
G1 X189.506 Y150.489 E.08835
G1 X190.621 Y148.099 E.08835
G1 X192.133 Y145.94 E.08835
G1 X193.997 Y144.075 E.08835
G1 X196.232 Y142.557 E.09054
G3 X199.04 Y143.434 I.095 J4.628 E.10032
G3 X200.912 Y145.179 I-37.591 J42.199 E.08577
G2 X206.527 Y145.427 I2.961 J-3.341 E.20375
G2 X208.399 Y143.682 I-37.601 J-42.21 E.08577
G3 X211.277 Y142.561 I2.958 J3.337 E.10568
G1 X209.801 Y141.872 E.05457
; WIPE_START
G1 F18423.913
G1 X210.707 Y142.295 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 19/82
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.141 Y155.662 F60000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5157
M204 S8000
G1 X218.907 Y158.34 E.09008
G1 X218.211 Y160.936 E.09008
G1 X217.075 Y163.373 E.09008
G1 X215.533 Y165.575 E.09008
G1 X214.996 Y166.112 E.02545
G1 X213.632 Y167.475 E.06463
G1 X211.43 Y169.017 E.09008
G1 X208.994 Y170.153 E.09008
G1 X206.397 Y170.849 E.09008
G1 X203.72 Y171.083 E.09008
G1 X201.042 Y170.849 E.09008
G1 X198.445 Y170.153 E.09008
G1 X196.009 Y169.017 E.09008
G1 X193.807 Y167.475 E.09008
G1 X193.27 Y166.938 E.02545
G1 X191.906 Y165.575 E.06463
G1 X190.364 Y163.373 E.09008
G1 X189.228 Y160.936 E.09008
G1 X188.533 Y158.34 E.09008
G1 X188.298 Y155.662 E.09008
G1 X188.533 Y152.984 E.09008
G1 X189.228 Y150.388 E.09008
G1 X189.549 Y149.699 E.02545
G1 X190.364 Y147.951 E.06463
G1 X191.906 Y145.749 E.09008
G1 X193.807 Y143.849 E.09008
G1 X196.009 Y142.307 E.09008
G1 X198.445 Y141.171 E.09008
G1 X201.042 Y140.475 E.09008
G1 X203.72 Y140.241 E.09008
G1 X204.476 Y140.307 E.02545
G1 X206.397 Y140.475 E.06463
G1 X208.994 Y141.171 E.09008
G1 X211.43 Y142.307 E.09008
G1 X213.632 Y143.849 E.09008
G1 X215.533 Y145.749 E.09008
G1 X217.075 Y147.951 E.09008
G1 X218.211 Y150.388 E.09008
G1 X218.907 Y152.984 E.09008
G1 X219.136 Y155.602 E.08807
; COOLING_NODE: 0
M204 S10000
G1 X219.534 Y155.661 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5157
M204 S5000
G1 X219.534 Y155.662 E.00002
G1 X219.294 Y158.408 E.08557
G1 X218.581 Y161.071 E.08557
G1 X217.416 Y163.569 E.08557
G1 X215.834 Y165.828 E.08557
G1 X215.273 Y166.389 E.02464
G1 X213.885 Y167.777 E.06093
G1 X211.627 Y169.358 E.08557
G1 X209.129 Y170.523 E.08557
G1 X206.466 Y171.237 E.08557
G1 X203.72 Y171.477 E.08557
G1 X200.973 Y171.237 E.08557
G1 X198.311 Y170.523 E.08557
G1 X195.812 Y169.358 E.08557
G1 X193.554 Y167.777 E.08557
G1 X192.993 Y167.216 E.02464
G1 X191.605 Y165.828 E.06093
G1 X190.023 Y163.569 E.08557
G1 X188.858 Y161.071 E.08557
G1 X188.145 Y158.408 E.08557
G1 X187.905 Y155.662 E.08557
G1 X188.145 Y152.916 E.08557
G1 X188.858 Y150.253 E.08557
M73 P59 R5
G1 X189.194 Y149.534 E.02464
G1 X190.023 Y147.755 E.06093
G1 X191.605 Y145.496 E.08557
G1 X193.554 Y143.547 E.08557
G1 X195.812 Y141.966 E.08557
G1 X198.311 Y140.801 E.08557
G1 X200.973 Y140.087 E.08557
G1 X203.72 Y139.847 E.08557
G1 X204.51 Y139.916 E.02464
G1 X206.466 Y140.087 E.06093
G1 X209.129 Y140.801 E.08557
G1 X211.627 Y141.966 E.08557
G1 X213.885 Y143.547 E.08557
G1 X215.834 Y145.496 E.08557
G1 X217.416 Y147.755 E.08557
G1 X218.581 Y150.253 E.08557
G1 X219.294 Y152.916 E.08557
G1 X219.529 Y155.602 E.08369
; WIPE_START
G1 F12000
M204 S8000
G1 X219.534 Y155.662 E-.02307
G1 X219.453 Y156.598 E-.35693
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.2 I.683 J-1.007 P1  F60000
G1 X197.757 Y141.876 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5157
M204 S8000
G1 X196.281 Y142.564 E.05457
G3 X199.04 Y143.608 I-.253 J4.836 E.10044
G2 X200.912 Y145.35 I99.526 J-105.032 E.0857
G2 X206.527 Y145.253 I2.749 J-3.475 E.20385
G3 X208.399 Y143.511 I99.526 J105.032 E.0857
G3 X211.255 Y142.61 I2.528 J3.035 E.10293
G1 X213.407 Y144.117 E.08804
G1 X215.265 Y145.974 E.08803
G1 X216.772 Y148.126 E.08804
G1 X217.882 Y150.507 E.08804
G1 X218.562 Y153.045 E.08803
G1 X218.627 Y153.782 E.02481
G3 X215.887 Y152.741 I.265 J-4.821 E.0998
G2 X214.015 Y150.998 I-99.467 J104.967 E.0857
G2 X208.399 Y151.095 I-2.749 J3.476 E.20385
G3 X206.527 Y152.838 I-99.526 J-105.032 E.0857
G3 X200.912 Y152.741 I-2.749 J-3.476 E.20385
G2 X199.04 Y150.998 I-99.526 J105.032 E.0857
G2 X193.424 Y151.095 I-2.749 J3.476 E.20385
G3 X191.552 Y152.838 I-99.526 J-105.032 E.0857
G3 X188.812 Y153.785 I-2.824 J-3.735 E.09877
G1 X188.648 Y155.662 E.06315
G1 X188.877 Y158.279 E.08804
G1 X189.557 Y160.817 E.08803
G1 X189.715 Y161.156 E.01254
G2 X191.552 Y160.229 I-.955 J-4.176 E.06965
G3 X193.424 Y158.486 I99.589 J105.1 E.0857
G3 X199.04 Y158.583 I2.749 J3.476 E.20385
G2 X200.912 Y160.326 I99.654 J-105.169 E.0857
G2 X206.527 Y160.229 I2.749 J-3.475 E.20385
G3 X208.399 Y158.486 I99.589 J105.1 E.0857
G3 X214.015 Y158.583 I2.749 J3.476 E.20385
G2 X215.887 Y160.326 I99.713 J-105.232 E.0857
G2 X217.711 Y161.185 I2.592 J-3.139 E.06827
G1 X216.772 Y163.198 E.07444
G1 X215.265 Y165.35 E.08804
G1 X214.341 Y166.274 E.0438
G2 X208.399 Y166.071 I-3.085 J3.242 E.21788
G3 X206.527 Y167.813 I-99.654 J-105.169 E.0857
G3 X200.912 Y167.716 I-2.749 J-3.475 E.20385
G2 X199.04 Y165.974 I-99.589 J105.1 E.0857
G2 X193.151 Y166.327 I-2.74 J3.576 E.21553
G1 X193.516 Y166.692 E.0173
G2 X194.345 Y167.427 I2.499 J-1.984 E.03732
; WIPE_START
G1 F18423.913
G1 X194.032 Y167.208 E-.14554
G1 X193.595 Y166.771 E-.23446
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z4.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 20/82
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.087 Y155.662 F60000
G1 Z4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5152
M204 S8000
G1 X218.854 Y158.331 E.08977
G1 X218.16 Y160.918 E.08976
G1 X217.028 Y163.346 E.08977
G1 X215.492 Y165.54 E.08977
G1 X213.598 Y167.434 E.08977
G1 X211.403 Y168.971 E.08977
G1 X208.976 Y170.103 E.08977
G1 X206.388 Y170.796 E.08976
G1 X203.72 Y171.03 E.08977
G1 X201.051 Y170.796 E.08977
G1 X198.464 Y170.103 E.08976
G1 X196.036 Y168.971 E.08977
G1 X193.841 Y167.434 E.08977
G1 X191.947 Y165.54 E.08977
G1 X190.411 Y163.346 E.08977
G1 X189.279 Y160.918 E.08977
G1 X189.032 Y159.997 E.03197
G1 X188.585 Y158.331 E.0578
G1 X188.352 Y155.662 E.08977
G1 X188.585 Y152.993 E.08977
G1 X188.832 Y152.072 E.03197
G1 X189.279 Y150.406 E.0578
G1 X190.411 Y147.978 E.08977
G1 X191.947 Y145.784 E.08977
G1 X193.841 Y143.89 E.08977
G1 X196.036 Y142.353 E.08977
G1 X198.464 Y141.221 E.08977
G1 X201.051 Y140.528 E.08976
G1 X203.72 Y140.294 E.08977
G1 X204.67 Y140.378 E.03197
G1 X206.388 Y140.528 E.0578
G1 X208.976 Y141.221 E.08976
G1 X211.403 Y142.353 E.08977
G1 X213.598 Y143.89 E.08976
G1 X215.492 Y145.784 E.08977
G1 X217.028 Y147.978 E.08977
G1 X218.16 Y150.406 E.08977
G1 X218.854 Y152.993 E.08977
G1 X219.082 Y155.602 E.08776
; COOLING_NODE: 0
M204 S10000
G1 X219.481 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5151
M204 S5000
G1 X219.241 Y158.399 E.08528
G1 X218.53 Y161.053 E.08528
G1 X217.369 Y163.543 E.08528
G1 X215.793 Y165.793 E.08528
G1 X213.851 Y167.736 E.08528
G1 X211.6 Y169.312 E.08528
G1 X209.11 Y170.473 E.08528
G1 X206.456 Y171.184 E.08528
G1 X203.72 Y171.423 E.08528
G1 X200.983 Y171.184 E.08528
G1 X198.329 Y170.473 E.08528
G1 X195.839 Y169.312 E.08528
G1 X193.588 Y167.736 E.08528
G1 X191.646 Y165.793 E.08528
G1 X190.07 Y163.543 E.08528
G1 X188.909 Y161.053 E.08528
G1 X188.653 Y160.098 E.03068
G1 X188.198 Y158.399 E.0546
G1 X187.958 Y155.662 E.08528
G1 X188.198 Y152.925 E.08528
G1 X188.454 Y151.97 E.03068
G1 X188.909 Y150.271 E.0546
G1 X190.07 Y147.781 E.08528
G1 X191.646 Y145.531 E.08528
G1 X193.588 Y143.588 E.08528
G1 X195.839 Y142.012 E.08528
G1 X198.329 Y140.851 E.08528
G1 X200.983 Y140.14 E.08528
G1 X203.72 Y139.901 E.08528
G1 X204.704 Y139.987 E.03068
G1 X206.456 Y140.14 E.0546
G1 X209.11 Y140.851 E.08528
G1 X211.6 Y142.012 E.08528
G1 X213.851 Y143.588 E.08528
G1 X215.793 Y145.531 E.08528
G1 X217.369 Y147.781 E.08528
G1 X218.53 Y150.271 E.08528
G1 X219.241 Y152.925 E.08528
G1 X219.476 Y155.602 E.08342
; WIPE_START
G1 F12000
M204 S8000
G1 X219.392 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.4 I.686 J-1.005 P1  F60000
G1 X197.854 Y141.89 Z4.4
G1 Z4
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5152
M204 S8000
G1 X196.378 Y142.578 E.05457
G3 X199.04 Y143.777 I-.659 J5.016 E.09924
G2 X200.912 Y145.528 I22.493 J-22.164 E.08593
G2 X206.527 Y145.084 I2.528 J-3.76 E.20371
G3 X208.399 Y143.333 I22.499 J22.171 E.08593
G3 X211.015 Y142.556 I2.489 J3.591 E.09299
G1 X213.373 Y144.158 E.09551
G1 X215.224 Y146.009 E.08772
G1 X216.726 Y148.153 E.08773
G1 X217.832 Y150.526 E.08773
G1 X218.509 Y153.054 E.08772
G1 X218.573 Y153.775 E.02426
G3 X215.887 Y152.572 I.643 J-5.033 E.10006
G2 X214.015 Y150.82 I-22.497 J22.168 E.08593
G2 X208.399 Y151.265 I-2.528 J3.76 E.20371
G3 X206.527 Y153.016 I-22.499 J-22.171 E.08593
G3 X200.912 Y152.572 I-2.528 J-3.76 E.20371
G2 X199.04 Y150.82 I-22.499 J22.171 E.08593
G2 X193.424 Y151.265 I-2.528 J3.76 E.20371
G3 X191.552 Y153.016 I-22.499 J-22.171 E.08593
G3 X188.865 Y153.794 I-2.508 J-3.633 E.0954
G1 X188.701 Y155.662 E.06283
G1 X188.93 Y158.27 E.08773
G1 X189.368 Y159.906 E.05677
G2 X189.744 Y161.092 I3.55 J-.473 E.04189
G2 X191.552 Y160.059 I-1.301 J-4.378 E.0704
G3 X193.424 Y158.308 I22.493 J22.164 E.08593
G3 X199.04 Y158.752 I2.528 J3.76 E.20371
G2 X200.912 Y160.504 I22.499 J-22.171 E.08593
G2 X206.527 Y160.059 I2.528 J-3.76 E.20371
G3 X208.399 Y158.308 I22.493 J22.164 E.08593
G3 X214.015 Y158.752 I2.528 J3.76 E.20371
G2 X215.887 Y160.504 I22.502 J-22.174 E.08593
G1 X216.823 Y161.028 E.03594
G1 X217.631 Y161.23 E.02791
G1 X216.726 Y163.171 E.07176
G1 X215.224 Y165.316 E.08773
G1 X214.399 Y166.14 E.03909
G1 X214.015 Y165.796 E.0173
G2 X208.399 Y166.24 I-2.528 J3.76 E.20371
G3 X206.527 Y167.991 I-22.496 J-22.168 E.08593
G3 X200.912 Y167.547 I-2.528 J-3.76 E.20371
G2 X199.04 Y165.796 I-22.496 J22.168 E.08593
G2 X193.28 Y166.38 I-2.528 J3.759 E.21046
G2 X194.489 Y167.463 I3.674 J-2.887 E.05466
; WIPE_START
G1 F18423.913
G1 X194.066 Y167.167 E-.19623
G1 X193.724 Y166.825 E-.18377
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z4.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 21/82
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X219.034 Y155.662 F60000
G1 Z4.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5140
M204 S8000
G1 X218.801 Y158.321 E.08945
G1 X218.11 Y160.9 E.08945
G1 X216.982 Y163.319 E.08945
G1 X215.451 Y165.506 E.08945
G1 X213.563 Y167.393 E.08945
G1 X211.377 Y168.924 E.08945
G1 X208.957 Y170.053 E.08945
G1 X206.379 Y170.743 E.08945
G1 X203.72 Y170.976 E.08945
G1 X201.06 Y170.743 E.08945
G1 X198.482 Y170.053 E.08945
G1 X196.063 Y168.924 E.08945
G1 X193.876 Y167.393 E.08945
G1 X191.988 Y165.506 E.08945
G1 X190.457 Y163.319 E.08945
G1 X189.329 Y160.9 E.08945
G1 X188.638 Y158.321 E.08945
G1 X188.405 Y155.662 E.08945
G1 X188.638 Y153.003 E.08945
G1 X189.329 Y150.424 E.08945
M73 P60 R5
G1 X190.457 Y148.005 E.08945
G1 X191.988 Y145.818 E.08945
G1 X193.876 Y143.931 E.08945
G1 X196.063 Y142.4 E.08945
G1 X198.482 Y141.271 E.08945
G1 X201.06 Y140.581 E.08945
G1 X203.72 Y140.348 E.08945
G1 X204.864 Y140.448 E.03849
G1 X206.379 Y140.581 E.05096
G1 X208.957 Y141.271 E.08945
G1 X211.377 Y142.4 E.08945
G1 X213.563 Y143.931 E.08945
G1 X215.451 Y145.818 E.08945
G1 X216.982 Y148.005 E.08945
G1 X218.11 Y150.424 E.08945
G1 X218.801 Y153.003 E.08945
G1 X219.028 Y155.602 E.08744
; COOLING_NODE: 0
M204 S10000
G1 X219.427 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5140
M204 S5000
G1 X219.189 Y158.39 E.08499
G1 X218.48 Y161.034 E.08499
G1 X217.323 Y163.516 E.08499
G1 X215.752 Y165.759 E.08499
G1 X213.816 Y167.695 E.08499
G1 X211.573 Y169.265 E.08499
G1 X209.092 Y170.422 E.08499
G1 X206.447 Y171.131 E.08499
G1 X203.72 Y171.37 E.08499
G1 X200.992 Y171.131 E.08499
G1 X198.347 Y170.422 E.08499
G1 X195.866 Y169.265 E.08499
G1 X193.623 Y167.695 E.08499
G1 X191.687 Y165.759 E.08499
G1 X190.116 Y163.516 E.08499
G1 X188.959 Y161.034 E.08499
G1 X188.251 Y158.39 E.08499
G1 X188.012 Y155.662 E.08499
G1 X188.251 Y152.934 E.08499
G1 X188.959 Y150.29 E.08499
G1 X190.116 Y147.808 E.08499
G1 X191.687 Y145.565 E.08499
G1 X193.623 Y143.629 E.08499
G1 X195.866 Y142.059 E.08499
G1 X198.347 Y140.902 E.08499
G1 X200.992 Y140.193 E.08499
G1 X203.72 Y139.954 E.08499
G1 X204.898 Y140.057 E.03672
G1 X206.447 Y140.193 E.04827
G1 X209.092 Y140.902 E.08499
G1 X211.573 Y142.059 E.08499
G1 X213.816 Y143.629 E.08499
G1 X215.752 Y145.565 E.08499
G1 X217.323 Y147.808 E.08499
G1 X218.48 Y150.29 E.08499
G1 X219.189 Y152.934 E.08499
G1 X219.422 Y155.602 E.08313
; WIPE_START
G1 F12000
M204 S8000
G1 X219.339 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.6 I.689 J-1.003 P1  F60000
G1 X197.946 Y141.906 Z4.6
G1 Z4.2
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5140
M204 S8000
G1 X196.471 Y142.594 E.05457
G3 X199.04 Y143.944 I-1.096 J5.204 E.09852
G2 X201.38 Y145.993 I8.634 J-7.499 E.10455
G2 X205.591 Y145.653 I1.771 J-4.312 E.14696
G2 X207.463 Y143.966 I-5.654 J-8.155 E.08467
G1 X208.399 Y143.145 E.04171
G3 X210.816 Y142.522 I2.037 J2.903 E.08545
G1 X211.202 Y142.702 E.01427
G1 X213.339 Y144.199 E.08741
G1 X215.183 Y146.043 E.08741
G1 X216.679 Y148.18 E.08741
G1 X217.782 Y150.544 E.08741
G1 X218.457 Y153.063 E.08741
G1 X218.519 Y153.77 E.02377
G3 X215.887 Y152.405 I1.051 J-5.244 E.10067
G2 X213.547 Y150.356 I-8.634 J7.499 E.10455
G2 X209.335 Y150.696 I-1.771 J4.312 E.14696
G2 X207.463 Y152.383 I5.653 J8.155 E.08467
G1 X206.527 Y153.204 E.04171
G3 X201.848 Y153.14 I-2.289 J-3.781 E.16528
G3 X199.976 Y151.453 I5.653 J-8.155 E.08467
G1 X199.04 Y150.633 E.04171
G2 X194.36 Y150.696 I-2.289 J3.781 E.16528
G2 X192.488 Y152.383 I5.653 J8.155 E.08467
G1 X191.552 Y153.204 E.04171
G3 X188.916 Y153.818 I-2.116 J-3.114 E.09278
G1 X188.755 Y155.662 E.06201
G1 X188.982 Y158.261 E.08741
G1 X189.658 Y160.78 E.08741
G1 X189.775 Y161.031 E.00929
G2 X191.552 Y159.892 I-1.668 J-4.559 E.07132
G3 X193.892 Y157.843 I8.634 J7.498 E.10455
G3 X198.104 Y158.184 I1.771 J4.312 E.14696
G3 X199.976 Y159.871 I-5.653 J8.155 E.08467
G1 X200.912 Y160.691 E.04171
G2 X205.591 Y160.628 I2.289 J-3.781 E.16528
G2 X207.463 Y158.941 I-5.653 J-8.155 E.08467
G1 X208.399 Y158.121 E.04171
G3 X213.079 Y158.184 I2.289 J3.781 E.16528
G3 X214.951 Y159.871 I-5.653 J8.155 E.08467
G1 X215.887 Y160.691 E.04171
G2 X217.542 Y161.294 I2 J-2.92 E.05966
G1 X216.679 Y163.144 E.06843
G1 X215.183 Y165.281 E.08741
G1 X214.463 Y166.001 E.03412
G2 X210.271 Y165.223 I-2.721 J2.979 E.15053
G2 X208.399 Y166.407 I1.722 J4.793 E.07483
G3 X206.059 Y168.456 I-8.635 J-7.5 E.10455
G3 X201.848 Y168.116 I-1.771 J-4.312 E.14696
G3 X199.976 Y166.429 I5.653 J-8.155 E.08467
G1 X199.04 Y165.608 E.04171
G2 X194.36 Y165.671 I-2.289 J3.781 E.16528
G2 X193.403 Y166.428 I2.479 J4.117 E.04099
G2 X194.627 Y167.494 I3.633 J-2.936 E.05464
; WIPE_START
G1 F18423.913
G1 X194.101 Y167.125 E-.24405
G1 X193.848 Y166.872 E-.13595
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z4.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 22/82
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.98 Y155.662 F60000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5134
M204 S8000
G1 X218.748 Y158.312 E.08914
G1 X218.06 Y160.881 E.08914
G1 X216.936 Y163.292 E.08914
G1 X215.41 Y165.471 E.08914
G1 X213.529 Y167.352 E.08914
G1 X212.429 Y168.123 E.04501
G1 X211.35 Y168.878 E.04413
G1 X208.939 Y170.002 E.08914
G1 X206.37 Y170.691 E.08914
G1 X203.72 Y170.923 E.08914
G1 X201.07 Y170.691 E.08914
G1 X198.5 Y170.002 E.08914
G1 X196.089 Y168.878 E.08914
G1 X193.91 Y167.352 E.08914
G1 X192.029 Y165.471 E.08914
G1 X191.259 Y164.371 E.04501
G1 X190.504 Y163.292 E.04413
G1 X189.379 Y160.881 E.08914
G1 X188.691 Y158.312 E.08914
G1 X188.459 Y155.662 E.08914
G1 X188.691 Y153.012 E.08914
G1 X189.379 Y150.443 E.08914
G1 X190.504 Y148.032 E.08914
G1 X192.029 Y145.853 E.08914
G1 X193.91 Y143.972 E.08914
G1 X196.089 Y142.446 E.08914
G1 X198.5 Y141.322 E.08914
G1 X201.07 Y140.633 E.08914
G1 X203.72 Y140.402 E.08914
G1 X205.058 Y140.519 E.04501
G1 X206.37 Y140.633 E.04413
G1 X208.939 Y141.322 E.08914
G1 X211.35 Y142.446 E.08914
G1 X213.529 Y143.972 E.08914
G1 X215.41 Y145.853 E.08914
G1 X216.936 Y148.032 E.08914
G1 X218.06 Y150.443 E.08914
G1 X218.407 Y151.74 E.04501
G1 X218.748 Y153.012 E.04413
G1 X218.975 Y155.602 E.08713
; COOLING_NODE: 0
M204 S10000
G1 X219.374 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5134
M204 S5000
G1 X219.136 Y158.38 E.0847
G1 X218.43 Y161.016 E.0847
G1 X217.276 Y163.489 E.0847
G1 X215.711 Y165.724 E.0847
G1 X213.782 Y167.654 E.0847
G1 X212.653 Y168.444 E.04276
G1 X211.547 Y169.219 E.04194
G1 X209.074 Y170.372 E.0847
G1 X206.438 Y171.078 E.0847
G1 X203.72 Y171.316 E.0847
G1 X201.001 Y171.078 E.0847
G1 X198.366 Y170.372 E.0847
G1 X195.893 Y169.219 E.0847
G1 X193.657 Y167.654 E.0847
G1 X191.728 Y165.724 E.0847
G1 X190.938 Y164.596 E.04276
G1 X190.163 Y163.489 E.04194
G1 X189.01 Y161.016 E.0847
G1 X188.303 Y158.38 E.0847
G1 X188.065 Y155.662 E.0847
G1 X188.303 Y152.944 E.0847
G1 X189.01 Y150.308 E.0847
G1 X190.163 Y147.835 E.0847
G1 X191.728 Y145.6 E.0847
G1 X193.657 Y143.67 E.0847
G1 X195.893 Y142.105 E.0847
G1 X198.366 Y140.952 E.0847
G1 X201.001 Y140.246 E.0847
G1 X203.72 Y140.008 E.0847
G1 X205.092 Y140.128 E.04276
G1 X206.438 Y140.246 E.04194
G1 X209.074 Y140.952 E.0847
G1 X211.547 Y142.105 E.0847
G1 X213.782 Y143.67 E.0847
G1 X215.711 Y145.6 E.0847
G1 X217.276 Y147.835 E.0847
G1 X218.43 Y150.308 E.0847
G1 X219.136 Y152.944 E.0847
G1 X219.368 Y155.602 E.08284
; WIPE_START
G1 F12000
M204 S8000
G1 X219.285 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.8 I.582 J-1.069 P1  F60000
G1 X195.197 Y143.496 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5134
M204 S8000
G1 X196.264 Y142.749 E.04365
G1 X196.559 Y142.611 E.01092
G3 X199.04 Y144.112 I-1.567 J5.389 E.09827
G2 X200.912 Y145.917 I8.461 J-6.906 E.08733
G2 X204.656 Y146.068 I2.027 J-3.753 E.12999
G2 X206.527 Y144.749 I-2.149 J-5.038 E.07731
G3 X208.399 Y142.945 I8.461 J6.905 E.08733
G3 X210.526 Y142.446 I1.763 J2.734 E.07466
G1 X211.175 Y142.749 E.02399
G1 X213.304 Y144.24 E.0871
G1 X215.142 Y146.077 E.08709
G1 X216.633 Y148.207 E.0871
G1 X217.731 Y150.562 E.0871
G1 X218.071 Y151.83 E.04399
G3 X218.465 Y153.767 I-5.295 J2.085 E.06657
G3 X215.887 Y152.236 I1.487 J-5.441 E.10168
G2 X214.015 Y150.432 I-8.461 J6.906 E.08733
G2 X210.271 Y150.281 I-2.027 J3.753 E.12999
G2 X208.399 Y151.6 I2.149 J5.038 E.07731
G3 X206.527 Y153.404 I-8.461 J-6.905 E.08733
G3 X202.784 Y153.555 I-2.027 J-3.752 E.12999
G3 X200.912 Y152.236 I2.149 J-5.038 E.07731
G2 X199.04 Y150.432 I-8.461 J6.906 E.08733
G2 X195.296 Y150.281 I-2.027 J3.753 E.12999
G2 X193.424 Y151.6 I2.149 J5.038 E.07731
G3 X191.552 Y153.404 I-8.461 J-6.905 E.08733
G3 X188.967 Y153.858 I-1.877 J-3.103 E.09001
G1 X188.809 Y155.662 E.0607
G1 X189.035 Y158.251 E.0871
G1 X189.807 Y160.974 E.09483
G2 X191.552 Y159.724 I-2.05 J-4.707 E.07247
G3 X193.424 Y157.92 I8.46 J6.905 E.08733
G3 X197.168 Y157.769 I2.027 J3.752 E.12999
G3 X199.04 Y159.088 I-2.149 J5.038 E.07731
G2 X200.912 Y160.892 I8.461 J-6.905 E.08733
G2 X204.656 Y161.043 I2.027 J-3.753 E.12999
G2 X206.527 Y159.724 I-2.149 J-5.038 E.07731
G3 X208.399 Y157.92 I8.46 J6.904 E.08733
G3 X212.143 Y157.769 I2.027 J3.752 E.12999
G3 X214.015 Y159.088 I-2.149 J5.038 E.07731
G2 X215.887 Y160.892 I8.46 J-6.905 E.08733
G2 X217.444 Y161.377 I1.691 J-2.686 E.05529
G1 X216.633 Y163.117 E.06435
G1 X215.142 Y165.247 E.0871
G1 X214.557 Y165.832 E.02774
M73 P61 R5
G2 X211.207 Y164.976 I-2.513 J2.853 E.12027
G2 X208.399 Y166.575 I1.346 J5.627 E.10974
G3 X206.527 Y168.379 I-8.462 J-6.906 E.08733
G3 X202.784 Y168.531 I-2.027 J-3.753 E.12999
G3 X200.912 Y167.212 I2.149 J-5.038 E.07731
G2 X199.04 Y165.407 I-8.461 J6.905 E.08733
G2 X195.296 Y165.256 I-2.027 J3.752 E.12999
G2 X193.532 Y166.482 I1.985 J4.738 E.07251
G2 X194.771 Y167.53 I3.59 J-2.988 E.05464
; WIPE_START
G1 F18423.913
G1 X194.135 Y167.084 E-.29494
G1 X193.977 Y166.926 E-.08506
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z4.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 23/82
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.926 Y155.662 F60000
G1 Z4.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5132
M204 S8000
G1 X218.695 Y158.303 E.08883
G1 X218.009 Y160.863 E.08883
G1 X216.889 Y163.266 E.08883
G1 X215.369 Y165.437 E.08883
G1 X213.494 Y167.311 E.08883
G1 X212.235 Y168.193 E.05153
G1 X211.323 Y168.832 E.0373
G1 X208.921 Y169.952 E.08883
G1 X206.36 Y170.638 E.08883
G1 X203.72 Y170.869 E.08883
G1 X201.079 Y170.638 E.08883
G1 X198.519 Y169.952 E.08883
G1 X196.116 Y168.832 E.08883
G1 X193.945 Y167.311 E.08883
G1 X192.07 Y165.437 E.08883
G1 X190.55 Y163.266 E.08883
G1 X189.43 Y160.863 E.08883
G1 X188.744 Y158.303 E.08883
G1 X188.513 Y155.662 E.08883
G1 X188.744 Y153.021 E.08883
G1 X189.43 Y150.461 E.08883
G1 X190.55 Y148.059 E.08883
G1 X192.07 Y145.887 E.08883
G1 X193.945 Y144.013 E.08883
G1 X196.116 Y142.492 E.08883
G1 X198.519 Y141.372 E.08883
G1 X201.079 Y140.686 E.08883
G1 X203.72 Y140.455 E.08883
G1 X205.251 Y140.589 E.05153
G1 X206.36 Y140.686 E.0373
G1 X208.921 Y141.372 E.08883
G1 X211.323 Y142.492 E.08883
G1 X213.494 Y144.013 E.08883
G1 X215.369 Y145.887 E.08883
G1 X216.889 Y148.059 E.08883
G1 X218.009 Y150.461 E.08883
G1 X218.407 Y151.946 E.05153
G1 X218.695 Y153.021 E.0373
G1 X218.921 Y155.602 E.08682
; COOLING_NODE: 0
M204 S10000
G1 X219.32 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5132
M204 S5000
G1 X219.083 Y158.371 E.08441
G1 X218.379 Y160.998 E.08441
G1 X217.23 Y163.462 E.08441
G1 X215.67 Y165.69 E.08441
G1 X213.747 Y167.613 E.08441
G1 X212.46 Y168.514 E.0488
G1 X211.52 Y169.172 E.03561
G1 X209.055 Y170.322 E.08441
G1 X206.429 Y171.026 E.08441
G1 X203.72 Y171.263 E.08441
G1 X201.011 Y171.026 E.08441
G1 X198.384 Y170.322 E.08441
G1 X195.919 Y169.172 E.08441
G1 X193.692 Y167.613 E.08441
G1 X191.769 Y165.69 E.08441
G1 X190.209 Y163.462 E.08441
G1 X189.06 Y160.998 E.08441
G1 X188.356 Y158.371 E.08441
G1 X188.119 Y155.662 E.08441
G1 X188.356 Y152.953 E.08441
G1 X189.06 Y150.326 E.08441
G1 X190.209 Y147.862 E.08441
G1 X191.769 Y145.634 E.08441
G1 X193.692 Y143.711 E.08441
G1 X195.919 Y142.152 E.08441
G1 X198.384 Y141.002 E.08441
G1 X201.011 Y140.299 E.08441
G1 X203.72 Y140.062 E.08441
G1 X205.286 Y140.199 E.0488
G1 X206.429 Y140.299 E.03561
G1 X209.055 Y141.002 E.08441
G1 X211.52 Y142.152 E.08441
G1 X213.747 Y143.711 E.08441
G1 X215.67 Y145.634 E.08441
G1 X217.23 Y147.862 E.08441
G1 X218.379 Y150.326 E.08441
G1 X218.786 Y151.845 E.0488
G1 X219.083 Y152.953 E.03561
G1 X219.315 Y155.602 E.08255
; WIPE_START
G1 F12000
M204 S8000
G1 X219.231 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5 I.584 J-1.068 P1  F60000
G1 X195.278 Y143.505 Z5
G1 Z4.6
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5132
M204 S8000
G1 X196.291 Y142.795 E.04145
G1 X196.646 Y142.63 E.01311
G3 X199.04 Y144.285 I-2.077 J5.564 E.09854
G2 X200.912 Y146.135 I6.683 J-4.891 E.08856
G2 X203.72 Y146.381 I1.724 J-3.524 E.09661
G2 X206.527 Y144.576 I-1.77 J-5.841 E.1133
G3 X208.399 Y142.727 I6.683 J4.891 E.08856
G3 X210.163 Y142.336 I1.553 J2.834 E.06137
G1 X211.148 Y142.795 E.03641
G1 X213.27 Y144.281 E.08679
G1 X215.101 Y146.112 E.08678
G1 X216.586 Y148.233 E.08679
G1 X217.681 Y150.581 E.08679
G1 X218.071 Y152.036 E.05051
G3 X218.411 Y153.766 I-4.735 J1.829 E.05937
G3 X215.887 Y152.064 I1.95 J-5.613 E.10317
G2 X214.015 Y150.214 I-6.684 J4.892 E.08856
G2 X211.207 Y149.968 I-1.724 J3.524 E.09661
G2 X208.399 Y151.773 I1.77 J5.841 E.1133
G3 X206.527 Y153.622 I-6.684 J-4.892 E.08856
G3 X203.72 Y153.869 I-1.724 J-3.524 E.09661
G3 X200.912 Y152.064 I1.77 J-5.841 E.1133
G2 X199.04 Y150.214 I-6.683 J4.891 E.08856
G2 X196.232 Y149.968 I-1.724 J3.524 E.09661
G2 X193.424 Y151.773 I1.77 J5.841 E.1133
G3 X191.552 Y153.622 I-6.683 J-4.891 E.08856
G3 X189.015 Y153.912 I-1.645 J-3.15 E.08752
G1 X188.862 Y155.662 E.05887
G1 X189.088 Y158.242 E.08679
G1 X189.84 Y160.919 E.09318
G2 X191.552 Y159.551 I-2.437 J-4.807 E.07395
G3 X193.424 Y157.702 I6.683 J4.891 E.08856
G3 X196.232 Y157.455 I1.724 J3.524 E.09661
G3 X199.04 Y159.26 I-1.77 J5.841 E.1133
G2 X200.912 Y161.11 I6.683 J-4.891 E.08856
G2 X203.72 Y161.356 I1.724 J-3.524 E.09661
G2 X206.527 Y159.551 I-1.77 J-5.841 E.1133
G3 X208.399 Y157.702 I6.683 J4.891 E.08856
G3 X211.207 Y157.455 I1.724 J3.524 E.09661
G3 X214.015 Y159.26 I-1.77 J5.841 E.1133
G2 X215.887 Y161.11 I6.683 J-4.891 E.08856
G2 X217.336 Y161.484 I1.418 J-2.499 E.05073
G1 X216.586 Y163.091 E.05942
G1 X215.101 Y165.212 E.08679
G1 X214.639 Y165.675 E.02191
G2 X212.143 Y164.793 I-2.199 J2.251 E.09153
G2 X208.399 Y166.748 I.47 J5.462 E.14528
G3 X206.527 Y168.598 I-6.684 J-4.892 E.08856
G3 X203.72 Y168.844 I-1.724 J-3.524 E.09661
G3 X200.912 Y167.039 I1.77 J-5.841 E.1133
G2 X199.04 Y165.189 I-6.683 J4.891 E.08856
G2 X196.232 Y164.943 I-1.724 J3.524 E.09661
G2 X193.655 Y166.529 I1.643 J5.557 E.10259
G2 X194.907 Y167.56 I3.55 J-3.035 E.05464
; WIPE_START
G1 F18423.913
G1 X194.169 Y167.043 E-.3423
G1 X194.099 Y166.973 E-.0377
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z5 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 4.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 24/82
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.873 Y155.662 F60000
G1 Z4.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5137
M204 S8000
G1 X218.643 Y158.293 E.08851
G1 X217.959 Y160.845 E.08851
G1 X216.843 Y163.239 E.08852
G1 X215.328 Y165.402 E.08851
G1 X213.46 Y167.27 E.08851
G1 X211.296 Y168.785 E.08851
G1 X208.902 Y169.902 E.08852
G1 X206.351 Y170.585 E.08851
G1 X203.72 Y170.815 E.08851
G1 X201.088 Y170.585 E.08851
G1 X198.537 Y169.902 E.08851
G1 X196.143 Y168.785 E.08852
G1 X193.979 Y167.27 E.08851
G1 X192.111 Y165.402 E.08851
G1 X190.596 Y163.239 E.08851
G1 X189.48 Y160.845 E.08852
G1 X188.796 Y158.293 E.08851
G1 X188.566 Y155.662 E.08851
G1 X188.796 Y153.031 E.08851
G1 X189.48 Y150.479 E.08851
G1 X190.596 Y148.085 E.08852
G1 X192.111 Y145.922 E.08851
G1 X193.979 Y144.054 E.08851
G1 X196.143 Y142.539 E.08851
G1 X198.537 Y141.423 E.08852
G1 X201.088 Y140.739 E.08851
G1 X203.72 Y140.509 E.08851
G1 X205.445 Y140.66 E.05805
G1 X206.351 Y140.739 E.03046
G1 X208.902 Y141.423 E.08851
G1 X211.296 Y142.539 E.08852
G1 X213.46 Y144.054 E.08851
G1 X215.328 Y145.922 E.08851
G1 X216.843 Y148.085 E.08851
G1 X217.959 Y150.479 E.08852
G1 X218.643 Y153.031 E.08851
G1 X218.868 Y155.602 E.0865
; COOLING_NODE: 0
M204 S10000
G1 X219.266 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5137
M204 S5000
G1 X219.03 Y158.362 E.08412
G1 X218.329 Y160.979 E.08412
G1 X217.184 Y163.435 E.08412
G1 X215.629 Y165.655 E.08412
G1 X213.713 Y167.572 E.08412
G1 X211.493 Y169.126 E.08412
G1 X209.037 Y170.271 E.08412
G1 X206.419 Y170.973 E.08412
G1 X203.72 Y171.209 E.08412
G1 X201.02 Y170.973 E.08412
G1 X198.402 Y170.271 E.08412
G1 X195.946 Y169.126 E.08412
G1 X193.726 Y167.572 E.08412
G1 X191.81 Y165.655 E.08412
G1 X190.256 Y163.435 E.08412
G1 X189.11 Y160.979 E.08412
G1 X188.409 Y158.362 E.08412
G1 X188.173 Y155.662 E.08412
G1 X188.409 Y152.962 E.08412
G1 X189.11 Y150.345 E.08412
G1 X190.256 Y147.889 E.08412
G1 X191.81 Y145.669 E.08412
G1 X193.726 Y143.752 E.08412
G1 X195.946 Y142.198 E.08412
G1 X198.402 Y141.053 E.08412
G1 X201.02 Y140.351 E.08412
G1 X203.72 Y140.115 E.08412
G1 X205.479 Y140.269 E.05484
G1 X206.419 Y140.351 E.02928
G1 X209.037 Y141.053 E.08412
G1 X211.493 Y142.198 E.08412
G1 X213.713 Y143.752 E.08412
G1 X215.629 Y145.669 E.08412
G1 X217.184 Y147.889 E.08412
G1 X218.329 Y150.345 E.08412
G1 X219.03 Y152.962 E.08412
G1 X219.261 Y155.602 E.08226
; WIPE_START
G1 F12000
M204 S8000
G1 X219.178 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.2 I.586 J-1.067 P1  F60000
G1 X195.356 Y143.515 Z5.2
G1 Z4.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5137
M204 S8000
G3 X196.73 Y142.649 I3.14 J3.462 E.05468
G1 X197.168 Y142.836 E.01595
G3 X199.04 Y144.466 I-3.045 J5.385 E.08376
G2 X200.444 Y146.064 I7.657 J-5.315 E.07141
G2 X202.784 Y146.633 I1.815 J-2.365 E.08307
G2 X205.591 Y145.376 I-.951 J-5.89 E.10426
G3 X207.931 Y142.798 I285.641 J256.887 E.11667
G3 X209.786 Y142.219 I1.612 J1.906 E.06689
G1 X211.121 Y142.842 E.04936
M73 P62 R5
G1 X213.235 Y144.322 E.08648
G1 X215.06 Y146.146 E.08647
G1 X216.54 Y148.26 E.08648
G1 X217.631 Y150.599 E.08647
G1 X218.298 Y153.091 E.08647
G1 X218.358 Y153.768 E.02275
G3 X215.887 Y151.883 I2.429 J-5.745 E.10525
G2 X214.483 Y150.285 I-7.657 J5.315 E.07142
G2 X212.143 Y149.716 I-1.815 J2.365 E.08307
G2 X209.335 Y150.973 I.951 J5.89 E.10426
G3 X206.995 Y153.551 I-286.422 J-257.597 E.11667
G3 X204.656 Y154.12 I-1.815 J-2.365 E.08307
G3 X201.848 Y152.864 I.951 J-5.89 E.10426
G2 X199.508 Y150.285 I-286.171 J257.367 E.11667
G2 X197.168 Y149.716 I-1.815 J2.365 E.08307
G2 X194.36 Y150.973 I.951 J5.89 E.10426
G3 X192.02 Y153.551 I-285.864 J-257.09 E.11667
G3 X189.68 Y154.12 I-1.815 J-2.365 E.08307
G1 X189.063 Y153.982 E.02121
G1 X188.916 Y155.662 E.05651
G1 X189.141 Y158.233 E.08647
G1 X189.874 Y160.866 E.09161
G1 X190.616 Y160.351 E.03027
G3 X192.956 Y157.773 I285.664 J256.907 E.11667
G3 X195.296 Y157.204 I1.815 J2.365 E.08307
G3 X198.104 Y158.46 I-.951 J5.89 E.10426
G2 X200.444 Y161.039 I285.864 J-257.09 E.11667
G2 X202.784 Y161.608 I1.815 J-2.365 E.08307
G2 X205.591 Y160.351 I-.951 J-5.89 E.10426
G3 X207.931 Y157.773 I285.442 J256.704 E.11667
G3 X210.271 Y157.204 I1.815 J2.365 E.08307
G3 X213.079 Y158.46 I-.951 J5.89 E.10426
G2 X215.419 Y161.039 I285.864 J-257.09 E.11667
G2 X217.214 Y161.619 I1.602 J-1.89 E.06485
G1 X216.54 Y163.064 E.05344
G1 X215.06 Y165.178 E.08648
G1 X214.734 Y165.504 E.01546
G2 X212.143 Y164.691 I-2.067 J2.053 E.09465
G2 X209.335 Y165.948 I.951 J5.89 E.10426
G3 X206.995 Y168.526 I-286.73 J-257.875 E.11667
G3 X204.656 Y169.095 I-1.815 J-2.365 E.08307
G3 X201.848 Y167.839 I.951 J-5.89 E.10426
G2 X199.508 Y165.261 I-285.664 J256.907 E.11667
G2 X197.168 Y164.691 I-1.815 J2.365 E.08307
G2 X193.769 Y166.568 I.684 J5.256 E.1332
G2 X195.034 Y167.584 I3.514 J-3.079 E.05465
; WIPE_START
G1 F18423.913
G1 X194.215 Y167.01 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z5.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 25/82
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.819 Y155.662 F60000
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5153
M204 S8000
G1 X218.59 Y158.284 E.0882
G1 X217.909 Y160.826 E.0882
G1 X216.796 Y163.212 E.0882
G1 X215.287 Y165.368 E.0882
G1 X213.425 Y167.229 E.0882
G1 X211.847 Y168.334 E.06457
G1 X211.269 Y168.739 E.02363
G1 X208.884 Y169.851 E.0882
G1 X206.342 Y170.532 E.0882
G1 X203.72 Y170.762 E.0882
G1 X201.098 Y170.532 E.0882
G1 X198.555 Y169.851 E.0882
G1 X196.17 Y168.739 E.0882
G1 X194.014 Y167.229 E.0882
G1 X192.153 Y165.368 E.0882
G1 X191.047 Y163.79 E.06457
G1 X190.643 Y163.212 E.02363
G1 X189.53 Y160.826 E.0882
G1 X188.849 Y158.284 E.0882
G1 X188.62 Y155.662 E.0882
G1 X188.849 Y153.04 E.0882
G1 X189.53 Y150.498 E.0882
G1 X190.643 Y148.112 E.0882
G1 X192.153 Y145.956 E.0882
G1 X194.014 Y144.095 E.0882
G1 X196.17 Y142.585 E.0882
G1 X198.555 Y141.473 E.0882
G1 X201.098 Y140.792 E.0882
G1 X203.72 Y140.562 E.0882
G1 X205.639 Y140.73 E.06457
G1 X206.342 Y140.792 E.02363
G1 X208.884 Y141.473 E.0882
G1 X211.269 Y142.585 E.0882
G1 X213.425 Y144.095 E.0882
G1 X215.287 Y145.956 E.0882
G1 X216.796 Y148.112 E.0882
G1 X217.909 Y150.498 E.0882
G1 X218.59 Y153.04 E.0882
G1 X218.814 Y155.602 E.08619
; COOLING_NODE: 0
M204 S10000
G1 X219.213 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5153
M204 S5000
G1 X218.977 Y158.352 E.08383
G1 X218.279 Y160.961 E.08383
G1 X217.137 Y163.409 E.08383
G1 X215.588 Y165.621 E.08383
G1 X213.678 Y167.531 E.08383
G1 X212.072 Y168.655 E.06088
G1 X211.466 Y169.08 E.02296
G1 X209.019 Y170.221 E.08383
G1 X206.41 Y170.92 E.08383
G1 X203.72 Y171.155 E.08383
G1 X201.029 Y170.92 E.08383
G1 X198.421 Y170.221 E.08383
G1 X195.973 Y169.08 E.08383
G1 X193.761 Y167.531 E.08383
G1 X191.851 Y165.621 E.08383
G1 X190.726 Y164.014 E.06088
G1 X190.302 Y163.409 E.02296
G1 X189.161 Y160.961 E.08383
G1 X188.462 Y158.352 E.08383
G1 X188.226 Y155.662 E.08383
G1 X188.462 Y152.972 E.08383
G1 X189.161 Y150.363 E.08383
G1 X190.302 Y147.915 E.08383
G1 X191.851 Y145.703 E.08383
G1 X193.761 Y143.794 E.08383
G1 X195.973 Y142.244 E.08383
G1 X198.421 Y141.103 E.08383
G1 X201.029 Y140.404 E.08383
M73 P62 R4
G1 X203.72 Y140.169 E.08383
G1 X205.673 Y140.34 E.06088
G1 X206.41 Y140.404 E.02295
G1 X209.019 Y141.103 E.08383
G1 X211.466 Y142.244 E.08383
G1 X213.678 Y143.794 E.08383
G1 X215.588 Y145.703 E.08383
G1 X217.137 Y147.915 E.08383
G1 X218.279 Y150.363 E.08383
G1 X218.977 Y152.972 E.08383
G1 X219.208 Y155.602 E.08197
; WIPE_START
G1 F12000
M204 S8000
G1 X219.124 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.4 I.588 J-1.065 P1  F60000
G1 X195.434 Y143.526 Z5.4
G1 Z5
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5153
M204 S8000
G3 X196.813 Y142.67 I3.117 J3.482 E.05466
G1 X197.168 Y142.843 E.01325
G3 X199.04 Y144.662 I-4.007 J5.997 E.08795
G1 X199.976 Y145.911 E.0523
G2 X201.848 Y146.838 I1.897 J-1.478 E.0724
G2 X206.527 Y144.199 I-.249 J-5.91 E.18687
G1 X207.463 Y142.95 E.0523
G3 X209.258 Y142.031 I1.881 J1.462 E.06975
G1 X211.095 Y142.888 E.06792
G1 X213.201 Y144.363 E.08616
G1 X215.019 Y146.181 E.08615
G1 X216.494 Y148.287 E.08616
G1 X217.58 Y150.617 E.08616
G1 X218.246 Y153.101 E.08615
G1 X218.304 Y153.772 E.0226
G1 X217.759 Y153.505 E.02035
G3 X215.887 Y151.687 I4.007 J-5.996 E.08795
G1 X214.951 Y150.438 E.0523
G2 X213.079 Y149.511 I-1.897 J1.478 E.0724
G2 X208.399 Y152.15 I.249 J5.91 E.18687
G1 X207.463 Y153.399 E.0523
G3 X205.591 Y154.325 I-1.897 J-1.478 E.0724
G3 X200.912 Y151.687 I.249 J-5.91 E.18687
G1 X199.976 Y150.438 E.0523
G2 X198.104 Y149.511 I-1.897 J1.478 E.0724
G2 X193.424 Y152.15 I.249 J5.91 E.18687
G1 X192.488 Y153.399 E.0523
G3 X190.616 Y154.325 I-1.897 J-1.478 E.0724
G3 X189.109 Y154.069 I-.063 J-4.187 E.05153
G1 X188.969 Y155.662 E.0536
G1 X189.194 Y158.223 E.08616
G1 X189.91 Y160.815 E.09011
G2 X191.552 Y159.174 I-3.857 J-5.504 E.0782
G1 X192.488 Y157.925 E.0523
G3 X194.36 Y156.999 I1.897 J1.478 E.0724
G3 X199.04 Y159.637 I-.249 J5.91 E.18687
G1 X199.976 Y160.886 E.0523
G2 X201.848 Y161.813 I1.897 J-1.478 E.0724
G2 X206.527 Y159.174 I-.249 J-5.91 E.18687
G1 X207.463 Y157.925 E.0523
G3 X209.335 Y156.999 I1.897 J1.478 E.0724
G3 X214.015 Y159.637 I-.249 J5.91 E.18687
G1 X214.951 Y160.886 E.0523
G2 X217.076 Y161.788 I1.871 J-1.455 E.0808
G1 X216.494 Y163.037 E.04619
G1 X214.849 Y165.313 E.09411
G2 X213.079 Y164.487 I-1.758 J1.456 E.06764
G2 X208.399 Y167.125 I.249 J5.91 E.18687
G1 X207.463 Y168.374 E.0523
G3 X205.591 Y169.3 I-1.897 J-1.478 E.0724
G3 X200.912 Y166.662 I.249 J-5.91 E.18687
G1 X199.976 Y165.413 E.0523
G2 X198.104 Y164.487 I-1.897 J1.478 E.0724
G2 X193.855 Y166.578 I.137 J5.639 E.16377
G2 X195.128 Y167.584 I3.49 J-3.107 E.05466
; WIPE_START
G1 F18423.913
G1 X194.309 Y167.011 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z5.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 5.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 26/82
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.766 Y155.662 F60000
G1 Z5.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F9763
M204 S8000
G1 X218.537 Y158.275 E.08789
G1 X217.858 Y160.808 E.08789
G1 X216.75 Y163.185 E.08789
G1 X215.246 Y165.334 E.08789
G1 X213.391 Y167.188 E.08789
G1 X211.243 Y168.692 E.08789
G1 X208.866 Y169.801 E.08789
G1 X206.816 Y170.35 E.07109
G1 X206.332 Y170.48 E.0168
G1 X203.72 Y170.708 E.08789
G1 X201.107 Y170.48 E.08789
G1 X198.574 Y169.801 E.08789
G1 X196.196 Y168.692 E.08789
G1 X194.048 Y167.188 E.08789
G1 X192.194 Y165.334 E.08789
G1 X190.689 Y163.185 E.08789
G1 X189.581 Y160.808 E.08789
G1 X189.032 Y158.759 E.07109
G1 X188.902 Y158.275 E.0168
G1 X188.673 Y155.662 E.08789
G1 X188.902 Y153.049 E.08789
G1 X189.581 Y150.516 E.08789
G1 X190.689 Y148.139 E.08789
G1 X192.194 Y145.991 E.08789
G1 X194.048 Y144.136 E.08789
G1 X196.196 Y142.632 E.08789
G1 X198.574 Y141.523 E.08789
G1 X201.107 Y140.844 E.08789
G1 X203.72 Y140.616 E.08789
G1 X205.833 Y140.801 E.07109
G1 X206.332 Y140.844 E.0168
G1 X208.866 Y141.523 E.08789
G1 X211.243 Y142.632 E.08789
G1 X213.391 Y144.136 E.08789
G1 X215.246 Y145.991 E.08789
G1 X216.75 Y148.139 E.08789
G1 X217.646 Y150.062 E.07109
G1 X217.858 Y150.516 E.0168
G1 X218.537 Y153.049 E.08789
G1 X218.76 Y155.602 E.08588
; COOLING_NODE: 0
M204 S10000
G1 X219.159 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5350
M204 S5000
G1 X218.925 Y158.343 E.08354
G1 X218.228 Y160.943 E.08354
G1 X217.091 Y163.382 E.08354
G1 X215.547 Y165.587 E.08354
G1 X213.644 Y167.49 E.08354
G1 X211.439 Y169.033 E.08354
G1 X209 Y170.171 E.08354
G1 X206.401 Y170.867 E.08354
G1 X203.72 Y171.102 E.08354
G1 X201.038 Y170.867 E.08354
G1 X198.439 Y170.171 E.08354
G1 X196 Y169.033 E.08354
G1 X193.795 Y167.49 E.08354
G1 X191.892 Y165.587 E.08354
G1 X190.348 Y163.382 E.08354
G1 X189.211 Y160.943 E.08354
G1 X188.514 Y158.343 E.08354
G1 X188.28 Y155.662 E.08354
G1 X188.514 Y152.981 E.08354
G1 X189.211 Y150.381 E.08354
G1 X190.348 Y147.942 E.08354
G1 X191.892 Y145.738 E.08354
G1 X193.795 Y143.835 E.08354
M73 P63 R4
G1 X196 Y142.291 E.08354
G1 X198.439 Y141.153 E.08354
G1 X201.038 Y140.457 E.08354
G1 X203.72 Y140.222 E.08354
G1 X205.867 Y140.41 E.06692
G1 X206.401 Y140.457 E.01662
G1 X209 Y141.153 E.08354
G1 X211.439 Y142.291 E.08354
G1 X213.644 Y143.835 E.08354
G1 X215.547 Y145.738 E.08354
G1 X217.091 Y147.942 E.08354
G1 X218.228 Y150.381 E.08354
G1 X218.925 Y152.981 E.08354
G1 X219.154 Y155.602 E.08168
; WIPE_START
G1 F12000
M204 S8000
G1 X219.071 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.6 I1.05 J-.616 P1  F60000
G1 X211.051 Y142.924 Z5.6
G1 Z5.2
G1 E.4 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X213.167 Y144.403 E.07225
G1 X214.979 Y146.214 E.07171
G1 X216.449 Y148.313 E.07171
G1 X217.531 Y150.635 E.07171
G1 X218.195 Y153.11 E.0717
G1 X218.418 Y155.662 E.07171
G1 X218.197 Y158.195 E.07116
G1 X217.531 Y160.689 E.07224
G1 X216.449 Y163.011 E.07171
G1 X214.979 Y165.11 E.07171
G1 X213.167 Y166.922 E.07171
G1 X211.069 Y168.391 E.07171
G1 X208.747 Y169.474 E.07171
G1 X206.291 Y170.133 E.07116
G1 X203.72 Y170.36 E.07224
G1 X201.167 Y170.137 E.07171
G1 X198.693 Y169.474 E.0717
G1 X196.37 Y168.391 E.07171
G1 X194.272 Y166.922 E.07171
G1 X192.46 Y165.11 E.07171
G1 X190.991 Y163.011 E.07171
G1 X189.908 Y160.689 E.07171
G1 X189.249 Y158.233 E.07116
G1 X189.021 Y155.662 E.07224
G1 X189.245 Y153.11 E.07171
G1 X189.908 Y150.635 E.0717
G1 X190.99 Y148.313 E.07171
G1 X192.46 Y146.214 E.07171
G1 X194.272 Y144.403 E.07171
G1 X196.37 Y142.933 E.07171
G1 X198.693 Y141.85 E.07171
G1 X201.167 Y141.187 E.0717
G1 X203.739 Y140.965 E.07225
G1 X206.272 Y141.187 E.07117
G1 X208.747 Y141.85 E.0717
G1 X210.997 Y142.899 E.06949
; Slow Down End
M204 S10000
G1 X195.848 Y143.721 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F9763
M204 S8000
G3 X197.249 Y142.904 I3.016 J3.566 E.05464
G3 X199.04 Y144.882 I-5.805 J7.054 E.08972
G1 X199.976 Y146.28 E.05638
G2 X201.848 Y147.044 I1.612 J-1.276 E.07083
G2 X206.527 Y143.979 I-.659 J-6.112 E.19461
G1 X207.463 Y142.581 E.05638
G3 X208.114 Y142.038 I1.185 J.758 E.02885
G1 X208.628 Y142.176 E.01783
G1 X210.895 Y143.233 E.08383
G1 X212.945 Y144.668 E.08384
G1 X214.714 Y146.437 E.08383
G1 X216.149 Y148.486 E.08384
G1 X217.206 Y150.754 E.08383
G1 X217.853 Y153.17 E.08382
G1 X217.889 Y153.579 E.01378
G3 X215.887 Y151.467 I3.563 J-5.382 E.09838
G1 X214.951 Y150.069 E.05638
G2 X213.079 Y149.305 I-1.612 J1.276 E.07083
G2 X208.399 Y152.37 I.659 J6.112 E.19461
G1 X207.463 Y153.768 E.05638
G3 X205.591 Y154.531 I-1.612 J-1.276 E.07083
G3 X200.912 Y151.467 I.659 J-6.112 E.19461
G1 X199.976 Y150.069 E.05638
G2 X198.104 Y149.305 I-1.612 J1.276 E.07083
G2 X193.424 Y152.37 I.659 J6.112 E.19461
G1 X192.488 Y153.768 E.05638
G3 X190.616 Y154.531 I-1.612 J-1.276 E.07083
G3 X189.488 Y154.291 I.182 J-3.619 E.03883
G1 X189.368 Y155.662 E.04612
G1 X189.586 Y158.154 E.08384
G1 X190.23 Y160.558 E.08339
G2 X192.488 Y157.556 I-13.147 J-12.241 E.1261
G3 X194.36 Y156.793 I1.612 J1.276 E.07083
G3 X199.04 Y159.857 I-.659 J6.112 E.19461
G1 X199.976 Y161.255 E.05638
G2 X201.848 Y162.019 I1.612 J-1.276 E.07083
G2 X206.527 Y158.955 I-.659 J-6.112 E.19461
G1 X207.463 Y157.556 E.05638
G3 X209.335 Y156.793 I1.612 J1.276 E.07083
G3 X214.015 Y159.857 I-.659 J6.112 E.19461
G1 X214.951 Y161.255 E.05638
G2 X216.529 Y162.023 I1.506 J-1.09 E.06123
G1 X216.149 Y162.838 E.03014
G1 X214.744 Y164.844 E.08207
G2 X213.079 Y164.28 I-1.406 J1.412 E.061
G2 X208.399 Y167.345 I.659 J6.112 E.19461
G1 X207.463 Y168.743 E.05638
G3 X205.591 Y169.507 I-1.612 J-1.276 E.07083
G3 X200.912 Y166.442 I.659 J-6.112 E.19461
G1 X199.976 Y165.044 E.05638
G2 X198.104 Y164.28 I-1.612 J1.276 E.07083
G2 X194.173 Y166.335 I.612 J5.956 E.15225
G2 X195.456 Y167.33 I3.462 J-3.141 E.05468
; WIPE_START
G1 F18423.913
G1 X194.637 Y166.756 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z5.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 5.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 27/82
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.712 Y155.662 F60000
G1 Z5.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6518
M204 S8000
G1 X218.484 Y158.265 E.08757
G1 X217.808 Y160.79 E.08757
G1 X216.703 Y163.158 E.08758
G1 X215.205 Y165.299 E.08758
G1 X213.357 Y167.147 E.08757
G1 X211.459 Y168.475 E.07761
G1 X211.216 Y168.646 E.00997
G1 X208.847 Y169.75 E.08758
G1 X206.323 Y170.427 E.08757
G1 X203.72 Y170.655 E.08757
G1 X201.116 Y170.427 E.08758
G1 X198.592 Y169.75 E.08757
G1 X196.223 Y168.646 E.08758
G1 X194.083 Y167.147 E.08758
G1 X192.235 Y165.299 E.08757
G1 X190.736 Y163.158 E.08758
G1 X189.757 Y161.059 E.07761
G1 X189.631 Y160.79 E.00997
G1 X188.955 Y158.265 E.08757
G1 X188.727 Y155.662 E.08757
G1 X188.955 Y153.059 E.08757
G1 X189.631 Y150.534 E.08757
G1 X190.736 Y148.166 E.08758
G1 X192.235 Y146.025 E.08758
G1 X194.083 Y144.177 E.08757
G1 X196.223 Y142.678 E.08758
G1 X198.592 Y141.574 E.08758
G1 X201.116 Y140.897 E.08757
G1 X203.72 Y140.669 E.08757
G1 X206.027 Y140.871 E.07761
G1 X206.323 Y140.897 E.00996
G1 X208.847 Y141.574 E.08757
G1 X211.216 Y142.678 E.08758
G1 X213.357 Y144.177 E.08758
G1 X215.205 Y146.025 E.08757
G1 X216.703 Y148.166 E.08758
G1 X217.808 Y150.534 E.08758
G1 X218.407 Y152.771 E.07761
G1 X218.484 Y153.059 E.00997
G1 X218.707 Y155.602 E.08556
; COOLING_NODE: 0
M204 S10000
G1 X219.106 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5429
M204 S5000
G1 X218.872 Y158.334 E.08325
G1 X218.178 Y160.924 E.08325
G1 X217.044 Y163.355 E.08325
G1 X215.506 Y165.552 E.08325
G1 X213.61 Y167.448 E.08325
G1 X211.684 Y168.797 E.07296
G1 X211.413 Y168.987 E.0103
G1 X208.982 Y170.12 E.08325
G1 X206.391 Y170.814 E.08325
G1 X203.72 Y171.048 E.08325
G1 X201.048 Y170.814 E.08325
G1 X198.457 Y170.12 E.08325
G1 X196.027 Y168.987 E.08325
G1 X193.83 Y167.448 E.08325
G1 X191.933 Y165.552 E.08325
G1 X190.395 Y163.355 E.08325
G1 X189.261 Y160.924 E.08325
G1 X188.567 Y158.334 E.08325
G1 X188.333 Y155.662 E.08325
G1 X188.567 Y152.99 E.08325
G1 X189.261 Y150.4 E.08325
G1 X190.395 Y147.969 E.08325
G1 X191.933 Y145.772 E.08325
G1 X193.83 Y143.876 E.08325
G1 X196.027 Y142.337 E.08325
G1 X198.457 Y141.204 E.08325
G1 X201.048 Y140.51 E.08325
G1 X203.72 Y140.276 E.08325
G1 X206.061 Y140.481 E.07296
G1 X206.391 Y140.51 E.0103
G1 X208.982 Y141.204 E.08325
G1 X211.413 Y142.337 E.08325
G1 X213.61 Y143.876 E.08325
G1 X215.506 Y145.772 E.08325
G1 X217.044 Y147.969 E.08325
G1 X218.178 Y150.4 E.08325
G1 X218.872 Y152.99 E.08325
G1 X219.1 Y155.602 E.08139
M204 S10000
G1 X218.344 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F6518
M204 S8000
G1 X218.122 Y153.122 E.07135
G1 X217.462 Y150.66 E.07135
G1 X216.385 Y148.35 E.07135
G1 X214.908 Y146.246 E.07194
G1 X213.12 Y144.459 E.07075
G1 X211.032 Y142.997 E.07135
G1 X208.721 Y141.919 E.07135
G1 X206.259 Y141.259 E.07135
G1 X203.712 Y141.038 E.07155
G1 X201.18 Y141.259 E.07115
G1 X198.718 Y141.919 E.07135
G1 X196.407 Y142.997 E.07135
G1 X194.303 Y144.473 E.07194
G1 X192.516 Y146.261 E.07075
G1 X191.054 Y148.35 E.07135
G1 X189.977 Y150.66 E.07135
G1 X189.317 Y153.122 E.07135
G1 X189.095 Y155.662 E.07135
G1 X189.317 Y158.202 E.07135
G1 X189.977 Y160.664 E.07135
G1 X191.054 Y162.974 E.07135
G1 X192.531 Y165.078 E.07194
G1 X194.319 Y166.865 E.07076
G1 X196.407 Y168.327 E.07135
G1 X198.718 Y169.405 E.07135
G1 X201.18 Y170.065 E.07135
G1 X203.72 Y170.287 E.07135
G1 X206.259 Y170.065 E.07135
G1 X208.721 Y169.405 E.07135
G1 X211.032 Y168.327 E.07135
G1 X213.136 Y166.851 E.07194
G1 X214.923 Y165.063 E.07076
G1 X216.395 Y162.956 E.07194
G1 X217.469 Y160.644 E.07134
G1 X218.122 Y158.202 E.07076
G1 X218.339 Y155.722 E.06967
M204 S10000
G1 X195.926 Y143.779 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6518
M204 S8000
G3 X197.332 Y142.968 I3.001 J3.579 E.05463
G3 X199.508 Y146.018 I-5.802 J6.442 E.12655
G2 X200.444 Y147.204 I2.501 J-1.012 E.0513
G1 X200.912 Y147.345 E.01638
G2 X206.527 Y143.72 I-.186 J-6.449 E.23546
G3 X207.567 Y141.988 I8.435 J3.885 E.06782
G1 X208.596 Y142.263 E.03571
G1 X210.849 Y143.314 E.08329
G1 X212.885 Y144.739 E.08329
G1 X214.642 Y146.497 E.08328
G1 X216.068 Y148.533 E.08329
G1 X217.118 Y150.786 E.08329
G1 X217.761 Y153.186 E.08328
G1 X217.792 Y153.54 E.01192
G3 X215.419 Y150.331 I5.554 J-6.59 E.13499
G2 X214.483 Y149.145 I-2.501 J1.012 E.0513
G1 X214.015 Y149.004 E.01638
G2 X208.399 Y152.629 I.186 J6.449 E.23546
G3 X207.463 Y154.267 I-13.989 J-6.907 E.06326
G3 X206.527 Y154.833 I-1.064 J-.704 E.03787
G3 X200.912 Y151.207 I.186 J-6.449 E.23546
G2 X199.976 Y149.569 I-13.985 J6.905 E.06326
G2 X199.04 Y149.004 I-1.064 J.704 E.03787
G2 X193.424 Y152.629 I.186 J6.449 E.23546
G3 X192.488 Y154.267 I-13.985 J-6.905 E.06326
G3 X191.552 Y154.833 I-1.064 J-.704 E.03787
G3 X189.567 Y154.45 I.227 J-6.523 E.06802
M73 P64 R4
G1 X189.461 Y155.662 E.04076
G1 X189.678 Y158.138 E.08329
G1 X190.297 Y160.451 E.08023
G2 X192.02 Y157.818 I-9.211 J-7.908 E.10572
G3 X192.956 Y156.633 I2.501 J1.012 E.0513
G1 X193.424 Y156.491 E.01638
G3 X199.04 Y160.117 I-.186 J6.449 E.23546
G2 X199.976 Y161.755 I13.987 J-6.906 E.06326
G2 X200.912 Y162.32 I1.064 J-.704 E.03787
G2 X206.527 Y158.695 I-.186 J-6.449 E.23546
G3 X207.463 Y157.057 I13.989 J6.907 E.06326
G3 X208.399 Y156.491 I1.064 J.704 E.03787
G3 X214.015 Y160.117 I-.186 J6.449 E.23546
G2 X214.951 Y161.755 I13.989 J-6.907 E.06326
G2 X216.302 Y162.288 I1.107 J-.825 E.05127
G1 X216.068 Y162.791 E.01859
G1 X214.883 Y164.483 E.06921
G2 X214.015 Y163.979 I-.965 J.663 E.03477
G2 X208.399 Y167.605 I.186 J6.449 E.23546
G3 X207.273 Y169.415 I-6.759 J-2.949 E.07171
G3 X205.591 Y169.736 I-1.63 J-3.977 E.05774
G3 X200.912 Y166.182 I1.162 J-6.389 E.20433
G2 X199.976 Y164.544 I-13.985 J6.905 E.06326
G2 X199.04 Y163.979 I-1.064 J.704 E.03787
G2 X194.275 Y166.305 I.247 J6.551 E.18293
G1 X194.554 Y166.585 E.01326
G1 X195.564 Y167.292 E.04131
; WIPE_START
G1 F18423.913
G1 X194.745 Y166.718 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z5.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 28/82
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.659 Y155.662 F60000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6613
M204 S8000
G1 X218.432 Y158.256 E.08726
G1 X217.758 Y160.771 E.08726
G1 X216.657 Y163.132 E.08726
G1 X215.163 Y165.265 E.08726
G1 X213.322 Y167.106 E.08726
G1 X211.189 Y168.6 E.08726
G1 X208.829 Y169.7 E.08726
G1 X206.314 Y170.374 E.08726
G1 X203.72 Y170.601 E.08726
G1 X201.125 Y170.374 E.08726
G1 X198.61 Y169.7 E.08726
G1 X196.25 Y168.6 E.08726
G1 X194.117 Y167.106 E.08726
G1 X192.276 Y165.265 E.08726
G1 X190.782 Y163.132 E.08726
G1 X189.682 Y160.771 E.08726
G1 X189.008 Y158.256 E.08726
G1 X188.781 Y155.662 E.08726
G1 X189.008 Y153.068 E.08726
G1 X189.682 Y150.553 E.08726
G1 X190.782 Y148.193 E.08726
G1 X192.276 Y146.059 E.08726
G1 X194.117 Y144.218 E.08726
G1 X196.25 Y142.725 E.08726
G1 X198.61 Y141.624 E.08726
G1 X201.125 Y140.95 E.08726
G1 X203.72 Y140.723 E.08726
G1 X206.221 Y140.942 E.08413
G1 X206.314 Y140.95 E.00313
G1 X208.829 Y141.624 E.08726
G1 X211.189 Y142.725 E.08726
G1 X213.322 Y144.218 E.08726
G1 X215.163 Y146.059 E.08726
G1 X216.657 Y148.193 E.08726
G1 X217.758 Y150.553 E.08726
G1 X218.432 Y153.068 E.08726
G1 X218.653 Y155.602 E.08525
; COOLING_NODE: 0
M204 S10000
G1 X219.052 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5500
M204 S5000
G1 X218.819 Y158.325 E.08296
G1 X218.127 Y160.906 E.08296
G1 X216.998 Y163.328 E.08296
G1 X215.538 Y165.413 E.079
G1 X215.465 Y165.518 E.00397
G1 X213.575 Y167.407 E.08296
G1 X211.386 Y168.94 E.08296
G1 X208.964 Y170.07 E.08296
G1 X206.382 Y170.762 E.08296
G1 X203.72 Y170.995 E.08296
G1 X201.057 Y170.762 E.08296
G1 X198.476 Y170.07 E.08296
G1 X196.053 Y168.94 E.08296
G1 X193.969 Y167.481 E.079
G1 X193.864 Y167.407 E.00397
G1 X191.974 Y165.518 E.08296
G1 X190.441 Y163.328 E.08296
G1 X189.312 Y160.906 E.08296
G1 X188.62 Y158.325 E.08296
G1 X188.387 Y155.662 E.08296
G1 X188.62 Y153 E.08296
G1 X189.312 Y150.418 E.08296
G1 X190.441 Y147.996 E.08296
G1 X191.974 Y145.806 E.08296
G1 X193.864 Y143.917 E.08296
G1 X196.053 Y142.384 E.08296
G1 X198.476 Y141.254 E.08296
G1 X201.057 Y140.562 E.08296
G1 X203.72 Y140.33 E.08296
G1 X206.255 Y140.551 E.07899
G1 X206.382 Y140.562 E.00397
G1 X208.964 Y141.254 E.08296
G1 X211.386 Y142.384 E.08296
G1 X213.575 Y143.917 E.08296
G1 X215.465 Y145.806 E.08296
G1 X216.998 Y147.996 E.08296
G1 X218.127 Y150.418 E.08296
G1 X218.819 Y153 E.08296
G1 X219.047 Y155.602 E.0811
M204 S10000
G1 X218.271 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.407301
G1 F6613
M204 S8000
G1 X218.051 Y153.144 E.07581
G1 X217.384 Y150.664 E.07702
G1 X216.325 Y148.394 E.07513
G1 X214.872 Y146.316 E.07608
G1 X213.079 Y144.521 E.07608
G1 X211.003 Y143.065 E.07608
G1 X208.705 Y141.992 E.07608
G1 X206.255 Y141.334 E.07608
G1 X203.711 Y141.111 E.07661
G1 X201.202 Y141.331 E.07554
G1 X198.751 Y141.986 E.07608
G1 X196.452 Y143.056 E.07608
G1 X194.349 Y144.531 E.07703
G1 X192.579 Y146.302 E.07513
G1 X191.123 Y148.379 E.07608
G1 X190.049 Y150.677 E.07608
G1 X189.391 Y153.127 E.07608
G1 X189.169 Y155.653 E.07608
G1 X189.388 Y158.18 E.07607
G1 X190.043 Y160.63 E.07608
G1 X191.114 Y162.93 E.07608
G1 X192.588 Y165.032 E.07703
G1 X194.36 Y166.803 E.07513
G1 X196.437 Y168.259 E.07608
G1 X198.735 Y169.332 E.07608
G1 X201.184 Y169.99 E.07608
G1 X203.711 Y170.213 E.07608
G1 X206.237 Y169.993 E.07608
G1 X208.688 Y169.338 E.07608
G1 X210.987 Y168.268 E.07608
G1 X213.09 Y166.793 E.07703
G1 X214.86 Y165.022 E.07513
G1 X216.332 Y162.917 E.07703
G1 X217.4 Y160.617 E.07608
G1 X218.048 Y158.197 E.07513
G1 X218.266 Y155.722 E.07455
M204 S10000
G1 X196.003 Y143.838 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6613
M204 S8000
G3 X197.412 Y143.033 I2.986 J3.59 E.05464
G3 X199.04 Y145.477 I-5.14 J5.189 E.09908
G1 X199.976 Y147.789 E.08356
G2 X200.912 Y147.829 I.502 J-.762 E.03297
G2 X205.123 Y145.618 I-2.293 J-9.487 E.16102
G2 X206.527 Y143.384 I-6.21 J-5.461 E.0888
G1 X207.104 Y141.96 E.05149
G1 X208.564 Y142.351 E.05066
G1 X210.802 Y143.395 E.08274
G1 X212.825 Y144.811 E.08275
G1 X214.371 Y146.358 E.0733
G1 X214.951 Y147.789 E.05174
G1 X215.419 Y147.938 E.01646
G1 X215.521 Y147.914 E.00352
G1 X215.987 Y148.58 E.02722
G1 X217.031 Y150.817 E.08274
G1 X217.669 Y153.202 E.08273
G1 X217.694 Y153.483 E.00944
G3 X215.887 Y150.872 I4.919 J-5.336 E.10728
G1 X214.951 Y148.56 E.08356
G2 X214.015 Y148.52 I-.502 J.763 E.03297
G2 X209.803 Y150.731 I2.293 J9.487 E.16102
G2 X208.399 Y152.965 I6.211 J5.461 E.0888
G1 X207.463 Y155.276 E.08356
G3 X206.527 Y155.316 I-.502 J-.763 E.03297
G3 X202.316 Y153.106 I2.293 J-9.487 E.16102
G3 X200.912 Y150.872 I6.21 J-5.461 E.0888
G1 X199.976 Y148.56 E.08356
G2 X199.04 Y148.52 I-.502 J.763 E.03297
G2 X194.828 Y150.731 I2.293 J9.487 E.16102
G2 X193.424 Y152.965 I6.211 J5.461 E.0888
G1 X192.488 Y155.276 E.08356
G3 X191.552 Y155.316 I-.502 J-.762 E.03297
G3 X189.644 Y154.634 I6.221 J-20.402 E.06793
G1 X189.554 Y155.662 E.03458
G1 X189.77 Y158.122 E.08275
G1 X190.363 Y160.337 E.07685
G2 X191.552 Y158.359 I-6.363 J-5.171 E.07759
G1 X192.488 Y156.048 E.08356
G3 X193.424 Y156.008 I.502 J.763 E.03297
G3 X197.636 Y158.218 I-2.293 J9.487 E.16102
G3 X199.04 Y160.452 I-6.21 J5.461 E.0888
G1 X199.976 Y162.764 E.08356
G2 X200.912 Y162.804 I.502 J-.763 E.03297
G2 X205.123 Y160.593 I-2.293 J-9.487 E.16102
G2 X206.527 Y158.359 I-6.21 J-5.461 E.0888
G1 X207.463 Y156.048 E.08356
G3 X208.399 Y156.008 I.502 J.763 E.03297
G3 X212.611 Y158.218 I-2.293 J9.487 E.16102
G3 X214.015 Y160.452 I-6.21 J5.461 E.0888
G1 X214.951 Y162.764 E.08356
G2 X215.962 Y162.78 I.519 J-.816 E.03567
G1 X215.128 Y163.972 E.04876
G1 X214.951 Y163.535 E.01578
G2 X214.015 Y163.495 I-.502 J.763 E.03297
G2 X209.803 Y165.706 I2.293 J9.487 E.16102
G2 X207.91 Y169.148 I8.715 J7.035 E.13233
G1 X206.179 Y169.612 E.06004
G1 X204.903 Y169.724 E.04293
G3 X200.912 Y165.847 I2.144 J-6.201 E.19256
G1 X199.976 Y163.535 E.08356
G2 X199.04 Y163.495 I-.502 J.762 E.03297
G2 X194.828 Y165.706 I2.293 J9.487 E.16102
G1 X194.362 Y166.261 E.02428
G1 X194.614 Y166.513 E.01195
G1 X195.656 Y167.243 E.04262
; WIPE_START
G1 F18423.913
G1 X194.837 Y166.669 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 5.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 29/82
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.594 Y155.662 F60000
G1 Z5.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6455
M204 S8000
G1 X218.368 Y158.245 E.08688
G1 X217.697 Y160.749 E.08688
G1 X216.601 Y163.099 E.08688
G1 X215.114 Y165.223 E.08688
G1 X213.28 Y167.056 E.08688
G1 X211.157 Y168.543 E.08688
G1 X208.807 Y169.639 E.08689
G1 X206.302 Y170.31 E.08688
G1 X203.72 Y170.536 E.08688
G1 X201.137 Y170.31 E.08688
G1 X198.632 Y169.639 E.08688
G1 X196.282 Y168.543 E.08688
G1 X194.159 Y167.056 E.08688
G1 X192.325 Y165.223 E.08688
G1 X190.838 Y163.099 E.08688
G1 X189.742 Y160.749 E.08689
G1 X189.071 Y158.245 E.08688
G1 X188.845 Y155.662 E.08688
G1 X189.071 Y153.079 E.08688
G1 X189.742 Y150.575 E.08688
G1 X190.838 Y148.225 E.08689
G1 X192.325 Y146.101 E.08688
G1 X194.159 Y144.268 E.08688
G1 X196.283 Y142.781 E.08688
G1 X198.632 Y141.685 E.08688
G1 X201.137 Y141.014 E.08688
G1 X203.72 Y140.788 E.08688
G1 X206.302 Y141.014 E.08688
G1 X208.807 Y141.685 E.08688
G1 X211.157 Y142.781 E.08688
G1 X213.28 Y144.268 E.08688
G1 X215.114 Y146.101 E.08688
G1 X216.601 Y148.225 E.08688
G1 X217.697 Y150.575 E.08688
G1 X218.368 Y153.079 E.08688
G1 X218.588 Y155.602 E.08487
; COOLING_NODE: 0
M204 S10000
G1 X218.987 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5556
M204 S5000
G1 X218.755 Y158.313 E.08261
G1 X218.067 Y160.884 E.08261
G1 X216.942 Y163.296 E.08261
G1 X215.415 Y165.476 E.08261
G1 X213.533 Y167.358 E.08261
G1 X211.353 Y168.884 E.08261
G1 X208.941 Y170.009 E.08261
G1 X206.371 Y170.698 E.08261
G1 X203.72 Y170.93 E.08261
G1 X201.068 Y170.698 E.08261
G1 X198.498 Y170.009 E.08261
G1 X196.086 Y168.884 E.08261
G1 X193.906 Y167.358 E.08261
G1 X192.024 Y165.476 E.08261
G1 X190.497 Y163.296 E.08261
G1 X189.373 Y160.884 E.08261
G1 X188.684 Y158.313 E.08261
G1 X188.452 Y155.662 E.08261
G1 X188.693 Y152.976 E.0837
G1 X189.373 Y150.44 E.0815
G1 X190.497 Y148.028 E.08261
G1 X192.024 Y145.848 E.08261
G1 X193.906 Y143.966 E.08261
G1 X196.086 Y142.44 E.08261
G1 X198.498 Y141.315 E.08261
G1 X201.068 Y140.626 E.08261
G1 X203.755 Y140.397 E.0837
M73 P65 R4
G1 X206.371 Y140.626 E.0815
G1 X208.941 Y141.315 E.08261
G1 X211.353 Y142.44 E.08261
G1 X213.533 Y143.966 E.08261
G1 X215.415 Y145.848 E.08261
G1 X216.942 Y148.028 E.08261
G1 X218.067 Y150.44 E.08261
G1 X218.755 Y153.011 E.08261
G1 X218.982 Y155.602 E.08075
; WIPE_START
G1 F12000
M204 S8000
G1 X218.899 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.2 I.976 J-.727 P1  F60000
G1 X217.737 Y155.037 Z6.2
G1 Z5.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6455
M204 S8000
G1 X217.595 Y153.415 E.05457
G3 X215.713 Y149.11 I4.883 J-4.699 E.16078
G1 X215.88 Y148.588 E.01837
G1 X214.499 Y146.617 E.08065
G1 X214.047 Y146.164 E.02143
G3 X214.189 Y147.239 I-2.869 J.926 E.0365
G1 X214.07 Y147.706 E.01618
G1 X213.657 Y148.174 E.02092
G3 X211.964 Y149.11 I-8.456 J-13.292 E.06485
G2 X208.225 Y154.726 I2.841 J5.944 E.23735
G1 X208.344 Y155.194 E.01618
G1 X208.757 Y155.662 E.02092
G2 X210.45 Y156.598 I8.456 J-13.292 E.06485
G3 X214.189 Y162.214 I-2.841 J5.944 E.23735
G1 X214.07 Y162.682 E.01618
G1 X213.657 Y163.15 E.02092
G3 X211.964 Y164.086 I-8.459 J-13.296 E.06485
G2 X208.307 Y168.946 I2.841 J5.945 E.21187
G1 X206.163 Y169.52 E.07437
G1 X204.427 Y169.672 E.05841
G3 X200.738 Y164.086 I2.877 J-5.911 E.23537
G1 X200.857 Y163.618 E.01618
G1 X201.27 Y163.15 E.02092
G3 X202.962 Y162.214 I8.459 J13.296 E.06485
G2 X206.701 Y156.598 I-2.841 J-5.944 E.23735
G1 X206.583 Y156.13 E.01618
G1 X206.169 Y155.662 E.02092
G2 X204.477 Y154.726 I-8.459 J13.297 E.06485
G3 X200.738 Y149.11 I2.841 J-5.944 E.23735
G1 X200.857 Y148.642 E.01618
G1 X201.27 Y148.174 E.02092
G3 X202.962 Y147.239 I8.457 J13.294 E.06485
G2 X206.667 Y141.939 I-2.804 J-5.905 E.22666
G1 X206.163 Y141.804 E.01749
G1 X203.72 Y141.59 E.0822
G1 X201.276 Y141.804 E.0822
G1 X198.907 Y142.439 E.08219
G1 X197.494 Y143.098 E.05224
G3 X199.214 Y147.239 I-5.403 J4.671 E.15284
G1 X199.095 Y147.706 E.01618
G1 X198.682 Y148.174 E.02092
G3 X196.989 Y149.11 I-8.457 J-13.293 E.06485
G2 X193.25 Y154.726 I2.841 J5.945 E.23735
G1 X193.369 Y155.194 E.01618
G1 X193.782 Y155.662 E.02092
G2 X195.475 Y156.598 I8.457 J-13.293 E.06485
G3 X199.214 Y162.214 I-2.841 J5.945 E.23735
G1 X199.095 Y162.682 E.01618
G1 X198.682 Y163.15 E.02092
G3 X196.989 Y164.086 I-8.459 J-13.297 E.06485
G2 X194.458 Y166.226 I2.704 J5.764 E.11237
G1 X192.94 Y164.707 E.07196
G1 X191.533 Y162.698 E.0822
G1 X190.496 Y160.475 E.0822
G1 X190.427 Y160.217 E.00894
G2 X191.726 Y156.598 I-5.405 J-3.983 E.13068
G1 X191.607 Y156.13 E.01618
G1 X191.194 Y155.662 E.02092
G2 X189.72 Y154.839 I-7.436 J11.581 E.05663
G1 X189.862 Y153.216 E.05456
M204 S10000
G1 X217.972 Y153.149 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435623
G1 F6455
M204 S8000
G1 X217.322 Y150.722 E.08122
G1 X216.257 Y148.435 E.08155
G1 X214.812 Y146.368 E.08155
G1 X213.003 Y144.561 E.08265
G1 X210.964 Y143.134 E.08044
G1 X208.679 Y142.067 E.08155
G1 X206.242 Y141.412 E.08155
G1 X203.709 Y141.191 E.0822
G1 X201.217 Y141.409 E.08089
G1 X198.78 Y142.06 E.08154
G1 X196.493 Y143.124 E.08155
G1 X194.425 Y144.57 E.08155
G1 X192.619 Y146.379 E.08265
G1 X191.192 Y148.418 E.08044
G1 X190.124 Y150.703 E.08154
G1 X189.47 Y153.139 E.08155
G1 X189.248 Y155.652 E.08155
G1 X189.466 Y158.165 E.08154
G1 X190.117 Y160.602 E.08154
G1 X191.182 Y162.889 E.08155
G1 X192.627 Y164.956 E.08155
G1 X194.436 Y166.763 E.08264
G1 X196.475 Y168.19 E.08044
G1 X198.76 Y169.257 E.08155
G1 X201.197 Y169.912 E.08155
G1 X203.709 Y170.134 E.08155
G1 X206.222 Y169.915 E.08154
G1 X208.659 Y169.264 E.08154
G1 X210.947 Y168.2 E.08155
G1 X213.014 Y166.754 E.08155
G1 X214.82 Y164.945 E.08264
G1 X216.247 Y162.907 E.08044
G1 X217.326 Y160.589 E.08265
G1 X217.975 Y158.151 E.08154
G1 X218.191 Y155.672 E.08044
G1 X217.977 Y153.209 E.07993
; WIPE_START
G1 F12000
G1 X218.064 Y154.205 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z6.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 30/82
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.5 Y155.662 F60000
G1 Z6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F6208
M204 S8000
G1 X218.276 Y158.229 E.08634
G1 X217.609 Y160.717 E.08634
G1 X216.52 Y163.053 E.08634
G1 X215.042 Y165.163 E.08634
G1 X213.221 Y166.985 E.08634
G1 X211.11 Y168.463 E.08634
G1 X208.775 Y169.552 E.08634
G1 X206.286 Y170.218 E.08634
G1 X203.72 Y170.443 E.08634
G1 X201.153 Y170.218 E.08634
G1 X198.664 Y169.552 E.08634
G1 X196.329 Y168.463 E.08634
G1 X194.219 Y166.985 E.08634
G1 X192.397 Y165.163 E.08634
G1 X190.919 Y163.052 E.08634
G1 X189.83 Y160.717 E.08634
G1 X189.163 Y158.229 E.08634
G1 X188.939 Y155.662 E.08634
G1 X189.163 Y153.095 E.08634
G1 X189.83 Y150.607 E.08634
G1 X190.919 Y148.272 E.08634
G1 X192.397 Y146.161 E.08634
G1 X194.219 Y144.339 E.08634
G1 X196.329 Y142.861 E.08634
G1 X198.664 Y141.773 E.08634
G1 X201.153 Y141.106 E.08634
G1 X203.72 Y140.881 E.08634
G1 X203.911 Y140.898 E.00645
G1 X206.286 Y141.106 E.07988
G1 X208.775 Y141.773 E.08634
G1 X211.11 Y142.861 E.08634
G1 X213.221 Y144.339 E.08634
G1 X215.042 Y146.161 E.08634
G1 X216.52 Y148.272 E.08634
G1 X217.609 Y150.607 E.08634
G1 X218.276 Y153.095 E.08634
G1 X218.495 Y155.602 E.08433
; COOLING_NODE: 0
M204 S10000
G1 X218.894 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5595
M204 S5000
G1 X218.663 Y158.297 E.08211
G1 X217.979 Y160.852 E.0821
G1 X216.861 Y163.249 E.08211
G1 X215.344 Y165.416 E.0821
G1 X213.474 Y167.286 E.08211
G1 X211.307 Y168.804 E.08211
G1 X208.91 Y169.921 E.0821
G1 X208.69 Y169.98 E.00704
G1 X206.355 Y170.606 E.07506
G1 X203.72 Y170.836 E.0821
G1 X201.085 Y170.606 E.08211
G1 X198.53 Y169.921 E.0821
G1 X196.132 Y168.803 E.08211
G1 X193.966 Y167.286 E.0821
G1 X192.095 Y165.416 E.08211
G1 X190.578 Y163.249 E.08211
G1 X189.46 Y160.852 E.0821
G1 X189.402 Y160.633 E.00704
G1 X188.776 Y158.297 E.07506
G1 X188.545 Y155.662 E.0821
G1 X188.776 Y153.027 E.08211
G1 X189.46 Y150.472 E.08211
G1 X189.556 Y150.266 E.00704
G1 X190.578 Y148.075 E.07506
G1 X192.095 Y145.908 E.08211
G1 X193.966 Y144.038 E.0821
G1 X196.132 Y142.521 E.08211
G1 X198.53 Y141.403 E.0821
G1 X201.085 Y140.718 E.0821
G1 X203.72 Y140.488 E.08211
G1 X203.946 Y140.507 E.00704
G1 X206.355 Y140.718 E.07506
G1 X208.91 Y141.403 E.0821
G1 X211.307 Y142.521 E.08211
G1 X213.473 Y144.038 E.0821
G1 X215.344 Y145.908 E.08211
G1 X216.861 Y148.075 E.08211
G1 X217.979 Y150.472 E.0821
G1 X218.663 Y153.027 E.0821
G1 X218.889 Y155.602 E.08024
M204 S10000
G1 X218.099 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435621
G1 F6208
M204 S8000
G1 X217.881 Y153.175 E.08069
G1 X217.222 Y150.722 E.08212
G1 X216.177 Y148.482 E.07992
G1 X214.74 Y146.428 E.08102
G1 X212.969 Y144.654 E.08102
G1 X210.917 Y143.215 E.08102
G1 X208.647 Y142.154 E.08102
G1 X206.226 Y141.504 E.08102
G1 X203.709 Y141.284 E.08167
G1 X201.233 Y141.5 E.08036
G1 X198.812 Y142.147 E.08102
G1 X196.539 Y143.205 E.08103
G1 X194.459 Y144.664 E.08212
G1 X192.712 Y146.412 E.07991
G1 X191.273 Y148.464 E.08102
G1 X190.212 Y150.735 E.08102
G1 X189.561 Y153.155 E.08102
G1 X189.341 Y155.652 E.08102
G1 X189.558 Y158.149 E.08102
G1 X190.205 Y160.57 E.08102
G1 X191.263 Y162.842 E.08103
G1 X192.721 Y164.922 E.08212
G1 X194.47 Y166.67 E.07991
G1 X196.522 Y168.109 E.08102
G1 X198.792 Y169.17 E.08102
G1 X201.213 Y169.82 E.08102
G1 X203.709 Y170.04 E.08102
G1 X206.206 Y169.824 E.08102
G1 X208.628 Y169.177 E.08102
G1 X210.9 Y168.119 E.08103
G1 X212.98 Y166.66 E.08212
G1 X214.727 Y164.912 E.07991
G1 X216.183 Y162.83 E.08212
G1 X217.238 Y160.557 E.08102
G1 X217.878 Y158.169 E.07992
G1 X218.094 Y155.722 E.07941
M204 S10000
G1 X217.638 Y154.972 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6208
M204 S8000
G1 X217.496 Y153.35 E.05457
G3 X217.105 Y152.854 I2.014 J-1.992 E.02121
G3 X216.086 Y149.232 I4.465 J-3.209 E.12868
G1 X215.825 Y148.673 E.02068
G1 X214.428 Y146.677 E.08166
G1 X213.805 Y146.054 E.02949
G3 X213.124 Y148.174 I-1.979 J.533 E.07889
G1 X211.696 Y149.11 E.0572
G2 X208.56 Y153.79 I3.02 J5.415 E.19596
G2 X209.291 Y155.662 I1.998 J.298 E.07048
G1 X210.718 Y156.598 E.0572
G3 X213.855 Y161.278 I-3.02 J5.415 E.19596
G3 X213.124 Y163.15 I-1.998 J.298 E.07048
G1 X211.696 Y164.086 E.0572
G2 X208.559 Y168.77 I3.082 J5.456 E.19595
G1 X206.147 Y169.428 E.08379
G1 X204.074 Y169.61 E.06974
G3 X201.072 Y165.022 I3.088 J-5.296 E.19048
G3 X201.803 Y163.15 I1.998 J-.298 E.07048
G1 X203.231 Y162.214 E.0572
G2 X206.367 Y157.534 I-3.02 J-5.415 E.19596
G2 X205.636 Y155.662 I-1.998 J-.298 E.07048
G1 X204.208 Y154.726 E.0572
G3 X201.072 Y150.046 I3.02 J-5.415 E.19596
G3 X201.803 Y148.174 I1.998 J-.298 E.07049
G1 X203.231 Y147.239 E.0572
G2 X206.361 Y141.953 I-2.893 J-5.283 E.216
G1 X203.72 Y141.683 E.08896
G1 X201.292 Y141.896 E.08166
G1 X198.939 Y142.526 E.08164
G1 X197.566 Y143.166 E.05074
G3 X198.88 Y146.303 I-4.842 J3.87 E.11542
G3 X198.148 Y148.174 I-1.998 J.299 E.07048
G1 X196.721 Y149.11 E.0572
G2 X193.584 Y153.79 I3.02 J5.415 E.19596
G2 X194.316 Y155.662 I1.998 J.299 E.07048
G1 X195.743 Y156.598 E.0572
G3 X198.88 Y161.278 I-3.02 J5.415 E.19596
G3 X198.148 Y163.15 I-1.998 J.299 E.07048
G1 X196.721 Y164.086 E.0572
G2 X194.526 Y166.162 I3.132 J5.508 E.10223
G1 X193.011 Y164.647 E.07179
G1 X191.614 Y162.651 E.08166
G1 X190.584 Y160.443 E.08166
G1 X190.485 Y160.075 E.01276
G2 X191.392 Y157.534 I-5.777 J-3.493 E.09102
G2 X191.111 Y156.13 I-2.236 J-.283 E.04882
G2 X189.791 Y155.092 I-2.935 J2.373 E.05676
G1 X189.933 Y153.47 E.05457
; WIPE_START
G1 F18423.913
G1 X189.846 Y154.466 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z6.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 31/82
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.407 Y155.662 F60000
M73 P66 R4
G1 Z6.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6163
M204 S8000
G1 X218.184 Y158.213 E.08579
G1 X217.521 Y160.685 E.08579
G1 X216.439 Y163.006 E.0858
G1 X214.971 Y165.103 E.08579
G1 X213.161 Y166.913 E.0858
G1 X211.063 Y168.382 E.08579
G1 X210.716 Y168.544 E.01286
G1 X208.743 Y169.464 E.07294
G1 X206.27 Y170.127 E.08579
G1 X203.72 Y170.35 E.08579
G1 X201.169 Y170.127 E.08579
G1 X198.696 Y169.464 E.08579
G1 X196.376 Y168.382 E.0858
G1 X194.279 Y166.913 E.08579
G1 X192.468 Y165.103 E.0858
G1 X191 Y163.006 E.08579
G1 X190.838 Y162.658 E.01286
G1 X189.918 Y160.685 E.07294
G1 X189.255 Y158.213 E.08579
G1 X189.032 Y155.662 E.08579
G1 X189.255 Y153.112 E.08579
G1 X189.918 Y150.639 E.08579
G1 X191 Y148.318 E.08579
G1 X192.468 Y146.221 E.08579
G1 X194.279 Y144.411 E.08579
G1 X196.376 Y142.942 E.08579
G1 X198.696 Y141.86 E.0858
G1 X201.169 Y141.198 E.08579
G1 X203.72 Y140.974 E.08579
G1 X204.102 Y141.008 E.01286
G1 X206.27 Y141.198 E.07294
G1 X208.743 Y141.86 E.08579
G1 X211.063 Y142.942 E.0858
G1 X213.161 Y144.411 E.08579
G1 X214.971 Y146.221 E.08579
G1 X216.439 Y148.318 E.08579
G1 X217.521 Y150.639 E.0858
G1 X218.184 Y153.112 E.08579
G1 X218.402 Y155.602 E.08378
; COOLING_NODE: 0
M204 S10000
G1 X218.801 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5617
M204 S5000
G1 X218.572 Y158.281 E.0816
G1 X217.891 Y160.82 E.0816
G1 X216.78 Y163.203 E.0816
G1 X215.272 Y165.356 E.0816
G1 X213.414 Y167.215 E.0816
G1 X211.26 Y168.723 E.0816
G1 X210.881 Y168.899 E.01298
G1 X208.878 Y169.834 E.06863
G1 X206.338 Y170.514 E.0816
G1 X203.72 Y170.743 E.0816
G1 X201.101 Y170.514 E.0816
G1 X198.562 Y169.834 E.0816
G1 X196.179 Y168.723 E.0816
G1 X194.026 Y167.215 E.0816
G1 X192.167 Y165.356 E.0816
G1 X190.659 Y163.203 E.0816
G1 X190.482 Y162.824 E.01298
G1 X189.548 Y160.82 E.06863
G1 X188.868 Y158.281 E.0816
G1 X188.638 Y155.662 E.0816
G1 X188.868 Y153.043 E.0816
G1 X189.548 Y150.504 E.0816
G1 X189.725 Y150.125 E.01298
G1 X190.659 Y148.121 E.06862
G1 X192.167 Y145.968 E.0816
G1 X194.026 Y144.109 E.0816
G1 X196.179 Y142.601 E.0816
G1 X198.562 Y141.49 E.0816
G1 X201.101 Y140.81 E.0816
G1 X203.72 Y140.581 E.0816
G1 X204.136 Y140.617 E.01298
G1 X206.338 Y140.81 E.06863
G1 X208.878 Y141.49 E.0816
G1 X211.26 Y142.601 E.0816
G1 X213.414 Y144.109 E.0816
G1 X215.272 Y145.968 E.0816
G1 X216.78 Y148.121 E.0816
G1 X217.891 Y150.504 E.0816
G1 X218.572 Y153.043 E.0816
G1 X218.796 Y155.602 E.07974
M204 S10000
G1 X218.005 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.43562
G1 F6163
M204 S8000
G1 X217.789 Y153.192 E.08017
G1 X217.134 Y150.754 E.08159
G1 X216.096 Y148.528 E.0794
G1 X214.669 Y146.487 E.0805
G1 X212.91 Y144.726 E.08049
G1 X210.871 Y143.296 E.08049
G1 X208.615 Y142.242 E.08049
G1 X206.21 Y141.596 E.0805
G1 X203.709 Y141.377 E.08115
G1 X201.249 Y141.592 E.07984
G1 X198.843 Y142.235 E.08049
G1 X196.586 Y143.286 E.0805
G1 X194.519 Y144.735 E.0816
G1 X192.783 Y146.472 E.07939
G1 X191.353 Y148.511 E.0805
G1 X190.3 Y150.767 E.08049
G1 X189.653 Y153.171 E.08049
G1 X189.435 Y155.652 E.0805
G1 X189.65 Y158.133 E.08049
G1 X190.293 Y160.538 E.08049
G1 X191.343 Y162.796 E.0805
G1 X192.793 Y164.862 E.08159
G1 X194.53 Y166.598 E.07939
G1 X196.568 Y168.028 E.0805
G1 X198.824 Y169.082 E.08049
G1 X201.229 Y169.728 E.0805
G1 X203.709 Y169.947 E.0805
G1 X206.19 Y169.732 E.08049
G1 X208.596 Y169.089 E.08049
G1 X210.853 Y168.038 E.0805
G1 X212.92 Y166.589 E.0816
G1 X214.656 Y164.852 E.07939
G1 X216.102 Y162.783 E.08159
G1 X217.151 Y160.525 E.08049
G1 X217.786 Y158.153 E.07939
G1 X218 Y155.722 E.07888
M204 S10000
G1 X217.531 Y154.82 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6163
M204 S8000
G1 X217.394 Y153.251 E.0528
G3 X216.273 Y149.852 I4.093 J-3.234 E.12241
G1 X215.745 Y148.719 E.04188
G1 X214.356 Y146.737 E.08111
G1 X213.61 Y145.991 E.03535
G3 X212.74 Y148.174 I-2.303 J.347 E.08257
G1 X211.471 Y149.11 E.05283
G2 X208.769 Y153.79 I3.253 J4.998 E.18793
G2 X209.674 Y155.662 I2.327 J.03 E.07223
G1 X210.943 Y156.598 E.05283
G3 X213.645 Y161.278 I-3.253 J4.998 E.18793
G3 X212.74 Y163.15 I-2.327 J.03 E.07223
G1 X211.471 Y164.086 E.05283
G2 X208.792 Y168.559 I3.234 J4.976 E.18091
G3 X207.396 Y168.998 I-1.941 J-3.741 E.04929
G1 X206.131 Y169.336 E.04388
G1 X203.778 Y169.542 E.07914
G3 X201.282 Y165.022 I3.299 J-4.771 E.17935
G3 X202.187 Y163.15 I2.327 J-.03 E.07223
G1 X203.455 Y162.214 E.05283
G2 X206.157 Y157.534 I-3.253 J-4.998 E.18793
G2 X205.253 Y155.662 I-2.327 J-.03 E.07223
G1 X203.984 Y154.726 E.05283
G3 X201.282 Y150.046 I3.253 J-4.998 E.18793
G3 X202.187 Y148.174 I2.327 J-.03 E.07223
G2 X204.568 Y146.303 I-11.48 J-17.058 E.10161
G2 X206.088 Y141.984 I-3.776 J-3.755 E.15858
G1 X203.72 Y141.777 E.07967
G1 X201.308 Y141.988 E.08111
G1 X198.971 Y142.614 E.0811
G1 X197.621 Y143.243 E.04991
G3 X198.67 Y146.303 I-4.273 J3.175 E.11011
G3 X197.765 Y148.174 I-2.327 J.03 E.07223
G1 X196.496 Y149.11 E.05283
G2 X193.794 Y153.79 I3.253 J4.998 E.18793
G2 X194.699 Y155.662 I2.327 J.03 E.07223
G1 X195.968 Y156.598 E.05283
G3 X198.67 Y161.278 I-3.253 J4.998 E.18793
G3 X197.765 Y163.15 I-2.327 J.03 E.07223
G1 X196.496 Y164.086 E.05283
G2 X194.645 Y165.957 I4.148 J5.953 E.08871
G1 X194.581 Y166.086 E.0048
G1 X193.083 Y164.587 E.07101
G1 X191.694 Y162.605 E.08111
G1 X190.672 Y160.411 E.08111
G1 X190.541 Y159.923 E.01695
G2 X191.182 Y157.534 I-5.22 J-2.683 E.08351
G2 X189.861 Y155.355 I-2.536 J.048 E.08946
G1 X190.003 Y153.733 E.05457
; WIPE_START
G1 F18423.913
G1 X189.916 Y154.729 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z6.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 6.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 32/82
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.314 Y155.662 F60000
G1 Z6.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6085
M204 S8000
G1 X218.092 Y158.196 E.08525
G1 X217.434 Y160.654 E.08525
G1 X216.359 Y162.959 E.08525
G1 X214.899 Y165.043 E.08525
G1 X213.101 Y166.842 E.08525
G1 X211.017 Y168.301 E.08525
G1 X208.711 Y169.376 E.08525
G1 X208.156 Y169.525 E.01926
G1 X206.254 Y170.035 E.06599
G1 X203.72 Y170.256 E.08525
G1 X201.185 Y170.035 E.08525
G1 X198.728 Y169.376 E.08525
G1 X196.422 Y168.301 E.08525
G1 X194.338 Y166.842 E.08525
G1 X193.932 Y166.436 E.01926
G1 X192.54 Y165.043 E.06599
G1 X191.08 Y162.959 E.08525
G1 X190.005 Y160.654 E.08525
G1 X189.347 Y158.196 E.08525
G1 X189.125 Y155.662 E.08525
G1 X189.347 Y153.128 E.08525
G1 X190.005 Y150.671 E.08525
G1 X191.08 Y148.365 E.08525
G1 X192.54 Y146.281 E.08525
G1 X194.338 Y144.482 E.08525
G1 X196.422 Y143.023 E.08525
G1 X198.728 Y141.948 E.08525
G1 X201.185 Y141.289 E.08525
G1 X203.72 Y141.068 E.08525
G1 X204.292 Y141.118 E.01926
G1 X206.254 Y141.289 E.06599
G1 X208.711 Y141.948 E.08525
G1 X211.017 Y143.023 E.08525
G1 X213.101 Y144.482 E.08525
G1 X214.899 Y146.281 E.08525
G1 X216.359 Y148.365 E.08525
G1 X217.434 Y150.671 E.08525
G1 X218.092 Y153.128 E.08525
G1 X218.309 Y155.602 E.08324
; COOLING_NODE: 0
M204 S10000
G1 X218.707 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5624
M204 S5000
G1 X218.48 Y158.265 E.0811
G1 X217.804 Y160.788 E.0811
G1 X216.7 Y163.156 E.0811
G1 X215.201 Y165.296 E.0811
G1 X213.354 Y167.143 E.08109
G1 X211.213 Y168.642 E.0811
G1 X208.846 Y169.746 E.0811
G1 X208.257 Y169.904 E.01891
G1 X206.322 Y170.422 E.06219
G1 X203.72 Y170.65 E.0811
G1 X201.117 Y170.422 E.0811
G1 X198.593 Y169.746 E.0811
G1 X196.226 Y168.642 E.0811
G1 X194.085 Y167.143 E.0811
G1 X193.655 Y166.713 E.01891
G1 X192.238 Y165.296 E.06219
G1 X190.74 Y163.156 E.0811
G1 X189.636 Y160.788 E.0811
G1 X188.959 Y158.265 E.0811
G1 X188.732 Y155.662 E.0811
G1 X188.959 Y153.059 E.0811
G1 X189.636 Y150.536 E.0811
G1 X190.74 Y148.168 E.0811
G1 X192.238 Y146.028 E.0811
G1 X194.085 Y144.181 E.08109
G1 X196.226 Y142.682 E.0811
G1 X198.593 Y141.578 E.0811
G1 X201.117 Y140.902 E.0811
G1 X203.72 Y140.674 E.0811
G1 X204.326 Y140.727 E.01891
G1 X206.322 Y140.902 E.06219
G1 X208.846 Y141.578 E.0811
G1 X211.213 Y142.682 E.0811
G1 X213.354 Y144.181 E.0811
G1 X215.201 Y146.028 E.08109
G1 X216.699 Y148.168 E.0811
G1 X217.804 Y150.536 E.0811
G1 X218.48 Y153.059 E.0811
G1 X218.702 Y155.602 E.07923
M204 S10000
G1 X217.912 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435618
G1 F6085
M204 S8000
G1 X217.697 Y153.208 E.07964
G1 X217.047 Y150.786 E.08107
G1 X216.015 Y148.575 E.07887
G1 X214.598 Y146.547 E.07997
G1 X212.85 Y144.797 E.07996
G1 X210.824 Y143.377 E.07997
G1 X208.583 Y142.33 E.07997
G1 X206.194 Y141.688 E.07997
G1 X203.709 Y141.47 E.08062
G1 X201.265 Y141.684 E.07931
G1 X198.875 Y142.323 E.07997
G1 X196.633 Y143.367 E.07997
G1 X194.579 Y144.807 E.08108
G1 X192.855 Y146.532 E.07886
G1 X191.434 Y148.557 E.07997
G1 X190.387 Y150.799 E.07997
G1 X189.745 Y153.188 E.07997
G1 X189.528 Y155.652 E.07997
G1 X189.742 Y158.116 E.07996
G1 X190.38 Y160.506 E.07997
G1 X191.424 Y162.749 E.07997
G1 X192.864 Y164.802 E.08107
G1 X194.589 Y166.527 E.07886
G1 X196.615 Y167.947 E.07997
G1 X198.856 Y168.994 E.07997
G1 X201.245 Y169.636 E.07997
G1 X203.709 Y169.854 E.07997
G1 X206.174 Y169.64 E.07996
G1 X208.564 Y169.001 E.07997
G1 X210.807 Y167.958 E.07997
G1 X212.86 Y166.517 E.08108
G1 X214.585 Y164.792 E.07886
G1 X216.022 Y162.737 E.08107
G1 X217.063 Y160.493 E.07996
M73 P67 R4
G1 X217.694 Y158.136 E.07887
G1 X217.907 Y155.722 E.07836
M204 S10000
G1 X217.425 Y154.675 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6085
M204 S8000
G1 X217.302 Y153.267 E.04737
G2 X217.101 Y152.854 I-.66 J.066 E.01571
G3 X216.46 Y150.473 I4.883 J-2.593 E.08336
G1 X215.664 Y148.766 E.0631
G1 X214.285 Y146.797 E.08057
G1 X213.445 Y145.956 E.03982
G3 X212.885 Y147.706 I-2.412 J.193 E.06316
G3 X211.272 Y149.11 I-6.625 J-5.98 E.07181
G2 X208.988 Y152.854 I3.691 J4.821 E.15036
G2 X209.53 Y155.194 I2.908 J.56 E.08287
G2 X211.142 Y156.598 I6.625 J-5.98 E.07181
G3 X213.426 Y160.342 I-3.691 J4.821 E.15036
G3 X212.885 Y162.682 I-2.908 J.559 E.08287
G3 X211.272 Y164.086 I-6.625 J-5.98 E.07181
G2 X208.971 Y168.373 I3.333 J4.55 E.1686
G1 X208.437 Y168.622 E.01976
G1 X206.115 Y169.245 E.08055
G1 X203.474 Y169.433 E.08871
G3 X201.5 Y165.957 I3.886 J-4.505 E.13658
G3 X202.042 Y163.618 I2.908 J-.56 E.08287
G3 X203.654 Y162.214 I6.625 J5.98 E.07181
G2 X205.939 Y158.47 I-3.691 J-4.821 E.15036
G2 X205.397 Y156.13 I-2.908 J-.559 E.08287
G2 X203.785 Y154.726 I-6.625 J5.98 E.07181
G3 X201.5 Y150.982 I3.691 J-4.821 E.15036
G3 X202.042 Y148.642 I2.908 J-.56 E.08287
G3 X204.196 Y146.771 I24.505 J26.018 E.09564
G2 X205.873 Y142.058 I-3.433 J-3.876 E.17492
G1 X203.72 Y141.87 E.07243
G1 X201.324 Y142.079 E.08057
G1 X199.003 Y142.702 E.08055
G1 X197.696 Y143.311 E.04833
G3 X198.451 Y145.367 I-5.252 J3.097 E.07379
G3 X197.909 Y147.706 I-2.908 J.56 E.08287
G3 X196.297 Y149.11 I-6.625 J-5.98 E.07181
G2 X194.013 Y152.854 I3.691 J4.821 E.15036
G2 X194.555 Y155.194 I2.908 J.56 E.08287
G2 X196.167 Y156.598 I6.626 J-5.981 E.07181
G3 X198.451 Y160.342 I-3.691 J4.821 E.15036
G3 X197.909 Y162.682 I-2.908 J.56 E.08287
G3 X196.297 Y164.086 I-6.625 J-5.98 E.07181
G2 X194.639 Y165.957 I4.279 J5.462 E.08427
G1 X194.622 Y165.995 E.00139
G1 X193.154 Y164.528 E.06957
G1 X191.775 Y162.558 E.08057
G1 X190.759 Y160.379 E.08057
G1 X190.592 Y159.756 E.02161
G2 X190.963 Y158.47 I-3.338 J-1.66 E.04511
G2 X189.93 Y155.632 I-2.879 J-.559 E.10632
G1 X190.072 Y154.01 E.05457
; WIPE_START
G1 F18423.913
G1 X189.985 Y155.006 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z6.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 6.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 33/82
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.221 Y155.662 F60000
G1 Z6.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6014
M204 S8000
G1 X218 Y158.18 E.0847
G1 X217.346 Y160.622 E.0847
G1 X216.278 Y162.913 E.08471
G1 X214.828 Y164.983 E.0847
G1 X213.041 Y166.771 E.0847
G1 X210.97 Y168.22 E.0847
G1 X208.679 Y169.289 E.08471
G1 X206.238 Y169.943 E.0847
G1 X203.72 Y170.163 E.0847
G1 X201.201 Y169.943 E.0847
G1 X198.76 Y169.289 E.0847
G1 X196.469 Y168.22 E.08471
G1 X194.398 Y166.771 E.0847
G1 X192.611 Y164.983 E.0847
G1 X191.161 Y162.913 E.0847
G1 X190.093 Y160.622 E.08471
G1 X189.439 Y158.18 E.0847
G1 X189.218 Y155.662 E.0847
G1 X189.439 Y153.144 E.0847
G1 X190.093 Y150.702 E.08471
G1 X190.417 Y150.008 E.02567
G1 X191.161 Y148.412 E.05904
G1 X192.611 Y146.341 E.0847
G1 X194.398 Y144.554 E.0847
G1 X196.469 Y143.104 E.0847
G1 X198.76 Y142.035 E.08471
G1 X201.201 Y141.381 E.0847
G1 X203.72 Y141.161 E.0847
G1 X204.483 Y141.228 E.02567
G1 X206.238 Y141.381 E.05904
G1 X208.679 Y142.035 E.0847
G1 X210.97 Y143.104 E.08471
G1 X213.041 Y144.554 E.0847
G1 X214.828 Y146.341 E.0847
G1 X216.278 Y148.411 E.0847
G1 X217.346 Y150.702 E.08471
G1 X218 Y153.144 E.0847
G1 X218.215 Y155.602 E.08269
; COOLING_NODE: 0
M204 S10000
G1 X218.614 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5619
M204 S5000
G1 X218.388 Y158.248 E.08059
G1 X217.716 Y160.756 E.08059
G1 X216.619 Y163.109 E.08059
G1 X215.13 Y165.236 E.08059
G1 X213.294 Y167.072 E.08059
G1 X211.167 Y168.561 E.08059
G1 X208.814 Y169.658 E.08059
G1 X206.306 Y170.33 E.08059
G1 X203.72 Y170.557 E.08059
G1 X201.133 Y170.33 E.08059
G1 X198.625 Y169.658 E.08059
G1 X196.272 Y168.561 E.08059
G1 X194.145 Y167.072 E.08059
G1 X192.31 Y165.236 E.08059
G1 X190.82 Y163.109 E.08059
G1 X189.723 Y160.756 E.08059
G1 X189.051 Y158.248 E.08059
G1 X188.825 Y155.662 E.08059
G1 X189.051 Y153.076 E.08059
G1 X189.723 Y150.568 E.08059
G1 X190.061 Y149.843 E.02484
G1 X190.82 Y148.215 E.05575
G1 X192.31 Y146.088 E.08059
G1 X194.145 Y144.252 E.08059
G1 X196.272 Y142.763 E.08059
G1 X198.625 Y141.666 E.08059
G1 X201.133 Y140.994 E.08059
G1 X203.72 Y140.767 E.08059
G1 X204.517 Y140.837 E.02484
G1 X206.306 Y140.994 E.05575
G1 X208.814 Y141.666 E.08059
G1 X211.167 Y142.763 E.08059
G1 X213.294 Y144.252 E.08059
G1 X215.13 Y146.088 E.08059
G1 X216.619 Y148.215 E.08059
G1 X217.716 Y150.568 E.08059
G1 X218.388 Y153.076 E.08059
G1 X218.609 Y155.602 E.07873
M204 S10000
G1 X217.819 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435623
G1 F6014
M204 S8000
G1 X217.606 Y153.224 E.07912
G1 X216.959 Y150.818 E.08054
G1 X215.934 Y148.622 E.07834
G1 X214.526 Y146.607 E.07945
G1 X212.79 Y144.868 E.07944
G1 X210.778 Y143.457 E.07944
G1 X208.551 Y142.417 E.07944
G1 X206.178 Y141.78 E.07945
G1 X203.709 Y141.564 E.0801
G1 X201.282 Y141.776 E.07879
G1 X198.907 Y142.41 E.07944
G1 X196.679 Y143.447 E.07945
G1 X194.639 Y144.878 E.08055
G1 X192.926 Y146.592 E.07834
G1 X191.515 Y148.604 E.07944
G1 X190.475 Y150.831 E.07944
G1 X189.837 Y153.204 E.07944
G1 X189.621 Y155.652 E.07945
G1 X189.834 Y158.1 E.07944
G1 X190.468 Y160.474 E.07944
G1 X191.505 Y162.703 E.07945
G1 X192.935 Y164.742 E.08055
G1 X194.649 Y166.456 E.07834
G1 X196.662 Y167.867 E.07945
G1 X198.888 Y168.907 E.07944
G1 X201.261 Y169.545 E.07944
G1 X203.709 Y169.761 E.07945
G1 X206.158 Y169.548 E.07944
G1 X208.532 Y168.914 E.07944
G1 X210.76 Y167.877 E.07945
G1 X212.8 Y166.446 E.08055
G1 X214.513 Y164.732 E.07834
G1 X215.941 Y162.69 E.08054
G1 X216.975 Y160.461 E.07944
G1 X217.602 Y158.12 E.07834
G1 X217.814 Y155.722 E.07783
M204 S10000
G1 X217.316 Y154.49 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6014
M204 S8000
G2 X217.102 Y152.88 I-4.671 J-.199 E.05468
G3 X216.579 Y150.982 I6.742 J-2.88 E.06617
G1 X215.583 Y148.813 E.08
G1 X214.213 Y146.857 E.08002
G1 X213.299 Y145.942 E.04336
G3 X212.947 Y147.239 I-2.737 J-.045 E.04549
G3 X211.089 Y149.11 I-6.497 J-4.591 E.0888
G2 X209.251 Y151.918 I4.032 J4.646 E.11391
G2 X209.467 Y154.726 I3.768 J1.122 E.09651
G2 X211.325 Y156.598 I6.497 J-4.591 E.0888
G3 X213.164 Y159.406 I-4.032 J4.646 E.11391
G3 X212.947 Y162.214 I-3.768 J1.122 E.09651
G3 X211.089 Y164.086 I-6.497 J-4.592 E.0888
G2 X209.107 Y168.207 I3.395 J4.169 E.15829
G1 X208.405 Y168.535 E.02598
G1 X206.098 Y169.153 E.08001
G1 X203.72 Y169.361 E.08002
G1 X203.233 Y169.318 E.01637
G3 X201.763 Y166.893 I3.98 J-4.071 E.09603
G3 X201.979 Y164.086 I3.768 J-1.122 E.09651
G3 X203.837 Y162.214 I6.497 J4.591 E.0888
G2 X205.676 Y159.406 I-4.032 J-4.646 E.11391
G2 X205.46 Y156.598 I-3.768 J-1.122 E.09651
G2 X203.602 Y154.726 I-6.497 J4.592 E.0888
G3 X201.604 Y150.982 I3.503 J-4.274 E.14595
G3 X202.311 Y148.642 I3.104 J-.338 E.08416
G2 X204.738 Y146.303 I-74.5 J-79.706 E.11298
G2 X205.687 Y142.135 I-3.864 J-3.071 E.14812
G1 X203.72 Y141.963 E.06617
G1 X201.341 Y142.171 E.08002
G1 X199.034 Y142.789 E.08001
G1 X197.768 Y143.38 E.04682
G1 X198.188 Y144.431 E.03793
G3 X197.972 Y147.239 I-3.768 J1.122 E.09651
G3 X196.114 Y149.11 I-6.497 J-4.591 E.0888
G2 X194.276 Y151.918 I4.032 J4.646 E.11391
G2 X194.492 Y154.726 I3.768 J1.122 E.09651
G2 X196.35 Y156.598 I6.497 J-4.591 E.0888
G3 X198.188 Y159.406 I-4.032 J4.646 E.11391
G3 X197.972 Y162.214 I-3.768 J1.122 E.09651
G3 X196.114 Y164.086 I-6.497 J-4.592 E.0888
G2 X194.659 Y165.901 I3.658 J4.423 E.07851
G1 X193.226 Y164.468 E.06792
G1 X191.856 Y162.511 E.08002
G1 X190.847 Y160.347 E.08002
G1 X190.639 Y159.572 E.02689
G2 X190.86 Y158.47 I-2.798 J-1.134 E.03789
G2 X190.053 Y156.026 I-3.079 J-.338 E.08893
G1 X190.021 Y155.662 E.01226
G1 X190.131 Y154.404 E.04231
; WIPE_START
G1 F18423.913
G1 X190.044 Y155.4 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z7 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z7 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 34/82
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.127 Y155.662 F60000
G1 Z6.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5841
M204 S8000
G1 X217.909 Y158.164 E.08416
G1 X217.259 Y160.59 E.08416
G1 X216.197 Y162.866 E.08416
G1 X214.757 Y164.923 E.08416
G1 X212.981 Y166.699 E.08416
G1 X210.923 Y168.14 E.08416
G1 X210.056 Y168.544 E.03207
G1 X208.647 Y169.201 E.05209
G1 X206.221 Y169.851 E.08416
G1 X203.72 Y170.07 E.08416
G1 X201.218 Y169.851 E.08416
G1 X198.792 Y169.201 E.08416
G1 X196.516 Y168.14 E.08416
G1 X194.458 Y166.699 E.08416
G1 X192.683 Y164.923 E.08416
G1 X191.242 Y162.866 E.08416
G1 X190.838 Y161.999 E.03207
G1 X190.181 Y160.59 E.05209
G1 X189.531 Y158.164 E.08416
G1 X189.312 Y155.662 E.08416
G1 X189.531 Y153.16 E.08416
G1 X189.778 Y152.236 E.03207
G1 X190.181 Y150.734 E.05209
G1 X191.242 Y148.458 E.08416
G1 X192.683 Y146.401 E.08416
G1 X194.458 Y144.625 E.08416
G1 X196.516 Y143.185 E.08416
G1 X198.792 Y142.123 E.08416
G1 X201.218 Y141.473 E.08416
G1 X203.72 Y141.254 E.08416
G1 X204.673 Y141.338 E.03207
G1 X206.221 Y141.473 E.05209
G1 X208.647 Y142.123 E.08416
G1 X210.923 Y143.185 E.08416
G1 X212.981 Y144.625 E.08416
G1 X214.757 Y146.401 E.08416
G1 X216.197 Y148.458 E.08416
G1 X217.259 Y150.734 E.08416
G1 X217.909 Y153.16 E.08416
G1 X218.122 Y155.602 E.08215
; COOLING_NODE: 0
M204 S10000
G1 X218.521 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5605
M204 S5000
G1 X218.296 Y158.232 E.08009
G1 X217.628 Y160.724 E.08009
G1 X216.538 Y163.063 E.08009
G1 X215.058 Y165.176 E.08009
G1 X213.234 Y167.001 E.08009
G1 X211.12 Y168.48 E.08009
G1 X208.782 Y169.571 E.08009
G1 X206.29 Y170.239 E.08009
G1 X203.72 Y170.463 E.08009
G1 X201.149 Y170.239 E.08009
G1 X198.657 Y169.571 E.08009
G1 X196.319 Y168.48 E.08009
G1 X194.205 Y167.001 E.08009
G1 X192.381 Y165.176 E.08009
G1 X190.901 Y163.063 E.08009
G1 X189.811 Y160.724 E.08009
G1 X189.143 Y158.232 E.08009
G1 X188.918 Y155.662 E.08009
M73 P68 R4
G1 X189.143 Y153.092 E.08009
G1 X189.4 Y152.134 E.03077
G1 X189.811 Y150.6 E.04931
G1 X190.901 Y148.261 E.08009
G1 X192.381 Y146.148 E.08009
G1 X194.205 Y144.324 E.08009
G1 X196.319 Y142.844 E.08009
G1 X198.657 Y141.753 E.08009
G1 X201.149 Y141.086 E.08009
G1 X203.72 Y140.861 E.08009
G1 X204.707 Y140.947 E.03077
G1 X206.29 Y141.086 E.04932
G1 X208.782 Y141.753 E.08009
G1 X211.12 Y142.844 E.08009
G1 X213.234 Y144.324 E.08009
G1 X215.058 Y146.148 E.08009
G1 X216.538 Y148.261 E.08009
G1 X217.628 Y150.6 E.08009
G1 X218.296 Y153.092 E.08009
G1 X218.516 Y155.602 E.07822
M204 S10000
G1 X217.726 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435623
G1 F5841
M204 S8000
G1 X217.514 Y153.24 E.07859
G1 X216.871 Y150.85 E.08002
G1 X215.854 Y148.668 E.07782
G1 X214.455 Y146.667 E.07892
G1 X212.73 Y144.94 E.07892
G1 X210.731 Y143.538 E.07892
G1 X208.519 Y142.505 E.07892
G1 X206.161 Y141.871 E.07892
G1 X203.709 Y141.657 E.07957
G1 X201.298 Y141.868 E.07826
G1 X198.939 Y142.498 E.07892
G1 X196.726 Y143.528 E.07892
G1 X194.699 Y144.949 E.08003
G1 X192.997 Y146.652 E.07781
G1 X191.596 Y148.651 E.07892
G1 X190.562 Y150.862 E.07892
G1 X189.929 Y153.22 E.07892
G1 X189.714 Y155.652 E.07892
G1 X189.925 Y158.084 E.07891
G1 X190.555 Y160.442 E.07892
G1 X191.586 Y162.656 E.07892
G1 X193.007 Y164.683 E.08002
G1 X194.709 Y166.384 E.07781
G1 X196.708 Y167.786 E.07892
G1 X198.92 Y168.819 E.07892
G1 X201.278 Y169.453 E.07892
G1 X203.709 Y169.667 E.07892
G1 X206.142 Y169.456 E.07891
G1 X208.5 Y168.826 E.07891
G1 X210.713 Y167.796 E.07892
G1 X212.74 Y166.375 E.08002
G1 X214.442 Y164.672 E.07781
G1 X215.86 Y162.643 E.08002
G1 X216.888 Y160.429 E.07891
G1 X217.51 Y158.104 E.07782
G1 X217.72 Y155.722 E.07731
M204 S10000
G1 X214.285 Y147.12 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5841
M204 S8000
G1 X213.166 Y145.941 E.05446
G3 X212.726 Y147.239 I-2.911 J-.264 E.04635
G3 X210.916 Y149.11 I-8.341 J-6.256 E.08749
G2 X209.574 Y150.982 I3.732 J4.09 E.07773
G2 X209.688 Y154.726 I3.881 J1.756 E.12995
G2 X211.499 Y156.598 I8.34 J-6.255 E.08749
G3 X212.84 Y158.47 I-3.732 J4.09 E.07773
G3 X212.726 Y162.214 I-3.881 J1.756 E.12995
G3 X210.916 Y164.086 I-8.342 J-6.256 E.08749
G2 X209.184 Y167.829 I3.508 J3.895 E.14206
G1 X209.209 Y168.057 E.00768
G1 X208.373 Y168.447 E.03093
G1 X206.082 Y169.061 E.07946
G1 X203.72 Y169.268 E.07948
G1 X202.993 Y169.204 E.02443
G3 X202.087 Y167.829 I2.78 J-2.819 E.05558
G3 X202.201 Y164.086 I3.881 J-1.756 E.12995
G3 X204.011 Y162.214 I8.341 J6.256 E.08749
G2 X205.352 Y160.342 I-3.731 J-4.09 E.07773
G2 X205.238 Y156.598 I-3.881 J-1.756 E.12995
G2 X203.428 Y154.726 I-8.342 J6.256 E.08749
G3 X201.797 Y151.918 I4.033 J-4.219 E.11026
G3 X202.552 Y148.642 I3.703 J-.872 E.11668
G2 X204.83 Y146.303 I-28.606 J-30.129 E.10946
G2 X205.525 Y142.214 I-3.901 J-2.767 E.14373
G1 X203.72 Y142.056 E.06073
G1 X201.357 Y142.263 E.07948
G1 X199.066 Y142.877 E.07946
G1 X197.839 Y143.449 E.04537
G1 X197.865 Y143.495 E.00175
G3 X197.751 Y147.239 I-3.881 J1.756 E.12995
G3 X195.94 Y149.11 I-8.341 J-6.256 E.08749
G2 X194.599 Y150.982 I3.732 J4.09 E.07773
G2 X194.713 Y154.726 I3.881 J1.756 E.12995
G2 X196.524 Y156.598 I8.341 J-6.256 E.08749
G3 X197.865 Y158.47 I-3.732 J4.09 E.07773
G3 X197.751 Y162.214 I-3.881 J1.756 E.12995
G3 X195.94 Y164.086 I-8.341 J-6.256 E.08749
G2 X194.688 Y165.798 I3.402 J3.802 E.07163
G1 X193.297 Y164.408 E.06591
G1 X191.937 Y162.465 E.07948
G1 X190.934 Y160.315 E.07948
G1 X190.674 Y159.341 E.03378
G2 X190.187 Y156.496 I-3.443 J-.875 E.09961
G3 X190.183 Y154.874 I4.597 J-.823 E.05463
; WIPE_START
G1 F18423.913
G1 X190.114 Y155.662 E-.30055
G1 X190.132 Y155.87 E-.07945
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z7.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z7.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 7
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 35/82
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X218.034 Y155.662 F60000
G1 Z7
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5780
M204 S8000
G1 X217.817 Y158.148 E.08361
G1 X217.171 Y160.558 E.08361
G1 X216.116 Y162.819 E.08362
G1 X214.685 Y164.863 E.08362
G1 X212.921 Y166.628 E.08362
G1 X210.877 Y168.059 E.08361
G1 X208.615 Y169.113 E.08362
G1 X207.506 Y169.411 E.03847
G1 X206.205 Y169.759 E.04514
G1 X203.72 Y169.977 E.08361
G1 X201.234 Y169.759 E.08361
G1 X198.824 Y169.113 E.08361
G1 X196.562 Y168.059 E.08362
G1 X194.518 Y166.628 E.08362
G1 X192.754 Y164.863 E.08362
G1 X191.323 Y162.819 E.08361
G1 X190.268 Y160.558 E.08362
G1 X189.971 Y159.449 E.03847
G1 X189.622 Y158.148 E.04514
G1 X189.405 Y155.662 E.08361
G1 X189.622 Y153.176 E.08361
G1 X189.92 Y152.067 E.03847
G1 X190.268 Y150.766 E.04514
G1 X191.323 Y148.505 E.08362
G1 X192.754 Y146.461 E.08362
G1 X194.518 Y144.696 E.08361
G1 X196.562 Y143.265 E.08362
G1 X198.824 Y142.211 E.08362
G1 X201.234 Y141.565 E.08361
G1 X203.72 Y141.347 E.08361
G1 X204.863 Y141.448 E.03847
G1 X206.205 Y141.565 E.04514
G1 X208.615 Y142.211 E.08361
G1 X210.877 Y143.265 E.08362
G1 X212.921 Y144.696 E.08361
G1 X214.685 Y146.461 E.08362
G1 X216.116 Y148.505 E.08361
G1 X217.171 Y150.766 E.08362
G1 X217.817 Y153.176 E.08361
G1 X218.029 Y155.602 E.0816
; COOLING_NODE: 0
M204 S10000
G1 X218.428 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5584
M204 S5000
G1 X218.204 Y158.216 E.07958
G1 X217.541 Y160.693 E.07958
G1 X216.457 Y163.016 E.07958
G1 X214.987 Y165.116 E.07958
G1 X213.174 Y166.929 E.07958
G1 X211.074 Y168.4 E.07958
G1 X208.75 Y169.483 E.07958
G1 X207.608 Y169.789 E.0367
G1 X206.274 Y170.147 E.04288
G1 X203.72 Y170.37 E.07958
G1 X201.166 Y170.147 E.07958
G1 X198.689 Y169.483 E.07958
G1 X196.366 Y168.4 E.07958
G1 X194.265 Y166.929 E.07958
G1 X192.452 Y165.116 E.07958
G1 X190.982 Y163.016 E.07958
G1 X189.898 Y160.693 E.07958
G1 X189.592 Y159.55 E.0367
G1 X189.235 Y158.216 E.04288
G1 X189.011 Y155.662 E.07958
G1 X189.235 Y153.108 E.07958
G1 X189.541 Y151.966 E.0367
G1 X189.898 Y150.632 E.04288
G1 X190.982 Y148.308 E.07958
G1 X192.452 Y146.208 E.07958
G1 X194.265 Y144.395 E.07958
G1 X196.366 Y142.924 E.07958
G1 X198.689 Y141.841 E.07958
G1 X201.166 Y141.177 E.07958
G1 X203.72 Y140.954 E.07958
G1 X204.898 Y141.057 E.0367
G1 X206.274 Y141.177 E.04288
G1 X208.75 Y141.841 E.07958
G1 X211.074 Y142.924 E.07958
G1 X213.174 Y144.395 E.07958
G1 X214.987 Y146.208 E.07958
G1 X216.457 Y148.308 E.07958
G1 X217.541 Y150.632 E.07958
G1 X218.204 Y153.108 E.07958
G1 X218.422 Y155.602 E.07772
M204 S10000
G1 X217.632 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435622
G1 F5780
M204 S8000
G1 X217.422 Y153.256 E.07807
G1 X216.784 Y150.882 E.07949
G1 X215.773 Y148.715 E.07729
G1 X214.383 Y146.727 E.0784
G1 X212.67 Y145.011 E.07839
G1 X210.684 Y143.619 E.07839
G1 X208.487 Y142.593 E.07839
G1 X206.145 Y141.963 E.0784
G1 X203.709 Y141.75 E.07904
G1 X201.314 Y141.96 E.07773
G1 X198.971 Y142.586 E.07839
G1 X196.772 Y143.609 E.0784
G1 X194.759 Y145.021 E.0795
G1 X193.069 Y146.712 E.07729
G1 X191.676 Y148.697 E.07839
G1 X190.65 Y150.894 E.07839
G1 X190.021 Y153.236 E.07839
G1 X189.808 Y155.652 E.07839
G1 X190.017 Y158.068 E.07839
G1 X190.643 Y160.411 E.07839
G1 X191.666 Y162.609 E.0784
G1 X193.078 Y164.623 E.0795
G1 X194.769 Y166.313 E.07729
G1 X196.755 Y167.705 E.07839
G1 X198.952 Y168.732 E.07839
G1 X201.294 Y169.361 E.07839
G1 X203.709 Y169.574 E.07839
G1 X206.125 Y169.364 E.07839
G1 X208.468 Y168.739 E.07839
G1 X210.667 Y167.715 E.0784
G1 X212.68 Y166.303 E.0795
G1 X214.37 Y164.612 E.07729
G1 X215.779 Y162.597 E.07949
G1 X216.8 Y160.397 E.07839
G1 X217.418 Y158.088 E.07729
G1 X217.627 Y155.722 E.07678
M204 S10000
G1 X214.172 Y147.121 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5780
M204 S8000
G1 X213.044 Y145.95 E.05449
G3 X211.705 Y148.174 I-4.276 J-1.059 E.08831
G2 X210.001 Y150.046 I6.655 J7.772 E.08506
G2 X209.618 Y154.258 I3.957 J2.483 E.14707
G1 X209.891 Y154.726 E.01816
G2 X211.667 Y156.598 I12.691 J-10.262 E.08656
G3 X212.982 Y161.278 I-3.462 J3.497 E.17037
G3 X212.523 Y162.214 I-3.315 J-1.045 E.03506
G3 X210.747 Y164.086 I-12.691 J-10.262 E.08656
G2 X209.283 Y167.92 I3.581 J3.564 E.14165
G1 X208.341 Y168.36 E.03483
G1 X206.066 Y168.969 E.07892
G1 X203.72 Y169.174 E.07893
G1 X202.773 Y169.092 E.03183
G1 X202.513 Y168.765 E.01398
G3 X202.131 Y164.554 I3.957 J-2.483 E.14707
G1 X202.404 Y164.086 E.01816
G3 X204.18 Y162.214 I12.691 J10.262 E.08656
G2 X205.494 Y157.534 I-3.462 J-3.497 E.17036
G2 X205.035 Y156.598 I-3.314 J1.045 E.03507
G2 X203.259 Y154.726 I-12.689 J10.261 E.08656
G3 X201.945 Y150.046 I3.462 J-3.497 E.17036
G3 X202.404 Y149.11 I3.314 J1.045 E.03507
G3 X204.18 Y147.239 I12.69 J10.261 E.08656
G2 X205.39 Y142.296 I-3.355 J-3.441 E.1797
G1 X203.72 Y142.15 E.05619
G1 X201.373 Y142.355 E.07893
G1 X199.098 Y142.965 E.07892
G1 X197.904 Y143.522 E.04417
G3 X197.548 Y147.239 I-4.04 J1.489 E.12942
G3 X195.772 Y149.11 I-12.69 J-10.261 E.08656
G2 X194.457 Y153.79 I3.462 J3.497 E.17037
G2 X194.916 Y154.726 I3.314 J-1.045 E.03506
G2 X196.692 Y156.598 I12.69 J-10.261 E.08656
G3 X198.007 Y161.278 I-3.462 J3.497 E.17037
G3 X197.548 Y162.214 I-3.315 J-1.045 E.03506
G3 X195.772 Y164.086 I-12.689 J-10.261 E.08656
G1 X195.025 Y165.022 E.04011
G1 X194.702 Y165.681 E.02462
G1 X193.369 Y164.348 E.0632
G1 X192.017 Y162.418 E.07893
G1 X191.022 Y160.283 E.07893
G1 X190.663 Y158.943 E.04651
G2 X190.329 Y157.059 I-3.287 J-.389 E.06503
G1 X190.227 Y155.437 E.05447
; WIPE_START
G1 F18423.913
G1 X190.29 Y156.435 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z7.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z7.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 7.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 36/82
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.941 Y155.662 F60000
G1 Z7.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5587
M204 S8000
G1 X217.725 Y158.132 E.08307
G1 X217.083 Y160.526 E.08307
G1 X216.036 Y162.773 E.08307
G1 X214.614 Y164.803 E.08307
G1 X212.861 Y166.556 E.08307
G1 X211.764 Y167.324 E.04488
M73 P69 R4
G1 X210.83 Y167.978 E.03819
G1 X208.583 Y169.026 E.08307
G1 X206.189 Y169.667 E.08307
G1 X203.72 Y169.883 E.08307
G1 X201.25 Y169.667 E.08307
G1 X198.856 Y169.026 E.08307
G1 X196.609 Y167.978 E.08307
G1 X194.578 Y166.556 E.08307
G1 X192.825 Y164.803 E.08307
G1 X192.057 Y163.706 E.04488
G1 X191.404 Y162.773 E.03819
G1 X190.356 Y160.526 E.08307
G1 X189.714 Y158.132 E.08307
G1 X189.498 Y155.662 E.08307
G1 X189.714 Y153.193 E.08307
G1 X190.356 Y150.798 E.08307
G1 X191.404 Y148.551 E.08307
G1 X192.825 Y146.521 E.08307
G1 X194.578 Y144.768 E.08307
G1 X196.609 Y143.346 E.08307
G1 X198.856 Y142.298 E.08307
G1 X201.25 Y141.657 E.08307
G1 X203.72 Y141.441 E.08307
G1 X205.054 Y141.557 E.04488
G1 X206.189 Y141.657 E.03819
G1 X208.583 Y142.298 E.08307
G1 X210.83 Y143.346 E.08307
G1 X212.861 Y144.768 E.08307
G1 X214.614 Y146.521 E.08307
G1 X216.036 Y148.551 E.08307
G1 X217.083 Y150.798 E.08307
G1 X217.43 Y152.092 E.04488
G1 X217.725 Y153.193 E.03819
G1 X217.936 Y155.602 E.08106
; COOLING_NODE: 0
M204 S10000
G1 X218.334 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5559
M204 S5000
G1 X218.112 Y158.2 E.07908
G1 X217.453 Y160.661 E.07908
G1 X216.376 Y162.969 E.07908
G1 X214.915 Y165.056 E.07908
G1 X213.114 Y166.858 E.07908
G1 X211.027 Y168.319 E.07908
G1 X208.718 Y169.396 E.07908
G1 X206.257 Y170.055 E.07908
G1 X203.72 Y170.277 E.07908
G1 X201.182 Y170.055 E.07908
G1 X198.721 Y169.396 E.07908
G1 X196.412 Y168.319 E.07908
G1 X194.325 Y166.858 E.07908
G1 X192.524 Y165.056 E.07908
G1 X191.063 Y162.969 E.07908
G1 X189.986 Y160.661 E.07908
G1 X189.327 Y158.2 E.07908
G1 X189.105 Y155.662 E.07908
G1 X189.327 Y153.124 E.07908
G1 X189.986 Y150.663 E.07908
G1 X191.063 Y148.355 E.07908
G1 X192.524 Y146.268 E.07908
G1 X194.325 Y144.466 E.07908
G1 X196.412 Y143.005 E.07908
G1 X198.721 Y141.929 E.07908
G1 X201.182 Y141.269 E.07908
G1 X203.72 Y141.047 E.07908
G1 X205.088 Y141.167 E.04264
G1 X206.257 Y141.269 E.03644
G1 X208.718 Y141.929 E.07908
G1 X211.027 Y143.005 E.07908
G1 X213.114 Y144.466 E.07908
G1 X214.915 Y146.268 E.07908
G1 X216.376 Y148.355 E.07908
G1 X217.453 Y150.663 E.07908
G1 X217.809 Y151.99 E.04264
G1 X218.112 Y153.124 E.03644
G1 X218.329 Y155.602 E.07722
M204 S10000
G1 X217.539 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435624
G1 F5587
M204 S8000
G1 X217.33 Y153.272 E.07754
G1 X216.696 Y150.914 E.07896
G1 X215.692 Y148.762 E.07677
G1 X214.312 Y146.787 E.07787
G1 X212.61 Y145.083 E.07787
G1 X210.638 Y143.7 E.07787
G1 X208.455 Y142.68 E.07787
G1 X206.129 Y142.055 E.07787
G1 X203.709 Y141.843 E.07852
G1 X201.33 Y142.052 E.07721
G1 X199.003 Y142.673 E.07787
G1 X196.819 Y143.69 E.07787
G1 X194.819 Y145.092 E.07897
G1 X193.14 Y146.772 E.07676
G1 X191.757 Y148.744 E.07787
G1 X190.738 Y150.926 E.07787
G1 X190.113 Y153.253 E.07787
G1 X189.901 Y155.652 E.07787
G1 X190.109 Y158.052 E.07786
G1 X190.731 Y160.379 E.07786
G1 X191.747 Y162.563 E.07787
G1 X193.15 Y164.563 E.07897
G1 X194.829 Y166.241 E.07676
G1 X196.801 Y167.624 E.07787
G1 X198.984 Y168.644 E.07787
G1 X201.31 Y169.269 E.07787
G1 X203.71 Y169.481 E.07787
G1 X206.109 Y169.273 E.07786
G1 X208.436 Y168.651 E.07786
G1 X210.62 Y167.634 E.07787
G1 X212.62 Y166.232 E.07897
G1 X214.299 Y164.552 E.07676
G1 X215.698 Y162.55 E.07897
G1 X216.713 Y160.365 E.07786
G1 X217.327 Y158.072 E.07677
G1 X217.534 Y155.722 E.07626
M204 S10000
G1 X214.066 Y147.131 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5587
M204 S8000
G1 X212.93 Y145.967 E.05451
G1 X212.849 Y146.303 E.01157
G1 X212.334 Y147.239 E.0358
G3 X210.58 Y149.11 I-21.355 J-18.251 E.08599
G2 X209.565 Y153.79 I3.516 J3.212 E.16813
G2 X210.917 Y155.662 I4.741 J-2 E.07804
G3 X212.516 Y157.534 I-5.564 J6.369 E.08278
G3 X212.334 Y162.214 I-3.94 J2.19 E.16502
G3 X210.58 Y164.086 I-21.353 J-18.248 E.08599
G2 X209.339 Y167.791 I3.421 J3.206 E.13508
G1 X208.309 Y168.272 E.0381
G1 X206.05 Y168.877 E.07838
G1 X203.72 Y169.081 E.07839
G1 X202.568 Y168.98 E.03875
G3 X202.593 Y164.086 I3.579 J-2.429 E.17435
G3 X204.347 Y162.214 I21.358 J18.253 E.08599
G2 X205.361 Y157.534 I-3.516 J-3.212 E.16813
G2 X204.009 Y155.662 I-4.741 J2 E.07804
G3 X202.411 Y153.79 I5.565 J-6.369 E.08278
G3 X202.593 Y149.11 I3.94 J-2.19 E.16502
G3 X204.347 Y147.239 I21.355 J18.251 E.08599
G2 X205.361 Y142.559 I-3.516 J-3.212 E.16813
G1 X205.262 Y142.378 E.00692
G1 X203.72 Y142.243 E.05187
G1 X201.389 Y142.447 E.07839
G1 X199.13 Y143.052 E.07838
G1 X197.957 Y143.599 E.04338
G3 X197.874 Y146.303 I-4.776 J1.206 E.09181
G3 X196.522 Y148.174 I-4.741 J-2 E.07804
G2 X194.923 Y150.046 I5.564 J6.369 E.08278
G2 X195.105 Y154.726 I3.94 J2.19 E.16502
G2 X196.859 Y156.598 I21.358 J-18.253 E.08599
G3 X197.874 Y161.278 I-3.516 J3.212 E.16813
G3 X196.522 Y163.15 I-4.741 J-2 E.07804
G2 X194.923 Y165.022 I5.565 J6.369 E.08278
G1 X194.7 Y165.548 E.01916
G1 X193.549 Y164.397 E.05457
; WIPE_START
G1 F18423.913
G1 X194.256 Y165.104 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z7.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z7.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 37/82
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.848 Y155.662 F60000
G1 Z7.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5546
M204 S8000
G1 X217.633 Y158.115 E.08252
G1 X216.996 Y160.494 E.08252
G1 X215.955 Y162.726 E.08253
G1 X214.542 Y164.743 E.08253
G1 X212.801 Y166.485 E.08252
G1 X210.784 Y167.897 E.08253
G1 X208.552 Y168.938 E.08253
G1 X206.173 Y169.575 E.08252
G1 X203.72 Y169.79 E.08253
G1 X201.266 Y169.575 E.08252
G1 X198.888 Y168.938 E.08252
G1 X196.656 Y167.897 E.08253
G1 X194.638 Y166.485 E.08253
G1 X192.897 Y164.743 E.08252
G1 X192.019 Y163.49 E.05128
G1 X191.484 Y162.726 E.03124
G1 X190.444 Y160.494 E.08253
G1 X189.806 Y158.115 E.08252
G1 X189.592 Y155.662 E.08252
G1 X189.806 Y153.209 E.08252
G1 X190.444 Y150.83 E.08252
G1 X191.484 Y148.598 E.08253
G1 X192.897 Y146.581 E.08253
G1 X194.638 Y144.839 E.08252
G1 X196.656 Y143.427 E.08253
G1 X198.888 Y142.386 E.08253
G1 X201.266 Y141.749 E.08252
G1 X203.72 Y141.534 E.08252
G1 X205.244 Y141.667 E.05128
G1 X206.173 Y141.749 E.03124
G1 X208.552 Y142.386 E.08252
G1 X210.784 Y143.427 E.08253
G1 X212.801 Y144.839 E.08253
G1 X214.542 Y146.581 E.08252
G1 X215.955 Y148.598 E.08253
G1 X216.996 Y150.83 E.08253
G1 X217.392 Y152.308 E.05128
G1 X217.633 Y153.209 E.03124
G1 X217.842 Y155.602 E.08051
; COOLING_NODE: 0
M204 S10000
G1 X218.241 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5531
M204 S5000
G1 X218.021 Y158.184 E.07857
G1 X217.365 Y160.629 E.07857
G1 X216.296 Y162.923 E.07857
G1 X214.844 Y164.996 E.07857
G1 X213.054 Y166.786 E.07857
G1 X210.98 Y168.238 E.07857
G1 X208.686 Y169.308 E.07857
G1 X206.241 Y169.963 E.07857
G1 X203.72 Y170.184 E.07857
G1 X201.198 Y169.963 E.07857
G1 X198.753 Y169.308 E.07857
G1 X196.459 Y168.238 E.07857
G1 X194.385 Y166.786 E.07857
G1 X192.595 Y164.996 E.07857
G1 X191.698 Y163.715 E.04857
G1 X191.143 Y162.923 E.03001
G1 X190.074 Y160.629 E.07857
G1 X189.419 Y158.184 E.07857
G1 X189.198 Y155.662 E.07857
G1 X189.419 Y153.14 E.07857
G1 X190.074 Y150.695 E.07857
G1 X191.143 Y148.401 E.07857
G1 X192.595 Y146.328 E.07857
G1 X194.385 Y144.538 E.07857
G1 X196.459 Y143.086 E.07857
G1 X198.753 Y142.016 E.07857
G1 X201.198 Y141.361 E.07857
G1 X203.72 Y141.14 E.07857
G1 X205.278 Y141.277 E.04857
G1 X206.241 Y141.361 E.03
G1 X208.686 Y142.016 E.07857
G1 X210.98 Y143.086 E.07857
G1 X213.054 Y144.538 E.07857
G1 X214.844 Y146.328 E.07857
G1 X216.296 Y148.401 E.07857
G1 X217.365 Y150.695 E.07857
G1 X217.77 Y152.207 E.04857
G1 X218.021 Y153.14 E.03
G1 X218.236 Y155.602 E.07671
M204 S10000
G1 X217.446 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435628
G1 F5546
M204 S8000
G1 X217.238 Y153.289 E.07702
G1 X216.608 Y150.945 E.07844
G1 X215.611 Y148.808 E.07624
G1 X214.24 Y146.847 E.07735
G1 X212.55 Y145.154 E.07734
G1 X210.591 Y143.781 E.07734
G1 X208.423 Y142.768 E.07734
G1 X206.113 Y142.147 E.07734
G1 X203.709 Y141.937 E.078
G1 X201.346 Y142.143 E.07668
G1 X199.035 Y142.761 E.07735
G1 X196.866 Y143.77 E.07734
G1 X194.879 Y145.164 E.07845
G1 X193.212 Y146.832 E.07624
G1 X191.838 Y148.791 E.07734
G1 X190.825 Y150.958 E.07734
G1 X190.204 Y153.269 E.07734
G1 X189.994 Y155.652 E.07734
G1 X190.201 Y158.035 E.07734
G1 X190.818 Y160.347 E.07734
G1 X191.828 Y162.516 E.07735
G1 X193.221 Y164.503 E.07845
G1 X194.889 Y166.17 E.07624
G1 X196.848 Y167.544 E.07734
G1 X199.016 Y168.556 E.07734
G1 X201.326 Y169.177 E.07734
G1 X203.709 Y169.387 E.07734
G1 X206.093 Y169.181 E.07734
G1 X208.404 Y168.563 E.07734
G1 X210.574 Y167.554 E.07735
G1 X212.56 Y166.16 E.07844
G1 X214.227 Y164.492 E.07624
G1 X215.618 Y162.504 E.07844
G1 X216.625 Y160.334 E.07734
G1 X217.235 Y158.055 E.07624
G1 X217.441 Y155.722 E.07573
M204 S10000
G1 X213.964 Y147.148 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5546
M204 S8000
G1 X212.821 Y145.989 E.05453
G1 X212.725 Y146.303 E.01097
G1 X212.154 Y147.239 E.03674
G3 X210.411 Y149.11 I-68.85 J-62.371 E.08572
G2 X210.26 Y154.726 I3.36 J2.9 E.20383
G2 X212.003 Y156.598 I68.824 J-62.347 E.08572
G3 X212.154 Y162.214 I-3.36 J2.9 E.20383
G3 X210.411 Y164.086 I-68.824 J-62.347 E.08572
G2 X209.392 Y167.664 I3.328 J2.882 E.12875
G1 X208.277 Y168.184 E.04121
M73 P69 R3
G1 X206.034 Y168.785 E.07783
M73 P70 R3
G1 X203.72 Y168.988 E.07784
G1 X202.372 Y168.87 E.04533
G3 X202.772 Y164.086 I3.82 J-2.089 E.17041
G3 X204.516 Y162.214 I68.824 J62.347 E.08572
G2 X204.667 Y156.598 I-3.36 J-2.9 E.20383
G2 X202.924 Y154.726 I-68.824 J62.347 E.08572
G3 X202.772 Y149.11 I3.36 J-2.9 E.20383
G3 X204.516 Y147.239 I68.797 J62.322 E.08572
G2 X205.238 Y142.559 I-3.582 J-2.948 E.16652
G1 X205.18 Y142.464 E.00372
G1 X203.72 Y142.336 E.04913
G1 X201.406 Y142.539 E.07784
G1 X199.162 Y143.14 E.07783
G1 X198.009 Y143.677 E.04263
G3 X197.179 Y147.239 I-4.151 J.91 E.12666
G3 X195.436 Y149.11 I-68.906 J-62.424 E.08572
G2 X195.285 Y154.726 I3.36 J2.9 E.20383
G2 X197.028 Y156.598 I68.88 J-62.399 E.08572
G3 X198.035 Y160.342 I-3.468 J2.94 E.13421
G3 X196.32 Y163.15 I-5.18 J-1.237 E.1121
G2 X194.815 Y165.022 I4.674 J5.298 E.08087
G1 X194.68 Y165.396 E.01335
G1 X193.529 Y164.245 E.05457
; WIPE_START
G1 F18423.913
G1 X194.236 Y164.952 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z7.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z7.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 7.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 38/82
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.754 Y155.662 F60000
G1 Z7.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5510
M204 S8000
G1 X217.541 Y158.099 E.08198
G1 X216.908 Y160.462 E.08198
G1 X215.874 Y162.679 E.08198
G1 X214.471 Y164.683 E.08198
G1 X212.741 Y166.413 E.08198
G1 X211.331 Y167.401 E.05769
G1 X210.737 Y167.817 E.02429
G1 X208.52 Y168.85 E.08198
G1 X206.157 Y169.484 E.08198
G1 X203.72 Y169.697 E.08198
G1 X201.282 Y169.484 E.08198
G1 X198.919 Y168.85 E.08198
G1 X196.702 Y167.817 E.08198
G1 X194.698 Y166.413 E.08198
G1 X192.968 Y164.683 E.08198
G1 X191.981 Y163.273 E.05769
G1 X191.565 Y162.679 E.02429
G1 X190.531 Y160.462 E.08198
G1 X189.898 Y158.099 E.08198
G1 X189.685 Y155.662 E.08198
G1 X189.898 Y153.225 E.08198
G1 X190.531 Y150.862 E.08198
G1 X191.565 Y148.645 E.08198
G1 X192.968 Y146.641 E.08198
G1 X194.698 Y144.911 E.08198
G1 X196.702 Y143.508 E.08198
G1 X198.919 Y142.474 E.08198
G1 X201.282 Y141.84 E.08198
G1 X203.72 Y141.627 E.08198
G1 X205.434 Y141.777 E.05769
G1 X206.157 Y141.84 E.02429
G1 X208.52 Y142.474 E.08198
G1 X210.737 Y143.508 E.08198
G1 X212.741 Y144.911 E.08198
G1 X214.471 Y146.641 E.08198
G1 X215.874 Y148.645 E.08198
G1 X216.908 Y150.862 E.08198
G1 X217.541 Y153.225 E.08198
G1 X217.749 Y155.602 E.07997
; COOLING_NODE: 0
M204 S10000
G1 X218.148 Y155.661 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5501
M204 S5000
G1 X218.148 Y155.662 E.00003
G1 X217.929 Y158.168 E.07807
G1 X217.278 Y160.597 E.07807
G1 X216.215 Y162.876 E.07807
G1 X214.772 Y164.936 E.07807
G1 X212.994 Y166.715 E.07807
G1 X211.556 Y167.722 E.0545
G1 X210.934 Y168.157 E.02357
G1 X208.654 Y169.22 E.07807
G1 X206.225 Y169.871 E.07807
G1 X203.72 Y170.09 E.07807
G1 X201.214 Y169.871 E.07807
G1 X198.785 Y169.22 E.07807
G1 X196.505 Y168.157 E.07807
G1 X194.445 Y166.715 E.07807
G1 X192.667 Y164.936 E.07807
G1 X191.224 Y162.876 E.07807
G1 X190.161 Y160.597 E.07807
G1 X189.51 Y158.168 E.07807
G1 X189.291 Y155.662 E.07807
G1 X189.51 Y153.157 E.07807
G1 X190.161 Y150.727 E.07807
G1 X191.224 Y148.448 E.07807
G1 X192.667 Y146.388 E.07807
G1 X194.445 Y144.609 E.07807
G1 X196.505 Y143.167 E.07807
G1 X198.785 Y142.104 E.07807
G1 X201.214 Y141.453 E.07807
G1 X203.72 Y141.234 E.07807
G1 X205.469 Y141.387 E.0545
G1 X206.225 Y141.453 E.02357
G1 X208.654 Y142.104 E.07807
G1 X210.934 Y143.167 E.07807
G1 X212.994 Y144.609 E.07807
G1 X214.772 Y146.388 E.07807
G1 X216.215 Y148.448 E.07807
G1 X217.278 Y150.727 E.07807
G1 X217.929 Y153.157 E.07807
G1 X218.143 Y155.601 E.07618
M204 S10000
G1 X217.347 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.447271
G1 F5510
M204 S8000
G1 X217.141 Y153.306 E.07871
G1 X216.515 Y150.979 E.08022
G1 X215.526 Y148.858 E.07789
G1 X214.165 Y146.911 E.07907
G1 X212.486 Y145.23 E.07906
G1 X210.542 Y143.867 E.07906
G1 X208.39 Y142.861 E.07906
G1 X206.096 Y142.245 E.07906
G1 X203.709 Y142.036 E.07977
G1 X201.364 Y142.241 E.07835
G1 X199.069 Y142.854 E.07906
G1 X196.916 Y143.856 E.07907
G1 X194.942 Y145.24 E.08023
G1 X193.288 Y146.895 E.07789
G1 X191.924 Y148.84 E.07906
G1 X190.919 Y150.992 E.07906
G1 X190.302 Y153.285 E.07906
G1 X190.093 Y155.651 E.07906
G1 X190.298 Y158.018 E.07906
G1 X190.911 Y160.312 E.07906
G1 X191.914 Y162.466 E.07907
G1 X193.298 Y164.439 E.08023
G1 X194.953 Y166.094 E.07789
G1 X196.897 Y167.457 E.07906
G1 X199.049 Y168.463 E.07906
G1 X201.343 Y169.079 E.07906
G1 X203.709 Y169.288 E.07906
G1 X206.075 Y169.083 E.07906
G1 X208.37 Y168.47 E.07906
G1 X210.523 Y167.468 E.07907
G1 X212.497 Y166.084 E.08023
G1 X214.151 Y164.429 E.07789
G1 X215.532 Y162.454 E.08023
G1 X216.532 Y160.299 E.07906
G1 X217.137 Y158.039 E.07789
G1 X217.342 Y155.722 E.07742
M204 S10000
G1 X213.86 Y147.182 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5510
M204 S8000
G1 X212.711 Y146.028 E.05455
G1 X212.61 Y146.303 E.00981
G3 X211.095 Y148.174 I-6.291 J-3.544 E.08109
G2 X209.397 Y150.982 I3.407 J3.978 E.11184
G2 X210.432 Y154.726 I4.497 J.771 E.13446
G3 X212.176 Y156.598 I-52.042 J50.234 E.08574
G3 X211.982 Y162.214 I-3.543 J2.689 E.20381
G2 X210.238 Y164.086 I52.042 J50.234 E.08574
G2 X209.42 Y167.536 I3.239 J2.59 E.12278
G1 X208.241 Y168.086 E.0436
G1 X206.015 Y168.682 E.07722
G1 X203.72 Y168.883 E.07723
G1 X202.181 Y168.748 E.05174
G3 X202.945 Y164.086 I4.331 J-1.685 E.16609
G2 X204.689 Y162.214 I-52.042 J-50.234 E.08574
G2 X204.494 Y156.598 I-3.543 J-2.689 E.20381
G3 X202.75 Y154.726 I52.026 J-50.218 E.08574
G3 X202.945 Y149.11 I3.543 J-2.689 E.20381
G2 X204.689 Y147.239 I-52.058 J-50.249 E.08574
G2 X205.125 Y142.564 I-3.664 J-2.699 E.16529
G1 X203.719 Y142.441 E.04727
G1 X201.424 Y142.642 E.07723
G1 X199.198 Y143.238 E.07722
G1 X198.061 Y143.769 E.04204
G3 X197.007 Y147.239 I-4.363 J.57 E.12526
G2 X195.263 Y149.11 I52.044 J50.235 E.08574
G2 X195.457 Y154.726 I3.543 J2.689 E.20381
G3 X197.201 Y156.598 I-52.06 J50.25 E.08574
G3 X197.007 Y162.214 I-3.543 J2.689 E.20381
G2 X195.263 Y164.086 I52.06 J50.25 E.08574
G1 X194.699 Y165.022 E.03662
G1 X194.643 Y165.211 E.00663
G1 X193.51 Y164.044 E.0545
; WIPE_START
G1 F18423.913
G1 X194.207 Y164.762 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 7.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 39/82
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.661 Y155.662 F60000
G1 Z7.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5471
M204 S8000
G1 X217.449 Y158.083 E.08144
G1 X216.82 Y160.43 E.08143
G1 X215.793 Y162.633 E.08144
G1 X214.399 Y164.623 E.08144
G1 X212.681 Y166.342 E.08143
G1 X210.69 Y167.736 E.08144
G1 X208.488 Y168.763 E.08144
G1 X206.64 Y169.258 E.06409
G1 X206.14 Y169.392 E.01734
G1 X203.72 Y169.604 E.08144
G1 X201.299 Y169.392 E.08144
G1 X198.951 Y168.763 E.08143
G1 X196.749 Y167.736 E.08144
G1 X194.758 Y166.342 E.08144
G1 X193.04 Y164.623 E.08143
G1 X191.646 Y162.633 E.08144
G1 X190.619 Y160.43 E.08144
G1 X190.124 Y158.583 E.06409
G1 X189.99 Y158.083 E.01734
G1 X189.778 Y155.662 E.08144
G1 X189.99 Y153.241 E.08144
G1 X190.619 Y150.894 E.08143
G1 X191.646 Y148.691 E.08144
G1 X193.04 Y146.701 E.08144
G1 X194.758 Y144.982 E.08143
G1 X196.749 Y143.588 E.08144
G1 X198.951 Y142.561 E.08144
G1 X201.299 Y141.932 E.08143
G1 X203.72 Y141.721 E.08144
G1 X205.625 Y141.887 E.06409
G1 X206.14 Y141.932 E.01734
G1 X208.488 Y142.561 E.08143
G1 X210.69 Y143.588 E.08144
G1 X212.681 Y144.982 E.08144
G1 X214.399 Y146.701 E.08143
G1 X215.793 Y148.691 E.08144
G1 X216.82 Y150.894 E.08144
G1 X217.315 Y152.741 E.06409
G1 X217.449 Y153.241 E.01734
G1 X217.656 Y155.602 E.07943
; COOLING_NODE: 0
M204 S10000
G1 X218.054 Y155.658 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5471
M204 S5000
G1 X218.055 Y155.662 E.00013
G1 X217.837 Y158.151 E.07756
G1 X217.19 Y160.565 E.07756
G1 X216.134 Y162.83 E.07756
G1 X214.701 Y164.876 E.07757
G1 X212.934 Y166.643 E.07756
G1 X210.887 Y168.077 E.07757
G1 X208.622 Y169.133 E.07756
G1 X206.742 Y169.637 E.06043
G1 X206.209 Y169.779 E.01713
G1 X203.72 Y169.997 E.07756
G1 X201.23 Y169.779 E.07756
G1 X198.817 Y169.133 E.07756
G1 X196.552 Y168.077 E.07756
G1 X194.505 Y166.643 E.07757
G1 X192.738 Y164.876 E.07756
G1 X191.305 Y162.83 E.07757
G1 X190.249 Y160.565 E.07756
G1 X189.745 Y158.684 E.06043
G1 X189.602 Y158.151 E.01713
G1 X189.384 Y155.662 E.07756
G1 X189.602 Y153.173 E.07756
G1 X190.249 Y150.759 E.07756
G1 X191.305 Y148.495 E.07756
G1 X192.738 Y146.448 E.07757
G1 X194.505 Y144.681 E.07756
G1 X196.552 Y143.247 E.07757
G1 X198.817 Y142.191 E.07756
G1 X201.23 Y141.545 E.07756
G1 X203.72 Y141.327 E.07756
G1 X205.659 Y141.497 E.06043
G1 X206.209 Y141.545 E.01713
G1 X208.622 Y142.191 E.07756
G1 X210.887 Y143.247 E.07756
G1 X212.934 Y144.681 E.07757
G1 X214.701 Y146.448 E.07756
G1 X216.134 Y148.495 E.07757
G1 X217.19 Y150.759 E.07756
G1 X217.694 Y152.64 E.06043
G1 X217.837 Y153.173 E.01713
G1 X218.049 Y155.598 E.07557
M204 S10000
G1 X217.23 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.493879
G1 F5471
M204 S8000
G1 X217.026 Y153.329 E.08695
G1 X216.405 Y151.017 E.08887
G1 X215.425 Y148.918 E.08596
G1 X214.077 Y146.988 E.08742
G1 X212.413 Y145.321 E.08742
G1 X210.485 Y143.969 E.08742
G1 X208.352 Y142.972 E.08742
G1 X206.078 Y142.36 E.08742
G1 X203.707 Y142.153 E.08836
M73 P71 R3
G1 X201.386 Y142.356 E.08647
G1 X199.111 Y142.963 E.08742
G1 X196.976 Y143.956 E.08742
G1 X195.016 Y145.331 E.08887
G1 X193.379 Y146.969 E.08596
G1 X192.026 Y148.896 E.08742
G1 X191.029 Y151.03 E.08742
G1 X190.418 Y153.304 E.08742
G1 X190.21 Y155.649 E.08742
G1 X190.413 Y157.995 E.08741
G1 X191.02 Y160.271 E.08742
G1 X192.014 Y162.406 E.08742
G1 X193.388 Y164.366 E.08888
G1 X195.026 Y166.003 E.08595
G1 X196.954 Y167.355 E.08742
G1 X199.087 Y168.352 E.08742
G1 X201.361 Y168.964 E.08742
G1 X203.707 Y169.172 E.08742
G1 X206.053 Y168.968 E.08741
G1 X208.328 Y168.361 E.08742
G1 X210.463 Y167.368 E.08742
G1 X212.423 Y165.993 E.08888
G1 X214.06 Y164.356 E.08595
G1 X215.432 Y162.393 E.08887
G1 X216.423 Y160.257 E.08741
G1 X217.022 Y158.02 E.08596
G1 X217.225 Y155.722 E.08566
M204 S10000
G1 X213.74 Y147.254 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5471
M204 S8000
G1 X212.589 Y146.103 E.05457
G1 X212.503 Y146.303 E.00729
G3 X210.892 Y148.174 I-7.298 J-4.651 E.08304
G2 X209.331 Y150.982 I3.253 J3.646 E.10969
G2 X210.601 Y154.726 I4.708 J.491 E.13666
G3 X212.357 Y156.598 I-17.932 J18.581 E.08604
G3 X212.503 Y161.278 I-3.711 J2.458 E.16521
G3 X210.892 Y163.15 I-7.298 J-4.651 E.08304
G2 X209.331 Y165.957 I3.253 J3.646 E.10969
G2 X209.42 Y167.382 I3.575 J.492 E.04815
G1 X208.193 Y167.954 E.04536
G1 X205.991 Y168.544 E.0764
G1 X203.72 Y168.743 E.07641
G1 X202.022 Y168.594 E.0571
G3 X203.113 Y164.086 I4.56 J-1.283 E.16245
G2 X204.869 Y162.214 I-17.932 J-18.581 E.08604
G2 X205.015 Y157.534 I-3.711 J-2.458 E.16521
G2 X203.404 Y155.662 I-7.298 J4.651 E.08304
G3 X201.844 Y152.854 I3.254 J-3.646 E.10969
G3 X203.113 Y149.11 I4.708 J-.491 E.13666
G2 X204.869 Y147.239 I-17.934 J-18.583 E.08604
G2 X205.076 Y142.7 I-3.72 J-2.444 E.15978
G1 X203.72 Y142.581 E.04563
G1 X201.448 Y142.78 E.07641
G1 X199.246 Y143.37 E.0764
G1 X198.111 Y143.899 E.04197
G3 X196.839 Y147.239 I-4.623 J.151 E.12294
G2 X195.083 Y149.11 I17.93 J18.579 E.08604
G2 X194.936 Y153.79 I3.711 J2.458 E.16521
G2 X196.547 Y155.662 I7.298 J-4.651 E.08304
G3 X198.108 Y158.47 I-3.253 J3.646 E.10969
G3 X196.839 Y162.214 I-4.708 J.491 E.13666
G2 X195.083 Y164.086 I17.932 J18.581 E.08604
G1 X194.601 Y164.972 E.03381
G1 X193.699 Y164.07 E.04274
G1 X193.497 Y163.781 E.01182
; WIPE_START
G1 F18423.913
G1 X193.699 Y164.07 E-.13407
G1 X194.157 Y164.528 E-.24593
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z8.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z8.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 40/82
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.568 Y155.662 F60000
G1 Z8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5481
M204 S8000
G1 X217.357 Y158.067 E.08089
G1 X216.733 Y160.398 E.08089
G1 X215.713 Y162.586 E.08089
G1 X214.328 Y164.564 E.08089
G1 X212.621 Y166.27 E.08089
G1 X210.898 Y167.477 E.0705
G1 X210.644 Y167.655 E.0104
G1 X208.456 Y168.675 E.08089
G1 X206.124 Y169.3 E.08089
G1 X203.72 Y169.51 E.08089
G1 X201.315 Y169.3 E.08089
G1 X198.983 Y168.675 E.08089
G1 X196.795 Y167.655 E.08089
G1 X194.818 Y166.27 E.08089
G1 X193.111 Y164.564 E.08089
G1 X191.905 Y162.84 E.0705
G1 X191.727 Y162.586 E.0104
G1 X190.706 Y160.398 E.08089
G1 X190.082 Y158.067 E.08089
G1 X189.871 Y155.662 E.08089
G1 X190.082 Y153.257 E.08089
G1 X190.706 Y150.926 E.08089
G1 X191.727 Y148.738 E.08089
G1 X193.111 Y146.761 E.08089
G1 X194.818 Y145.054 E.08089
G1 X196.795 Y143.669 E.08089
G1 X198.983 Y142.649 E.08089
G1 X201.315 Y142.024 E.08089
G1 X203.72 Y141.814 E.08089
G1 X205.815 Y141.997 E.0705
G1 X206.124 Y142.024 E.01039
G1 X208.456 Y142.649 E.08089
G1 X210.644 Y143.669 E.08089
G1 X212.621 Y145.054 E.08089
G1 X214.328 Y146.761 E.08089
G1 X215.713 Y148.738 E.08089
G1 X216.733 Y150.926 E.08089
G1 X217.357 Y153.257 E.08089
G1 X217.563 Y155.602 E.07888
; COOLING_NODE: 0
M204 S10000
G1 X217.961 Y155.654 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5442
M204 S5000
G1 X217.961 Y155.662 E.00024
G1 X217.745 Y158.135 E.07706
G1 X217.103 Y160.533 E.07706
G1 X216.053 Y162.783 E.07706
G1 X214.629 Y164.817 E.07706
G1 X212.874 Y166.572 E.07706
G1 X211.123 Y167.798 E.06637
G1 X210.84 Y167.996 E.0107
G1 X208.591 Y169.045 E.07706
G1 X206.193 Y169.688 E.07706
G1 X203.72 Y169.904 E.07706
G1 X201.246 Y169.688 E.07706
G1 X198.849 Y169.045 E.07706
G1 X196.599 Y167.996 E.07706
G1 X194.565 Y166.572 E.07706
G1 X192.81 Y164.817 E.07706
G1 X191.583 Y163.065 E.06637
G1 X191.386 Y162.783 E.0107
G1 X190.337 Y160.533 E.07706
G1 X189.694 Y158.135 E.07706
G1 X189.478 Y155.662 E.07706
G1 X189.694 Y153.189 E.07706
G1 X190.337 Y150.791 E.07706
G1 X191.386 Y148.541 E.07706
G1 X192.81 Y146.508 E.07706
G1 X194.565 Y144.752 E.07706
G1 X196.599 Y143.328 E.07706
G1 X198.849 Y142.279 E.07706
G1 X201.246 Y141.637 E.07706
G1 X203.72 Y141.42 E.07706
G1 X205.849 Y141.607 E.06637
G1 X206.193 Y141.637 E.01069
G1 X208.591 Y142.279 E.07706
G1 X210.84 Y143.328 E.07706
G1 X212.874 Y144.752 E.07706
G1 X214.629 Y146.508 E.07706
G1 X216.053 Y148.541 E.07706
G1 X217.103 Y150.791 E.07706
G1 X217.745 Y153.189 E.07706
G1 X217.956 Y155.595 E.07496
; WIPE_START
G1 F12000
M204 S8000
G1 X217.961 Y155.662 E-.02568
G1 X217.88 Y156.591 E-.35432
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z8.4 I1.166 J-.348 P1  F60000
G1 X216.91 Y153.336 Z8.4
G1 Z8
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.540482
G1 F5481
M204 S8000
G1 X216.31 Y151.095 E.09501
G1 X215.325 Y148.978 E.09562
G1 X213.988 Y147.065 E.09562
G1 X212.306 Y145.385 E.09738
G1 X210.429 Y144.071 E.09384
G1 X208.314 Y143.082 E.09562
G1 X206.06 Y142.475 E.09562
G1 X203.705 Y142.269 E.09682
G1 X201.409 Y142.47 E.09441
G1 X199.153 Y143.072 E.09562
G1 X197.036 Y144.056 E.09562
G1 X195.122 Y145.393 E.09563
G1 X193.442 Y147.076 E.09738
G1 X192.129 Y148.953 E.09384
G1 X191.14 Y151.068 E.09562
G1 X190.533 Y153.322 E.09562
G1 X190.327 Y155.647 E.09562
G1 X190.528 Y157.973 E.09561
G1 X191.13 Y160.229 E.09561
G1 X192.114 Y162.346 E.09562
G1 X193.451 Y164.26 E.09562
G1 X195.133 Y165.939 E.09738
G1 X197.011 Y167.253 E.09385
G1 X199.125 Y168.242 E.09562
G1 X201.38 Y168.849 E.09562
G1 X203.705 Y169.055 E.09562
G1 X206.031 Y168.854 E.09561
G1 X208.286 Y168.252 E.09561
G1 X210.403 Y167.268 E.09562
G1 X212.317 Y165.931 E.09563
G1 X213.997 Y164.248 E.09737
G1 X215.311 Y162.371 E.09385
G1 X216.314 Y160.215 E.09738
G1 X216.913 Y157.959 E.09561
G1 X217.112 Y155.677 E.09385
G1 X216.915 Y153.396 E.09376
M204 S10000
G1 X213.616 Y147.327 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5481
M204 S8000
G1 X212.465 Y146.176 E.05457
G1 X212.401 Y146.303 E.00475
G3 X210.682 Y148.174 I-8.525 J-6.104 E.08537
G1 X209.867 Y149.11 E.0416
G2 X209.547 Y152.854 I3.702 J2.202 E.13029
G2 X210.768 Y154.726 I4.865 J-1.84 E.07548
G3 X212.547 Y156.598 I-10.298 J11.572 E.08665
G3 X212.868 Y160.342 I-3.702 J2.202 E.13029
G3 X211.647 Y162.214 I-4.865 J-1.84 E.07548
G2 X209.867 Y164.086 I10.298 J11.572 E.08665
G2 X209.396 Y167.239 I3.539 J2.141 E.1097
G1 X208.145 Y167.822 E.04623
G1 X205.967 Y168.406 E.07558
G1 X203.72 Y168.603 E.07559
G1 X201.873 Y168.441 E.06212
G3 X203.28 Y164.086 I4.814 J-.85 E.15963
G2 X205.06 Y162.214 I-10.296 J-11.57 E.08665
G2 X205.38 Y158.47 I-3.702 J-2.202 E.13029
G2 X204.159 Y156.598 I-4.865 J1.84 E.07548
G3 X202.379 Y154.726 I10.298 J-11.572 E.08665
G3 X202.059 Y150.982 I3.702 J-2.202 E.13029
G3 X203.28 Y149.11 I4.865 J1.84 E.07548
G2 X205.06 Y147.239 I-10.297 J-11.571 E.08665
G2 X205.053 Y142.838 I-3.688 J-2.195 E.15484
G1 X203.72 Y142.721 E.04485
G1 X201.472 Y142.918 E.07559
G1 X199.294 Y143.502 E.07558
G1 X198.153 Y144.034 E.04218
G3 X196.671 Y147.239 I-4.888 J-.315 E.12105
G2 X194.892 Y149.11 I10.297 J11.571 E.08665
G2 X194.571 Y152.854 I3.702 J2.202 E.13029
G2 X195.793 Y154.726 I4.865 J-1.839 E.07548
G3 X197.572 Y156.598 I-10.297 J11.571 E.08665
G3 X197.893 Y160.342 I-3.702 J2.202 E.13029
G3 X196.671 Y162.214 I-4.865 J-1.839 E.07548
G2 X194.892 Y164.086 I10.298 J11.572 E.08665
G2 X194.554 Y164.728 I1.924 J1.422 E.02441
G3 X193.479 Y163.513 I2.909 J-3.656 E.05465
; WIPE_START
G1 F18423.913
G1 X193.806 Y163.98 E-.217
G1 X194.11 Y164.284 E-.163
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z8.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z8.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 8.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 41/82
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.475 Y155.662 F60000
G1 Z8.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5408
M204 S8000
G1 X217.266 Y158.051 E.08035
G1 X216.645 Y160.366 E.08034
G1 X215.632 Y162.54 E.08035
G1 X214.256 Y164.504 E.08035
G1 X212.561 Y166.199 E.08035
G1 X210.681 Y167.515 E.0769
G1 X210.597 Y167.574 E.00344
G1 X208.424 Y168.588 E.08035
G1 X206.108 Y169.208 E.08034
G1 X203.72 Y169.417 E.08035
G1 X201.331 Y169.208 E.08035
G1 X199.015 Y168.588 E.08034
G1 X196.842 Y167.574 E.08035
G1 X194.878 Y166.199 E.08035
G1 X193.183 Y164.504 E.08035
G1 X191.866 Y162.624 E.0769
G1 X191.807 Y162.54 E.00344
G1 X190.794 Y160.366 E.08035
G1 X190.174 Y158.051 E.08034
G1 X189.965 Y155.662 E.08035
G1 X190.174 Y153.274 E.08035
G1 X190.794 Y150.958 E.08035
G1 X191.807 Y148.785 E.08035
G1 X193.183 Y146.82 E.08035
G1 X194.878 Y145.125 E.08035
G1 X196.842 Y143.75 E.08035
G1 X199.015 Y142.737 E.08035
G1 X201.331 Y142.116 E.08034
G1 X203.72 Y141.907 E.08035
G1 X206.006 Y142.107 E.0769
G1 X206.108 Y142.116 E.00345
G1 X208.424 Y142.737 E.08034
G1 X210.597 Y143.75 E.08035
G1 X212.561 Y145.125 E.08035
G1 X214.256 Y146.82 E.08035
G1 X215.632 Y148.785 E.08035
G1 X216.645 Y150.958 E.08035
G1 X217.266 Y153.274 E.08035
G1 X217.469 Y155.602 E.07834
; COOLING_NODE: 0
M204 S10000
G1 X217.867 Y155.651 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5408
M204 S5000
G1 X217.868 Y155.662 E.00035
M73 P72 R3
G1 X217.653 Y158.119 E.07655
G1 X217.015 Y160.501 E.07655
G1 X215.973 Y162.736 E.07655
G1 X214.558 Y164.757 E.07656
G1 X212.814 Y166.5 E.07655
G1 X210.906 Y167.836 E.0723
G1 X210.794 Y167.915 E.00426
G1 X208.559 Y168.957 E.07656
G1 X206.176 Y169.596 E.07655
G1 X203.72 Y169.811 E.07655
G1 X201.263 Y169.596 E.07655
G1 X198.88 Y168.957 E.07655
G1 X196.645 Y167.915 E.07655
G1 X194.625 Y166.5 E.07656
G1 X192.881 Y164.757 E.07655
G1 X191.545 Y162.849 E.0723
G1 X191.467 Y162.736 E.00426
G1 X190.424 Y160.501 E.07656
G1 X189.786 Y158.119 E.07655
G1 X189.571 Y155.662 E.07655
G1 X189.786 Y153.205 E.07655
G1 X190.424 Y150.823 E.07655
G1 X191.467 Y148.588 E.07655
G1 X192.881 Y146.568 E.07656
G1 X194.625 Y144.824 E.07655
G1 X196.645 Y143.409 E.07656
G1 X198.88 Y142.367 E.07655
G1 X201.263 Y141.728 E.07655
G1 X203.72 Y141.513 E.07655
G1 X206.04 Y141.716 E.0723
G1 X206.176 Y141.728 E.00426
G1 X208.559 Y142.367 E.07655
G1 X210.794 Y143.409 E.07655
G1 X212.814 Y144.824 E.07656
G1 X214.558 Y146.568 E.07655
G1 X215.973 Y148.588 E.07656
G1 X217.015 Y150.823 E.07655
G1 X217.653 Y153.205 E.07655
G1 X217.862 Y155.591 E.07434
M204 S10000
G1 X216.997 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.587078
G1 F5408
M204 S8000
G1 X216.797 Y153.373 E.10292
G1 X216.184 Y151.093 E.10577
G1 X215.225 Y149.039 E.10155
G1 X213.9 Y147.141 E.10367
G1 X212.266 Y145.503 E.10366
G1 X210.372 Y144.173 E.10366
G1 X208.276 Y143.193 E.10366
G1 X206.041 Y142.591 E.10367
G1 X203.703 Y142.386 E.10515
G1 X201.431 Y142.585 E.10216
G1 X199.195 Y143.181 E.10366
G1 X197.096 Y144.156 E.10367
G1 X195.163 Y145.513 E.10578
G1 X193.56 Y147.116 E.10154
G1 X192.231 Y149.01 E.10366
G1 X191.25 Y151.106 E.10366
G1 X190.648 Y153.34 E.10366
G1 X190.444 Y155.645 E.10366
G1 X190.643 Y157.951 E.10366
G1 X191.239 Y160.187 E.10365
G1 X192.214 Y162.285 E.10367
G1 X193.57 Y164.219 E.10578
G1 X195.173 Y165.821 E.10154
G1 X197.067 Y167.151 E.10366
G1 X199.163 Y168.131 E.10366
G1 X201.398 Y168.733 E.10366
G1 X203.703 Y168.938 E.10366
G1 X206.008 Y168.739 E.10366
G1 X208.244 Y168.143 E.10365
G1 X210.343 Y167.168 E.10367
G1 X212.276 Y165.812 E.10578
G1 X213.879 Y164.208 E.10154
G1 X215.232 Y162.273 E.10577
G1 X216.205 Y160.174 E.10365
G1 X216.791 Y157.984 E.10154
G1 X216.992 Y155.722 E.10172
M204 S10000
G1 X213.489 Y147.398 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5408
M204 S8000
G1 X212.338 Y146.246 E.05457
G1 X212.306 Y146.303 E.00217
G3 X210.011 Y148.642 I-33.347 J-30.413 E.10986
G2 X209.281 Y151.918 I2.953 J2.377 E.1165
G2 X210.937 Y154.726 I5.691 J-1.464 E.11068
G3 X212.752 Y156.598 I-6.253 J7.881 E.08763
G3 X212.836 Y160.342 I-3.781 J1.958 E.12993
G3 X211.477 Y162.214 I-5.099 J-2.273 E.07808
G2 X209.662 Y164.086 I6.252 J7.88 E.08763
G2 X209.349 Y167.107 I3.594 J1.899 E.10433
G1 X208.097 Y167.691 E.04627
G1 X205.942 Y168.268 E.07476
G1 X203.72 Y168.463 E.07478
G1 X201.733 Y168.289 E.06683
G3 X203.449 Y164.086 I5.095 J-.372 E.15766
G2 X205.265 Y162.214 I-6.253 J-7.881 E.08763
G2 X205.349 Y158.47 I-3.781 J-1.958 E.12993
G2 X203.99 Y156.598 I-5.1 J2.273 E.07808
G3 X202.174 Y154.726 I6.253 J-7.881 E.08763
G3 X202.09 Y150.982 I3.781 J-1.958 E.12993
G3 X203.449 Y149.11 I5.1 J2.273 E.07808
G2 X205.265 Y147.239 I-6.252 J-7.881 E.08763
G2 X205.056 Y142.978 I-3.672 J-1.955 E.15008
G1 X203.72 Y142.861 E.04496
G1 X201.497 Y143.056 E.07478
G1 X199.342 Y143.633 E.07476
G1 X198.188 Y144.171 E.04266
G3 X196.502 Y147.239 I-5.15 J-.833 E.1196
G2 X194.687 Y149.11 I6.253 J7.881 E.08763
G2 X194.603 Y152.854 I3.781 J1.958 E.12993
G2 X195.962 Y154.726 I5.1 J-2.273 E.07808
G3 X197.777 Y156.598 I-6.253 J7.881 E.08763
G3 X197.861 Y160.342 I-3.781 J1.958 E.12993
G3 X196.502 Y162.214 I-5.1 J-2.273 E.07808
G2 X194.687 Y164.086 I6.252 J7.881 E.08763
G1 X194.49 Y164.466 E.01436
G3 X193.447 Y163.224 I3.002 J-3.578 E.05463
; WIPE_START
G1 F18423.913
G1 X193.914 Y163.89 E-.3092
G1 X194.045 Y164.022 E-.0708
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z8.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z8.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 8.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 42/82
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.37 Y155.662 F60000
G1 Z8.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5423
M204 S8000
G1 X217.162 Y158.032 E.07973
G1 X216.546 Y160.331 E.07973
G1 X215.541 Y162.487 E.07973
G1 X214.176 Y164.436 E.07973
G1 X212.494 Y166.119 E.07973
G1 X210.545 Y167.483 E.07973
G1 X208.388 Y168.489 E.07974
G1 X206.09 Y169.105 E.07973
G1 X203.72 Y169.312 E.07973
G1 X201.349 Y169.105 E.07973
G1 X199.051 Y168.489 E.07973
G1 X196.895 Y167.483 E.07973
G1 X194.946 Y166.119 E.07973
G1 X193.263 Y164.436 E.07973
G1 X191.898 Y162.487 E.07973
G1 X190.893 Y160.331 E.07974
G1 X190.277 Y158.032 E.07973
G1 X190.07 Y155.662 E.07973
G1 X190.277 Y153.292 E.07973
G1 X190.893 Y150.993 E.07973
G1 X191.898 Y148.837 E.07973
G1 X193.263 Y146.888 E.07973
G1 X194.945 Y145.206 E.07973
G1 X196.895 Y143.841 E.07973
G1 X199.051 Y142.835 E.07973
G1 X201.349 Y142.219 E.07973
G1 X203.719 Y142.012 E.07973
G1 X206.09 Y142.219 E.07974
G1 X208.388 Y142.835 E.07973
G1 X210.545 Y143.841 E.07973
G1 X212.494 Y145.205 E.07973
G1 X214.176 Y146.888 E.07973
G1 X215.541 Y148.837 E.07973
G1 X216.546 Y150.993 E.07973
G1 X217.162 Y153.292 E.07973
G1 X217.364 Y155.602 E.07772
; COOLING_NODE: 0
M204 S10000
G1 X217.762 Y155.648 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5384
M204 S5000
G1 X217.763 Y155.662 E.00044
G1 X217.55 Y158.101 E.07599
G1 X216.916 Y160.465 E.07599
G1 X215.882 Y162.684 E.07599
G1 X214.478 Y164.689 E.07599
G1 X212.747 Y166.42 E.07599
G1 X210.716 Y167.836 E.07686
G1 X208.523 Y168.859 E.07511
G1 X206.158 Y169.492 E.07599
G1 X203.72 Y169.706 E.07599
G1 X201.281 Y169.492 E.07599
G1 X198.916 Y168.859 E.07599
G1 X196.698 Y167.824 E.07599
G1 X194.693 Y166.42 E.07599
G1 X192.962 Y164.689 E.07599
G1 X191.545 Y162.658 E.07686
G1 X190.523 Y160.465 E.07511
G1 X189.889 Y158.101 E.07599
G1 X189.676 Y155.662 E.07599
G1 X189.889 Y153.223 E.07599
G1 X190.523 Y150.859 E.07599
G1 X191.557 Y148.64 E.07599
G1 X192.962 Y146.635 E.07599
G1 X194.692 Y144.904 E.07599
G1 X196.698 Y143.5 E.07599
G1 X198.916 Y142.465 E.07599
G1 X201.281 Y141.832 E.07599
G1 X203.748 Y141.621 E.07685
G1 X206.158 Y141.832 E.07511
G1 X208.523 Y142.465 E.07599
G1 X210.741 Y143.5 E.07599
G1 X212.747 Y144.904 E.07599
G1 X214.478 Y146.635 E.07599
G1 X215.882 Y148.64 E.07599
G1 X216.916 Y150.859 E.07599
G1 X217.55 Y153.223 E.07599
G1 X217.757 Y155.588 E.07369
; WIPE_START
G1 F12000
M204 S8000
G1 X217.763 Y155.662 E-.02813
G1 X217.682 Y156.584 E-.35187
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z8.8 I1.161 J-.365 P1  F60000
G1 X216.674 Y153.378 Z8.8
G1 Z8.4
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.622035
G1 F5423
M204 S8000
G1 X216.086 Y151.181 E.10843
G1 X215.12 Y149.101 E.10931
G1 X213.807 Y147.221 E.10931
G1 X212.149 Y145.566 E.11169
G1 X210.312 Y144.28 E.1069
G1 X208.235 Y143.308 E.1093
G1 X206.021 Y142.712 E.1093
G1 X203.701 Y142.509 E.11103
G1 X201.454 Y142.706 E.10756
G1 X199.238 Y143.296 E.1093
G1 X197.159 Y144.262 E.10931
G1 X195.279 Y145.575 E.10931
G1 X193.623 Y147.233 E.11169
G1 X192.338 Y149.07 E.10689
G1 X191.366 Y151.146 E.1093
G1 X190.769 Y153.36 E.1093
G1 X190.566 Y155.644 E.1093
G1 X190.763 Y157.928 E.1093
G1 X191.353 Y160.143 E.10929
G1 X192.319 Y162.223 E.10931
G1 X193.632 Y164.103 E.1093
G1 X195.29 Y165.758 E.11169
G1 X197.127 Y167.044 E.1069
G1 X199.204 Y168.016 E.1093
G1 X201.418 Y168.612 E.1093
G1 X203.701 Y168.815 E.1093
G1 X205.986 Y168.619 E.1093
G1 X208.201 Y168.028 E.10929
G1 X210.28 Y167.062 E.10931
G1 X212.16 Y165.75 E.10931
G1 X213.816 Y164.092 E.11169
G1 X215.101 Y162.254 E.1069
G1 X216.09 Y160.13 E.11169
G1 X216.678 Y157.914 E.1093
G1 X216.873 Y155.68 E.1069
G1 X216.68 Y153.438 E.10731
M204 S10000
G1 X213.357 Y147.463 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5423
M204 S8000
G1 X212.206 Y146.312 E.05457
G3 X209.767 Y148.642 I-95.874 J-97.88 E.11305
G2 X209.079 Y150.982 I2.389 J1.973 E.084
G2 X211.111 Y154.726 I5.532 J-.579 E.14649
G3 X212.976 Y156.598 I-4.448 J6.297 E.08899
G3 X213.168 Y159.406 I-3.575 J1.655 E.09644
G3 X211.303 Y162.214 I-5.894 J-1.892 E.11441
G2 X209.438 Y164.086 I4.448 J6.297 E.08899
G2 X209.246 Y166.893 I3.575 J1.655 E.09644
G1 X209.281 Y166.985 E.00329
G1 X208.05 Y167.559 E.04552
G1 X205.918 Y168.13 E.07394
G1 X203.72 Y168.323 E.07396
G1 X201.602 Y168.137 E.07123
G3 X203.624 Y164.086 I5.424 J.176 E.15653
G2 X205.489 Y162.214 I-4.448 J-6.297 E.08899
G2 X205.681 Y159.406 I-3.575 J-1.655 E.09644
G2 X203.815 Y156.598 I-5.893 J1.892 E.11441
G3 X201.95 Y154.726 I4.448 J-6.297 E.08899
G3 X201.758 Y151.918 I3.575 J-1.655 E.09644
G3 X203.624 Y149.11 I5.894 J1.892 E.11441
G2 X205.489 Y147.239 I-4.448 J-6.297 E.08899
G2 X205.681 Y144.431 I-3.575 J-1.655 E.09644
G2 X205.087 Y143.121 I-3.425 J.764 E.04853
G1 X203.72 Y143.001 E.046
G1 X201.521 Y143.194 E.07396
G1 X199.39 Y143.765 E.07395
G1 X198.214 Y144.313 E.04345
G1 X198.193 Y144.431 E.00401
G3 X196.328 Y147.239 I-5.893 J-1.892 E.11441
G2 X194.463 Y149.11 I4.448 J6.297 E.08899
G2 X194.271 Y151.918 I3.575 J1.655 E.09644
G2 X196.136 Y154.726 I5.893 J-1.892 E.11441
G3 X198.001 Y156.598 I-4.448 J6.297 E.08899
G3 X198.193 Y159.406 I-3.575 J1.655 E.09644
G3 X196.328 Y162.214 I-5.893 J-1.892 E.11441
G2 X194.414 Y164.193 I4.291 J6.063 E.0928
G3 X193.406 Y162.922 I3.102 J-3.495 E.05466
; WIPE_START
G1 F18423.913
G1 X193.979 Y163.741 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
M73 P73 R3
G3 Z8.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z8.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 43/82
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.23 Y155.662 F60000
G1 Z8.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5350
M204 S8000
G1 X217.024 Y158.008 E.07891
G1 X216.415 Y160.283 E.07891
G1 X215.42 Y162.417 E.07892
G1 X214.069 Y164.346 E.07892
G1 X213.941 Y164.474 E.00607
G1 X212.404 Y166.011 E.07284
G1 X210.475 Y167.362 E.07892
G1 X208.34 Y168.357 E.07892
G1 X206.066 Y168.967 E.07891
G1 X203.72 Y169.172 E.07891
G1 X201.374 Y168.967 E.07891
G1 X199.099 Y168.357 E.07891
G1 X196.965 Y167.362 E.07892
G1 X195.035 Y166.011 E.07892
G1 X194.907 Y165.883 E.00607
G1 X193.37 Y164.346 E.07284
G1 X192.02 Y162.417 E.07892
G1 X191.024 Y160.283 E.07892
G1 X190.415 Y158.008 E.07891
G1 X190.21 Y155.662 E.07892
G1 X190.415 Y153.316 E.07891
G1 X191.024 Y151.041 E.07891
G1 X192.02 Y148.907 E.07892
G1 X193.37 Y146.978 E.07892
G1 X195.035 Y145.313 E.07891
G1 X196.965 Y143.962 E.07892
G1 X199.099 Y142.967 E.07892
G1 X201.374 Y142.357 E.07891
G1 X203.72 Y142.152 E.07891
G1 X203.9 Y142.168 E.00607
G1 X206.066 Y142.357 E.07285
G1 X208.34 Y142.967 E.07891
G1 X210.475 Y143.962 E.07892
G1 X212.404 Y145.313 E.07892
G1 X214.069 Y146.978 E.07891
G1 X215.42 Y148.907 E.07892
G1 X216.415 Y151.041 E.07892
G1 X217.024 Y153.316 E.07891
G1 X217.224 Y155.602 E.0769
; COOLING_NODE: 0
M204 S10000
G1 X217.622 Y155.648 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5350
M204 S5000
G1 X217.623 Y155.662 E.00043
G1 X217.412 Y158.076 E.07523
G1 X216.785 Y160.417 E.07523
G1 X215.76 Y162.614 E.07523
G1 X214.37 Y164.599 E.07523
G1 X214.218 Y164.751 E.00669
G1 X212.657 Y166.313 E.06854
G1 X210.671 Y167.703 E.07523
G1 X208.475 Y168.727 E.07523
G1 X206.134 Y169.354 E.07523
G1 X203.72 Y169.566 E.07523
G1 X201.305 Y169.354 E.07523
G1 X198.964 Y168.727 E.07523
G1 X196.768 Y167.703 E.07523
G1 X194.782 Y166.313 E.07523
G1 X194.63 Y166.16 E.00669
G1 X193.069 Y164.599 E.06854
G1 X191.679 Y162.614 E.07523
G1 X190.654 Y160.417 E.07523
G1 X190.027 Y158.076 E.07523
G1 X189.816 Y155.662 E.07523
G1 X190.027 Y153.248 E.07523
G1 X190.083 Y153.04 E.00669
G1 X190.654 Y150.907 E.06854
G1 X191.679 Y148.71 E.07523
G1 X193.069 Y146.725 E.07523
G1 X194.783 Y145.011 E.07523
G1 X196.768 Y143.621 E.07523
G1 X198.964 Y142.597 E.07523
G1 X201.305 Y141.97 E.07523
G1 X203.72 Y141.758 E.07523
G1 X203.934 Y141.777 E.00669
G1 X206.134 Y141.97 E.06854
G1 X208.475 Y142.597 E.07523
G1 X210.671 Y143.621 E.07523
G1 X212.657 Y145.011 E.07523
G1 X214.37 Y146.725 E.07523
G1 X215.76 Y148.71 E.07523
G1 X216.785 Y150.907 E.07523
G1 X217.412 Y153.248 E.07523
G1 X217.617 Y155.588 E.07294
M204 S10000
G1 X216.734 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.622037
G1 F5350
M204 S8000
G1 X216.538 Y153.42 E.10728
G1 X215.936 Y151.181 E.11053
G1 X214.998 Y149.171 E.10574
G1 X213.7 Y147.311 E.10815
G1 X212.098 Y145.705 E.10813
G1 X210.242 Y144.401 E.10813
G1 X208.187 Y143.44 E.10814
G1 X205.997 Y142.85 E.10814
G1 X203.701 Y142.649 E.10987
G1 X201.478 Y142.843 E.10639
G1 X199.286 Y143.427 E.10814
G1 X197.229 Y144.383 E.10814
G1 X195.33 Y145.715 E.11054
G1 X193.763 Y147.283 E.10573
G1 X192.459 Y149.14 E.10814
G1 X191.497 Y151.194 E.10813
G1 X190.907 Y153.384 E.10814
G1 X190.706 Y155.644 E.10814
G1 X190.901 Y157.904 E.10813
G1 X191.485 Y160.096 E.10813
G1 X192.441 Y162.153 E.10814
G1 X193.772 Y164.051 E.11053
G1 X195.341 Y165.619 E.10573
G1 X197.197 Y166.923 E.10814
G1 X199.252 Y167.884 E.10814
G1 X201.442 Y168.474 E.10814
G1 X203.701 Y168.675 E.10814
G1 X205.961 Y168.481 E.10813
G1 X208.153 Y167.897 E.10813
G1 X210.21 Y166.941 E.10814
G1 X212.109 Y165.609 E.11054
G1 X213.677 Y164.041 E.10573
G1 X215.005 Y162.14 E.11053
G1 X215.958 Y160.082 E.10813
G1 X216.532 Y157.94 E.10574
G1 X216.729 Y155.722 E.10615
M204 S10000
G1 X213.216 Y147.519 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5350
M204 S8000
G1 X212.065 Y146.367 E.05457
G3 X209.949 Y148.174 I-12.663 J-12.686 E.09334
G2 X208.974 Y150.982 I1.874 J2.223 E.10454
G2 X211.296 Y154.726 I6.001 J-1.13 E.15102
G3 X212.921 Y156.13 I-4.786 J7.18 E.07214
G3 X213.44 Y158.47 I-2.369 J1.753 E.08271
G3 X211.118 Y162.214 I-6.001 J-1.13 E.15103
G2 X209.494 Y163.618 I4.786 J7.18 E.07214
G2 X208.974 Y165.957 I2.369 J1.753 E.08271
G1 X209.195 Y166.871 E.0315
G1 X208.002 Y167.428 E.04413
G1 X205.894 Y167.992 E.07313
G1 X203.72 Y168.183 E.07314
G1 X201.545 Y167.992 E.07314
G1 X201.481 Y167.975 E.00224
G1 X201.487 Y167.829 E.00489
G3 X203.808 Y164.086 I6.001 J1.129 E.15102
G2 X205.433 Y162.682 I-4.786 J-7.18 E.07214
G2 X205.952 Y160.342 I-2.369 J-1.753 E.08271
G2 X203.631 Y156.598 I-6.001 J1.13 E.15103
G3 X202.006 Y155.194 I4.786 J-7.18 E.07214
G3 X201.487 Y152.854 I2.369 J-1.753 E.08271
G3 X203.808 Y149.11 I6.001 J1.13 E.15102
G2 X205.433 Y147.706 I-4.786 J-7.18 E.07214
G2 X205.952 Y145.367 I-2.369 J-1.753 E.08271
G2 X205.148 Y143.266 I-5.868 J1.043 E.07582
G1 X203.72 Y143.141 E.04805
G1 X201.545 Y143.332 E.07314
G1 X199.437 Y143.896 E.07313
G1 X198.225 Y144.462 E.04485
G3 X196.143 Y147.239 I-5.901 J-2.255 E.1178
G2 X194.518 Y148.642 I4.785 J7.179 E.07214
G2 X193.999 Y150.982 I2.369 J1.753 E.08271
G2 X196.321 Y154.726 I6.001 J-1.13 E.15102
G3 X197.945 Y156.13 I-4.786 J7.18 E.07214
G3 X198.465 Y158.47 I-2.369 J1.753 E.08271
G3 X196.143 Y162.214 I-6.001 J-1.13 E.15103
G2 X194.518 Y163.618 I4.786 J7.18 E.07214
G1 X194.328 Y163.91 E.01169
G1 X194.128 Y163.71 E.00946
G1 X193.356 Y162.608 E.0451
; WIPE_START
G1 F18423.913
G1 X193.93 Y163.427 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z9 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z9 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 8.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 44/82
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X217.09 Y155.662 F60000
G1 Z8.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5328
M204 S8000
G1 X216.886 Y157.984 E.0781
G1 X216.283 Y160.235 E.0781
G1 X215.298 Y162.347 E.0781
G1 X213.962 Y164.256 E.0781
G1 X213.701 Y164.516 E.01234
G1 X212.314 Y165.904 E.06576
G1 X210.405 Y167.241 E.0781
G1 X208.292 Y168.226 E.0781
G1 X206.041 Y168.829 E.0781
G1 X203.72 Y169.032 E.0781
G1 X201.398 Y168.829 E.0781
G1 X199.147 Y168.226 E.0781
G1 X197.035 Y167.241 E.0781
G1 X195.126 Y165.904 E.0781
G1 X194.865 Y165.644 E.01234
G1 X193.478 Y164.256 E.06576
G1 X192.141 Y162.347 E.0781
G1 X191.156 Y160.235 E.0781
G1 X190.553 Y157.984 E.0781
G1 X190.35 Y155.662 E.0781
G1 X190.553 Y153.34 E.0781
G1 X191.156 Y151.089 E.0781
G1 X191.312 Y150.756 E.01234
G1 X192.141 Y148.977 E.06576
G1 X193.478 Y147.068 E.0781
G1 X195.126 Y145.42 E.0781
G1 X197.035 Y144.083 E.0781
G1 X199.147 Y143.098 E.0781
G1 X201.398 Y142.495 E.0781
G1 X203.72 Y142.292 E.0781
G1 X204.086 Y142.324 E.01234
G1 X206.041 Y142.495 E.06576
G1 X208.292 Y143.098 E.0781
G1 X210.405 Y144.083 E.0781
G1 X212.314 Y145.42 E.07809
G1 X213.962 Y147.068 E.0781
G1 X215.298 Y148.977 E.0781
G1 X216.283 Y151.089 E.0781
G1 X216.886 Y153.34 E.0781
G1 X217.084 Y155.602 E.07609
; COOLING_NODE: 0
M204 S10000
G1 X217.482 Y155.648 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5328
M204 S5000
G1 X217.483 Y155.662 E.00043
G1 X217.274 Y158.052 E.07447
G1 X216.653 Y160.369 E.07447
G1 X215.639 Y162.544 E.07447
G1 X214.263 Y164.509 E.07447
G1 X213.978 Y164.794 E.01249
G1 X212.567 Y166.205 E.06198
G1 X210.601 Y167.582 E.07447
G1 X208.427 Y168.596 E.07447
G1 X206.11 Y169.216 E.07447
G1 X203.72 Y169.426 E.07447
G1 X201.33 Y169.216 E.07447
G1 X199.012 Y168.596 E.07447
G1 X196.838 Y167.582 E.07447
G1 X194.873 Y166.205 E.07447
G1 X194.588 Y165.921 E.01249
G1 X193.176 Y164.509 E.06198
G1 X191.8 Y162.544 E.07447
G1 X190.786 Y160.369 E.07447
G1 X190.165 Y158.052 E.07447
G1 X189.956 Y155.662 E.07447
G1 X190.165 Y153.272 E.07447
G1 X190.786 Y150.955 E.07447
G1 X190.956 Y150.59 E.01249
G1 X191.8 Y148.78 E.06198
G1 X193.176 Y146.815 E.07447
G1 X194.873 Y145.119 E.07447
G1 X196.838 Y143.742 E.07447
G1 X199.012 Y142.729 E.07447
G1 X201.33 Y142.108 E.07447
G1 X203.72 Y141.899 E.07447
G1 X204.12 Y141.934 E.01249
G1 X206.11 Y142.108 E.06198
G1 X208.427 Y142.729 E.07447
G1 X210.601 Y143.742 E.07447
G1 X212.567 Y145.119 E.07447
G1 X214.263 Y146.815 E.07447
G1 X215.639 Y148.78 E.07447
G1 X216.653 Y150.955 E.07447
G1 X217.274 Y153.272 E.07447
G1 X217.477 Y155.589 E.07218
M204 S10000
G1 X216.594 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.622028
G1 F5328
M204 S8000
G1 X216.4 Y153.445 E.10611
G1 X215.805 Y151.229 E.10936
G1 X214.877 Y149.241 E.10458
G1 X213.593 Y147.401 E.10698
G1 X212.008 Y145.812 E.10697
G1 X210.172 Y144.523 E.10697
G1 X208.14 Y143.572 E.10697
G1 X205.973 Y142.988 E.10697
G1 X203.701 Y142.789 E.1087
G1 X201.502 Y142.981 E.10523
G1 X199.334 Y143.559 E.10697
G1 X197.299 Y144.505 E.10698
G1 X195.42 Y145.822 E.10937
G1 X193.87 Y147.373 E.10457
G1 X192.58 Y149.21 E.10697
G1 X191.629 Y151.242 E.10697
G1 X191.045 Y153.409 E.10697
G1 X190.846 Y155.644 E.10697
G1 X191.039 Y157.879 E.10697
G1 X191.617 Y160.048 E.10697
G1 X192.562 Y162.083 E.10697
G1 X193.879 Y163.961 E.10937
G1 X195.431 Y165.512 E.10457
G1 X197.267 Y166.801 E.10697
G1 X199.3 Y167.753 E.10697
G1 X201.466 Y168.336 E.10697
G1 X203.701 Y168.535 E.10697
G1 X205.937 Y168.343 E.10697
G1 X208.105 Y167.765 E.10697
G1 X210.14 Y166.82 E.10698
G1 X212.019 Y165.502 E.10937
G1 X213.569 Y163.951 E.10457
G1 X214.884 Y162.07 E.10936
G1 X215.827 Y160.034 E.10697
G1 X216.394 Y157.915 E.10457
G1 X216.589 Y155.722 E.10498
M204 S10000
G1 X213.07 Y147.57 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5328
M204 S8000
G1 X211.918 Y146.419 E.05457
G3 X209.631 Y148.174 I-14.188 J-16.112 E.09669
G2 X208.744 Y150.046 I1.379 J1.8 E.07209
G2 X211.498 Y154.726 I5.989 J-.374 E.1888
G1 X212.783 Y155.662 E.05328
G3 X213.67 Y157.534 I-1.379 J1.8 E.07209
M73 P74 R3
G3 X210.917 Y162.214 I-5.989 J-.374 E.1888
G1 X209.631 Y163.15 E.05328
G2 X208.744 Y165.022 I1.379 J1.8 E.07209
G2 X209.104 Y166.76 I5.02 J-.133 E.05979
G1 X207.954 Y167.296 E.04254
G1 X205.87 Y167.855 E.07231
G1 X203.72 Y168.043 E.07232
G1 X201.378 Y167.803 E.07887
G3 X204.01 Y164.086 I6.17 J1.577 E.15609
G1 X205.295 Y163.15 E.05328
G2 X206.182 Y161.278 I-1.379 J-1.799 E.07209
G2 X203.429 Y156.598 I-5.989 J.374 E.1888
G1 X202.144 Y155.662 E.05328
G3 X201.257 Y153.79 I1.379 J-1.799 E.07209
G3 X204.01 Y149.11 I5.989 J.374 E.1888
G1 X205.295 Y148.174 E.05328
G2 X206.182 Y146.303 I-1.379 J-1.799 E.07209
G2 X205.242 Y143.415 I-5.49 J.19 E.10311
G1 X203.72 Y143.281 E.05122
G1 X201.57 Y143.47 E.07232
G1 X199.485 Y144.028 E.07231
G1 X198.192 Y144.631 E.04782
G3 X195.942 Y147.239 I-5.897 J-2.815 E.1168
G1 X194.656 Y148.174 E.05328
G2 X193.769 Y150.046 I1.379 J1.8 E.07209
G2 X196.522 Y154.726 I5.989 J-.374 E.1888
G1 X197.808 Y155.662 E.05328
G3 X198.695 Y157.534 I-1.379 J1.8 E.07209
G3 X195.942 Y162.214 I-5.989 J-.374 E.1888
G1 X194.656 Y163.15 E.05328
G1 X194.22 Y163.598 E.02096
G1 X193.286 Y162.264 E.05457
; WIPE_START
G1 F18423.913
G1 X193.859 Y163.083 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z9.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z9.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 9
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 45/82
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X216.949 Y155.662 F60000
G1 Z9
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5325
M204 S8000
G1 X216.748 Y157.959 E.07728
G1 X216.152 Y160.187 E.07728
G1 X215.177 Y162.277 E.07728
G1 X213.854 Y164.166 E.07728
G1 X212.224 Y165.797 E.07728
G1 X210.335 Y167.119 E.07728
G1 X208.244 Y168.094 E.07728
G1 X206.017 Y168.691 E.07728
G1 X203.72 Y168.892 E.07728
G1 X201.422 Y168.691 E.07728
G1 X199.195 Y168.094 E.07728
G1 X197.105 Y167.119 E.07728
G1 X195.216 Y165.797 E.07728
G1 X193.585 Y164.166 E.07728
G1 X192.262 Y162.277 E.07728
G1 X191.287 Y160.187 E.07728
G1 X190.691 Y157.959 E.07728
G1 X190.49 Y155.662 E.07728
G1 X190.691 Y153.365 E.07728
G1 X191.288 Y151.137 E.07728
G1 X191.522 Y150.634 E.0186
G1 X192.262 Y149.047 E.05867
G1 X193.585 Y147.158 E.07728
G1 X195.216 Y145.527 E.07728
G1 X197.105 Y144.205 E.07728
G1 X199.195 Y143.23 E.07728
G1 X201.422 Y142.633 E.07728
G1 X203.72 Y142.432 E.07728
G1 X204.273 Y142.481 E.0186
G1 X206.017 Y142.633 E.05867
G1 X208.244 Y143.23 E.07728
G1 X210.335 Y144.205 E.07728
G1 X212.224 Y145.527 E.07728
G1 X213.854 Y147.158 E.07728
G1 X215.177 Y149.047 E.07728
G1 X216.152 Y151.137 E.07728
G1 X216.748 Y153.365 E.07728
G1 X216.944 Y155.602 E.07527
; COOLING_NODE: 0
M204 S10000
G1 X217.342 Y155.649 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5305
M204 S5000
G1 X217.343 Y155.662 E.00042
G1 X217.136 Y158.028 E.07371
G1 X216.521 Y160.322 E.07371
G1 X215.518 Y162.474 E.07371
G1 X214.156 Y164.419 E.07371
G1 X212.477 Y166.098 E.07371
G1 X210.531 Y167.46 E.07372
G1 X208.379 Y168.464 E.07371
G1 X206.085 Y169.079 E.07371
G1 X203.72 Y169.286 E.07371
G1 X201.354 Y169.079 E.07371
G1 X199.06 Y168.464 E.07371
G1 X196.908 Y167.46 E.07371
G1 X194.963 Y166.098 E.07371
G1 X193.283 Y164.419 E.07371
G1 X191.921 Y162.474 E.07372
G1 X190.918 Y160.322 E.07371
G1 X190.303 Y158.028 E.07371
G1 X190.096 Y155.662 E.07371
G1 X190.303 Y153.296 E.07371
G1 X190.918 Y151.003 E.07371
G1 X191.921 Y148.85 E.07371
G1 X193.283 Y146.905 E.07371
G1 X194.963 Y145.226 E.07371
G1 X196.908 Y143.864 E.07372
G1 X199.06 Y142.86 E.07371
G1 X201.354 Y142.246 E.07371
G1 X203.72 Y142.039 E.07371
G1 X204.307 Y142.09 E.0183
G1 X206.085 Y142.246 E.05542
G1 X208.379 Y142.86 E.07371
G1 X210.531 Y143.864 E.07371
G1 X212.477 Y145.226 E.07371
G1 X214.156 Y146.905 E.07371
G1 X215.518 Y148.85 E.07372
G1 X216.521 Y151.003 E.07371
G1 X217.136 Y153.296 E.07371
G1 X217.337 Y155.589 E.07143
M204 S10000
G1 X216.454 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.62203
G1 F5325
M204 S8000
G1 X216.262 Y153.469 E.10495
G1 X215.673 Y151.277 E.1082
G1 X214.756 Y149.311 E.10341
G1 X213.485 Y147.491 E.10582
G1 X211.918 Y145.92 E.1058
G1 X210.102 Y144.644 E.10581
G1 X208.092 Y143.703 E.10581
G1 X205.949 Y143.126 E.10581
G1 X203.701 Y142.929 E.10754
G1 X201.527 Y143.119 E.10407
G1 X199.382 Y143.691 E.10581
G1 X197.369 Y144.626 E.10581
G1 X195.51 Y145.929 E.10821
G1 X193.977 Y147.463 E.1034
G1 X192.702 Y149.28 E.10581
G1 X191.761 Y151.29 E.10581
G1 X191.183 Y153.433 E.10581
G1 X190.987 Y155.644 E.10581
G1 X191.177 Y157.855 E.1058
G1 X191.748 Y160 E.1058
G1 X192.683 Y162.013 E.10581
G1 X193.987 Y163.871 E.10821
G1 X195.521 Y165.404 E.1034
G1 X197.337 Y166.68 E.10581
G1 X199.347 Y167.621 E.10581
G1 X201.491 Y168.198 E.10581
G1 X203.701 Y168.395 E.10581
G1 X205.913 Y168.205 E.1058
G1 X208.057 Y167.633 E.1058
G1 X210.07 Y166.698 E.10581
G1 X211.929 Y165.395 E.10821
G1 X213.462 Y163.861 E.1034
G1 X214.762 Y162 E.1082
G1 X215.695 Y159.986 E.1058
G1 X216.256 Y157.891 E.10341
G1 X216.449 Y155.722 E.10382
M204 S10000
G1 X210.407 Y165.866 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5325
M204 S8000
G3 X208.991 Y166.658 I-2.955 J-3.616 E.05464
G3 X208.573 Y164.086 I4.332 J-2.024 E.08847
G3 X209.235 Y163.15 I1.672 J.48 E.03915
G2 X211.967 Y161.278 I-11.693 J-19.99 E.11106
G2 X213.905 Y157.066 I-4.086 J-4.433 E.15947
G2 X213.179 Y155.662 I-1.892 J.088 E.05463
G3 X210.448 Y153.79 I11.689 J-19.985 E.11106
G3 X208.509 Y149.578 I4.086 J-4.432 E.15947
G3 X209.235 Y148.174 I1.892 J.088 E.05463
G2 X211.767 Y146.464 I-12.45 J-21.158 E.10244
G1 X209.84 Y145.061 E.07987
G1 X207.906 Y144.16 E.0715
G1 X205.845 Y143.607 E.0715
G1 X205.351 Y143.564 E.01663
G3 X206.417 Y146.771 I-5.007 J3.446 E.11475
G3 X205.691 Y148.174 I-1.892 J-.088 E.05463
G2 X202.96 Y150.046 I11.69 J19.986 E.11106
G2 X201.022 Y154.258 I4.086 J4.432 E.15947
G2 X201.748 Y155.662 I1.892 J-.088 E.05463
G3 X204.479 Y157.534 I-11.689 J19.985 E.11106
G3 X206.417 Y161.746 I-4.087 J4.432 E.15947
G3 X205.691 Y163.15 I-1.892 J-.088 E.05463
G2 X202.96 Y165.022 I11.689 J19.985 E.11106
G2 X201.311 Y167.641 I3.861 J4.259 E.10501
G1 X199.533 Y167.164 E.06169
G1 X197.599 Y166.263 E.0715
G1 X195.851 Y165.039 E.07151
G1 X194.343 Y163.53 E.07149
G1 X194.154 Y163.26 E.01104
G1 X194.26 Y163.15 E.00514
G2 X196.991 Y161.278 I-11.693 J-19.99 E.11106
G2 X198.93 Y157.066 I-4.087 J-4.433 E.15947
G2 X198.204 Y155.662 I-1.892 J.088 E.05463
G3 X195.472 Y153.79 I11.691 J-19.987 E.11106
G3 X193.534 Y149.578 I4.086 J-4.432 E.15947
G3 X194.26 Y148.174 I1.892 J.088 E.05463
G2 X196.991 Y146.303 I-11.691 J-19.987 E.11106
G2 X198.144 Y144.807 I-3.582 J-3.953 E.06359
G1 X199.625 Y144.135 E.05452
; WIPE_START
G1 F18423.913
G1 X198.715 Y144.548 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z9.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z9.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 46/82
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X216.809 Y155.662 F60000
G1 Z9.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5535
M204 S8000
G1 X216.611 Y157.935 E.07646
G1 X216.02 Y160.139 E.07646
G1 X215.056 Y162.207 E.07646
G1 X213.747 Y164.076 E.07646
G1 X212.134 Y165.689 E.07646
G1 X210.265 Y166.998 E.07646
G1 X208.197 Y167.963 E.07646
G1 X205.993 Y168.553 E.07646
G1 X203.72 Y168.752 E.07646
G1 X201.447 Y168.553 E.07646
G1 X199.243 Y167.962 E.07646
G1 X197.175 Y166.998 E.07646
G1 X195.306 Y165.689 E.07646
G1 X193.692 Y164.076 E.07646
G1 X192.383 Y162.207 E.07646
G1 X191.419 Y160.139 E.07646
G1 X190.829 Y157.935 E.07646
G1 X190.63 Y155.662 E.07646
G1 X190.829 Y153.389 E.07646
G1 X191.419 Y151.185 E.07646
G1 X191.733 Y150.512 E.02487
G1 X192.383 Y149.117 E.05159
G1 X193.692 Y147.248 E.07646
G1 X195.306 Y145.635 E.07646
G1 X197.175 Y144.326 E.07646
G1 X199.243 Y143.362 E.07646
G1 X201.447 Y142.771 E.07646
G1 X203.72 Y142.572 E.07646
G1 X204.459 Y142.637 E.02487
G1 X205.993 Y142.771 E.05159
G1 X208.197 Y143.362 E.07646
G1 X210.264 Y144.326 E.07646
G1 X212.134 Y145.635 E.07646
G1 X213.747 Y147.248 E.07646
G1 X215.056 Y149.117 E.07646
G1 X216.02 Y151.185 E.07646
G1 X216.611 Y153.389 E.07646
G1 X216.804 Y155.602 E.07445
; COOLING_NODE: 0
M204 S10000
G1 X217.202 Y155.649 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5277
M204 S5000
G1 X217.203 Y155.662 E.00041
G1 X216.998 Y158.003 E.07296
G1 X216.39 Y160.274 E.07295
G1 X215.397 Y162.404 E.07296
G1 X214.048 Y164.329 E.07296
G1 X212.387 Y165.991 E.07296
G1 X210.461 Y167.339 E.07296
G1 X208.331 Y168.332 E.07296
G1 X206.061 Y168.941 E.07295
G1 X203.72 Y169.145 E.07296
G1 X201.378 Y168.941 E.07296
G1 X199.108 Y168.332 E.07295
G1 X196.978 Y167.339 E.07296
G1 X195.053 Y165.991 E.07296
G1 X193.391 Y164.329 E.07296
G1 X192.043 Y162.404 E.07296
G1 X191.049 Y160.274 E.07296
G1 X190.441 Y158.003 E.07295
G1 X190.236 Y155.662 E.07296
G1 X190.441 Y153.321 E.07296
G1 X191.049 Y151.05 E.07295
G1 X191.377 Y150.347 E.0241
G1 X192.043 Y148.92 E.04885
G1 X193.391 Y146.995 E.07296
G1 X195.053 Y145.333 E.07296
G1 X196.978 Y143.985 E.07296
G1 X199.108 Y142.992 E.07296
G1 X201.378 Y142.383 E.07295
G1 X203.72 Y142.179 E.07296
G1 X204.493 Y142.246 E.0241
G1 X206.061 Y142.383 E.04885
G1 X208.331 Y142.992 E.07295
G1 X210.461 Y143.985 E.07296
G1 X212.387 Y145.333 E.07296
G1 X214.048 Y146.995 E.07296
G1 X215.397 Y148.92 E.07296
G1 X216.39 Y151.05 E.07296
G1 X216.998 Y153.321 E.07295
G1 X217.197 Y155.589 E.07068
M204 S10000
G1 X216.314 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.62203
G1 F5535
M204 S8000
G1 X216.124 Y153.493 E.10378
G1 X215.542 Y151.325 E.10703
G1 X214.635 Y149.381 E.10225
G1 X213.378 Y147.581 E.10465
G1 X211.828 Y146.027 E.10464
M73 P75 R3
G1 X210.032 Y144.765 E.10465
G1 X208.044 Y143.835 E.10464
G1 X205.924 Y143.264 E.10465
G1 X203.701 Y143.069 E.10638
G1 X201.551 Y143.257 E.1029
G1 X199.43 Y143.822 E.10465
G1 X197.439 Y144.747 E.10465
G1 X195.601 Y146.037 E.10705
G1 X194.084 Y147.553 E.10224
G1 X192.823 Y149.35 E.10465
G1 X191.892 Y151.338 E.10464
G1 X191.321 Y153.457 E.10465
G1 X191.127 Y155.644 E.10465
G1 X191.315 Y157.831 E.10464
G1 X191.88 Y159.952 E.10464
G1 X192.805 Y161.943 E.10465
G1 X194.094 Y163.781 E.10704
G1 X195.611 Y165.297 E.10224
G1 X197.407 Y166.559 E.10465
G1 X199.395 Y167.489 E.10464
G1 X201.515 Y168.061 E.10465
G1 X203.701 Y168.255 E.10465
G1 X205.888 Y168.067 E.10464
G1 X208.009 Y167.502 E.10464
G1 X210 Y166.577 E.10465
G1 X211.839 Y165.288 E.10705
G1 X213.355 Y163.771 E.10224
G1 X214.641 Y161.93 E.10704
G1 X215.564 Y159.939 E.10464
G1 X216.118 Y157.867 E.10225
G1 X216.309 Y155.722 E.10265
M204 S10000
G1 X215.423 Y152.765 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5535
M204 S8000
G1 X215.466 Y152.927 E.00561
G3 X215.658 Y154.726 I-4.056 J1.341 E.06109
G1 X215.82 Y155.662 E.03183
G1 X215.636 Y157.763 E.07068
G1 X215.09 Y159.801 E.07068
G1 X214.199 Y161.712 E.07068
G1 X212.989 Y163.44 E.07069
G1 X211.498 Y164.932 E.07068
G1 X209.77 Y166.141 E.07069
G1 X208.856 Y166.567 E.03377
G3 X208.17 Y164.086 I6.554 J-3.148 E.08674
G1 X208.268 Y163.618 E.01603
G1 X208.671 Y163.15 E.02068
G3 X211.233 Y161.746 I144.225 J260.195 E.09791
G2 X214.244 Y156.598 I-3.753 J-5.65 E.20692
G1 X214.146 Y156.13 E.01603
G1 X213.743 Y155.662 E.02068
G2 X211.181 Y154.258 I-144.225 J260.195 E.09791
G3 X208.17 Y149.11 I3.753 J-5.65 E.20692
G1 X208.268 Y148.642 E.01603
G1 X208.671 Y148.174 E.02068
G2 X211.608 Y146.503 I-34.239 J-63.604 E.11327
G1 X209.77 Y145.183 E.07586
G1 X207.858 Y144.291 E.07068
G1 X205.821 Y143.745 E.07068
G1 X205.467 Y143.714 E.01191
G3 X206.757 Y147.239 I-5.446 J3.991 E.12743
G1 X206.658 Y147.706 E.01603
G1 X206.256 Y148.174 E.02068
G3 X203.694 Y149.578 I-143.973 J-259.735 E.09791
G2 X200.682 Y154.726 I3.753 J5.65 E.20692
G1 X200.781 Y155.194 E.01603
G1 X201.183 Y155.662 E.02068
G2 X203.746 Y157.066 I144.225 J-260.195 E.09791
G3 X206.757 Y162.214 I-3.753 J5.65 E.20692
G1 X206.658 Y162.682 E.01603
G1 X206.256 Y163.15 E.02068
G3 X203.694 Y164.554 I-144.322 J-260.372 E.09791
G2 X201.253 Y167.481 I3.17 J5.124 E.12995
G1 X199.581 Y167.033 E.05799
G1 X197.669 Y166.141 E.07068
G1 X195.941 Y164.932 E.07069
G1 X194.45 Y163.44 E.07068
G1 X194.087 Y162.922 E.02119
G2 X196.258 Y161.746 I-114.275 J-213.414 E.08274
G2 X199.269 Y156.598 I-3.753 J-5.65 E.20692
G1 X199.171 Y156.13 E.01603
G1 X198.768 Y155.662 E.02068
G2 X196.206 Y154.258 I-144.13 J260.023 E.09791
G3 X193.259 Y149.586 I3.708 J-5.605 E.19078
G1 X194.45 Y147.884 E.06961
G3 X195.437 Y147.239 I1.463 J1.16 E.0402
G2 X198.079 Y144.992 I-2.608 J-5.743 E.11773
G1 X199.554 Y144.304 E.05457
; WIPE_START
G1 F18423.913
G1 X198.648 Y144.726 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z9.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z9.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 9.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 47/82
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X216.669 Y155.662 F60000
G1 Z9.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5401
M204 S8000
G1 X216.473 Y157.911 E.07564
G1 X215.888 Y160.091 E.07564
G1 X214.934 Y162.137 E.07564
G1 X213.64 Y163.986 E.07564
G1 X212.044 Y165.582 E.07564
G1 X210.194 Y166.877 E.07564
G1 X208.149 Y167.831 E.07564
G1 X205.968 Y168.415 E.07564
G1 X203.72 Y168.612 E.07564
G1 X201.471 Y168.415 E.07564
G1 X199.291 Y167.831 E.07564
G1 X197.245 Y166.877 E.07564
G1 X195.396 Y165.582 E.07564
G1 X193.799 Y163.986 E.07564
G1 X192.505 Y162.137 E.07564
G1 X191.551 Y160.091 E.07564
G1 X190.966 Y157.911 E.07564
G1 X190.77 Y155.662 E.07564
G1 X190.966 Y153.413 E.07564
G1 X191.551 Y151.233 E.07564
G1 X191.943 Y150.391 E.03114
G1 X192.505 Y149.187 E.0445
G1 X193.799 Y147.338 E.07564
G1 X195.396 Y145.742 E.07564
G1 X197.245 Y144.447 E.07564
G1 X199.291 Y143.493 E.07564
G1 X201.471 Y142.909 E.07564
G1 X203.72 Y142.712 E.07564
G1 X204.645 Y142.793 E.03114
G1 X205.968 Y142.909 E.0445
G1 X208.149 Y143.493 E.07564
G1 X210.194 Y144.447 E.07564
G1 X212.044 Y145.742 E.07564
G1 X213.64 Y147.338 E.07564
G1 X214.934 Y149.187 E.07564
G1 X215.888 Y151.233 E.07564
G1 X216.473 Y153.413 E.07564
G1 X216.664 Y155.602 E.07363
; COOLING_NODE: 0
M204 S10000
G1 X217.062 Y155.649 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5248
M204 S5000
G1 X217.063 Y155.662 E.00039
G1 X216.86 Y157.979 E.0722
G1 X216.258 Y160.226 E.0722
G1 X215.275 Y162.334 E.0722
G1 X213.941 Y164.239 E.0722
G1 X212.297 Y165.884 E.0722
G1 X210.391 Y167.218 E.0722
G1 X208.283 Y168.201 E.0722
G1 X206.037 Y168.803 E.0722
G1 X203.72 Y169.005 E.0722
G1 X201.403 Y168.803 E.0722
G1 X199.156 Y168.201 E.0722
G1 X197.048 Y167.218 E.0722
G1 X195.143 Y165.884 E.0722
G1 X193.498 Y164.239 E.0722
G1 X192.164 Y162.334 E.0722
G1 X191.181 Y160.226 E.0722
G1 X190.579 Y157.979 E.0722
G1 X190.376 Y155.662 E.0722
G1 X190.579 Y153.345 E.0722
G1 X191.181 Y151.098 E.0722
G1 X191.588 Y150.225 E.02991
G1 X192.164 Y148.99 E.04229
G1 X193.498 Y147.085 E.0722
G1 X195.143 Y145.44 E.0722
G1 X197.048 Y144.106 E.0722
G1 X199.156 Y143.123 E.0722
G1 X201.403 Y142.521 E.0722
G1 X203.72 Y142.319 E.0722
G1 X204.679 Y142.403 E.02991
G1 X206.037 Y142.521 E.04229
G1 X208.283 Y143.123 E.0722
G1 X210.391 Y144.106 E.0722
G1 X212.297 Y145.44 E.0722
G1 X213.941 Y147.085 E.0722
G1 X215.275 Y148.99 E.0722
G1 X216.258 Y151.098 E.0722
G1 X216.86 Y153.345 E.0722
G1 X217.057 Y155.59 E.06994
M204 S10000
G1 X216.174 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.622028
G1 F5401
M204 S8000
G1 X215.986 Y153.518 E.10262
G1 X215.41 Y151.373 E.10587
G1 X214.513 Y149.451 E.10109
G1 X213.271 Y147.671 E.10349
G1 X211.738 Y146.134 E.10348
G1 X209.962 Y144.887 E.10348
G1 X207.996 Y143.966 E.10348
G1 X205.9 Y143.401 E.10348
G1 X203.701 Y143.209 E.10521
G1 X201.575 Y143.395 E.10174
G1 X199.478 Y143.954 E.10348
G1 X197.509 Y144.868 E.10349
G1 X195.691 Y146.144 E.10588
G1 X194.192 Y147.644 E.10108
G1 X192.944 Y149.42 E.10348
G1 X192.024 Y151.386 E.10348
G1 X191.459 Y153.482 E.10348
G1 X191.267 Y155.644 E.10348
G1 X191.453 Y157.807 E.10348
G1 X192.011 Y159.904 E.10347
G1 X192.926 Y161.873 E.10349
G1 X194.201 Y163.691 E.10588
G1 X195.701 Y165.19 E.10108
G1 X197.477 Y166.438 E.10348
G1 X199.443 Y167.358 E.10348
G1 X201.539 Y167.923 E.10348
G1 X203.701 Y168.115 E.10348
G1 X205.864 Y167.929 E.10348
G1 X207.961 Y167.37 E.10347
G1 X209.93 Y166.456 E.10349
G1 X211.749 Y165.18 E.10588
G1 X213.247 Y163.681 E.10108
G1 X214.52 Y161.86 E.10587
G1 X215.432 Y159.891 E.10347
G1 X215.98 Y157.842 E.10108
G1 X216.169 Y155.722 E.10149
M204 S10000
G1 X212.59 Y147.682 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5401
M204 S8000
G1 X211.439 Y146.531 E.05457
G3 X207.931 Y147.816 I-5.081 J-8.442 E.12594
G1 X207.463 Y147.556 E.01793
G1 X206.995 Y146.553 E.03711
G2 X205.643 Y143.87 I-11.951 J4.344 E.10092
G1 X203.72 Y143.702 E.06469
G1 X201.643 Y143.883 E.06987
G1 X199.629 Y144.423 E.06985
G1 X198.013 Y145.176 E.05975
G3 X195.473 Y147.058 I-4.942 J-4.015 E.10705
G1 X194.557 Y147.974 E.0434
G1 X193.361 Y149.682 E.06987
G1 X193.122 Y150.195 E.01897
G2 X194.828 Y153.107 I9.045 J-3.342 E.11369
G2 X199.508 Y155.303 I5.939 J-6.571 E.17578
G1 X199.976 Y155.044 E.01793
G1 X200.444 Y154.04 E.03711
G3 X202.316 Y150.729 I10.249 J3.61 E.12812
G3 X206.995 Y148.533 I5.939 J6.571 E.17578
G1 X207.463 Y148.793 E.01793
G1 X207.931 Y149.796 E.03711
G2 X209.803 Y153.107 I10.25 J-3.61 E.12812
G2 X214.483 Y155.303 I5.939 J-6.571 E.17578
G1 X214.951 Y155.044 E.01793
G2 X215.517 Y153.804 I-14.607 J-7.421 E.04571
G1 X215.68 Y155.662 E.06251
G1 X215.646 Y156.048 E.01297
G1 X215.419 Y156.021 E.00767
G1 X214.951 Y156.28 E.01793
G1 X214.483 Y157.284 E.03711
G3 X212.611 Y160.595 I-10.25 J-3.61 E.12812
G3 X207.931 Y162.791 I-5.939 J-6.571 E.17578
G1 X207.463 Y162.531 E.01793
G1 X206.995 Y161.528 E.03711
G2 X205.123 Y158.217 I-10.25 J3.61 E.12812
G2 X200.444 Y156.021 I-5.939 J6.571 E.17578
G1 X199.976 Y156.28 E.01793
G1 X199.508 Y157.284 E.03711
G3 X197.636 Y160.595 I-10.249 J-3.61 E.12812
G3 X194.011 Y162.57 I-5.903 J-6.521 E.13963
G1 X194.557 Y163.35 E.03193
G1 X196.031 Y164.824 E.06986
G1 X197.739 Y166.02 E.06987
G1 X199.629 Y166.901 E.06986
G1 X201.2 Y167.322 E.05451
G3 X202.316 Y165.704 I6.653 J3.393 E.06604
G3 X206.995 Y163.508 I5.939 J6.571 E.17578
G1 X207.463 Y163.768 E.01793
G2 X208.699 Y166.487 I115.063 J-50.655 E.10009
G2 X210.129 Y165.719 I-1.46 J-4.438 E.05466
; WIPE_START
G1 F18423.913
G1 X209.7 Y166.02 E-.19923
G1 X209.269 Y166.221 E-.18078
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z9.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z9.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 9.6
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 48/82
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X216.529 Y155.662 F60000
G1 Z9.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5266
M204 S8000
G1 X216.335 Y157.886 E.07482
G1 X215.757 Y160.043 E.07482
G1 X214.813 Y162.067 E.07483
G1 X213.532 Y163.896 E.07483
G1 X211.954 Y165.475 E.07482
G1 X210.124 Y166.756 E.07483
G1 X208.101 Y167.699 E.07483
G1 X205.944 Y168.277 E.07482
G1 X203.72 Y168.472 E.07482
G1 X201.495 Y168.277 E.07482
G1 X199.338 Y167.699 E.07482
G1 X197.315 Y166.756 E.07483
G1 X195.486 Y165.475 E.07483
G1 X193.907 Y163.896 E.07482
G1 X192.626 Y162.067 E.07483
G1 X192.154 Y161.055 E.03741
G1 X191.682 Y160.043 E.03742
G1 X191.104 Y157.886 E.07483
G1 X190.91 Y155.662 E.07482
G1 X191.104 Y153.438 E.07482
G1 X191.682 Y151.281 E.07482
G1 X192.626 Y149.257 E.07483
G1 X193.907 Y147.428 E.07483
G1 X195.486 Y145.849 E.07482
G1 X197.315 Y144.568 E.07483
G1 X199.338 Y143.625 E.07483
G1 X201.495 Y143.047 E.07482
G1 X203.72 Y142.852 E.07482
G1 X204.832 Y142.95 E.03741
M73 P76 R3
G1 X205.944 Y143.047 E.03742
G1 X208.101 Y143.625 E.07482
G1 X210.124 Y144.568 E.07483
G1 X211.954 Y145.849 E.07483
G1 X213.532 Y147.428 E.07482
G1 X214.813 Y149.257 E.07483
G1 X215.757 Y151.281 E.07483
G1 X216.335 Y153.438 E.07482
G1 X216.524 Y155.602 E.07281
; COOLING_NODE: 0
M204 S10000
G1 X216.922 Y155.65 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5222
M204 S5000
G1 X216.923 Y155.662 E.00037
G1 X216.722 Y157.955 E.07144
G1 X216.127 Y160.178 E.07144
G1 X215.154 Y162.264 E.07144
G1 X213.834 Y164.149 E.07144
G1 X212.207 Y165.776 E.07144
G1 X210.321 Y167.097 E.07144
G1 X208.235 Y168.069 E.07144
G1 X206.012 Y168.665 E.07144
G1 X203.72 Y168.865 E.07144
G1 X201.427 Y168.665 E.07144
G1 X199.204 Y168.069 E.07144
G1 X197.118 Y167.097 E.07144
G1 X195.233 Y165.776 E.07144
G1 X193.605 Y164.149 E.07144
G1 X192.285 Y162.264 E.07144
G1 X191.799 Y161.221 E.03571
G1 X191.312 Y160.178 E.03573
G1 X190.717 Y157.955 E.07144
G1 X190.516 Y155.662 E.07144
G1 X190.717 Y153.369 E.07144
G1 X191.312 Y151.146 E.07144
G1 X192.285 Y149.06 E.07144
G1 X193.605 Y147.175 E.07144
G1 X195.233 Y145.548 E.07144
G1 X197.118 Y144.228 E.07144
G1 X199.204 Y143.255 E.07144
G1 X201.427 Y142.659 E.07144
G1 X203.72 Y142.459 E.07144
G1 X204.866 Y142.559 E.03572
G1 X206.012 Y142.659 E.03573
G1 X208.235 Y143.255 E.07144
G1 X210.321 Y144.228 E.07144
G1 X212.207 Y145.548 E.07144
G1 X213.834 Y147.175 E.07144
G1 X215.154 Y149.06 E.07144
G1 X216.127 Y151.146 E.07144
G1 X216.722 Y153.369 E.07144
G1 X216.917 Y155.59 E.06921
M204 S10000
G1 X216.034 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.622034
G1 F5266
M204 S8000
G1 X215.849 Y153.542 E.10146
G1 X215.278 Y151.421 E.1047
G1 X214.392 Y149.521 E.09992
G1 X213.163 Y147.761 E.10233
G1 X211.648 Y146.241 E.10231
G1 X209.892 Y145.008 E.10232
G1 X207.948 Y144.098 E.10232
G1 X205.876 Y143.539 E.10232
G1 X203.701 Y143.349 E.10405
G1 X201.6 Y143.533 E.10057
G1 X199.525 Y144.085 E.10233
G1 X197.579 Y144.99 E.10232
G1 X195.781 Y146.251 E.10472
G1 X194.299 Y147.734 E.09991
G1 X193.065 Y149.49 E.10232
G1 X192.155 Y151.434 E.10232
G1 X191.597 Y153.506 E.10232
G1 X191.407 Y155.644 E.10232
G1 X191.591 Y157.782 E.10231
G1 X192.143 Y159.856 E.10231
G1 X193.047 Y161.803 E.10232
G1 X194.309 Y163.601 E.10471
G1 X195.791 Y165.083 E.09991
G1 X197.547 Y166.316 E.10232
G1 X199.491 Y167.226 E.10232
G1 X201.564 Y167.785 E.10232
G1 X203.701 Y167.975 E.10232
G1 X205.84 Y167.791 E.10232
G1 X207.914 Y167.239 E.10231
G1 X209.86 Y166.334 E.10232
G1 X211.659 Y165.073 E.10472
G1 X213.14 Y163.591 E.09991
G1 X214.398 Y161.79 E.10471
G1 X215.3 Y159.843 E.10231
G1 X215.842 Y157.818 E.09992
G1 X216.029 Y155.722 E.10033
M204 S10000
G1 X212.422 Y147.712 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5266
M204 S8000
G1 X211.263 Y146.569 E.05453
G3 X208.399 Y147.293 I-2.678 J-4.563 E.10033
G3 X207.463 Y146.706 I.189 J-1.341 E.03814
G3 X206.059 Y144.34 I150.545 J-90.934 E.09219
G2 X205.54 Y144.001 I-.434 J.098 E.02302
G1 X203.72 Y143.842 E.06122
G1 X201.667 Y144.021 E.06905
G1 X199.677 Y144.554 E.06904
G1 X197.86 Y145.402 E.06719
G3 X196.049 Y146.68 I-3.624 J-3.213 E.07493
G1 X194.665 Y148.064 E.06561
G1 X193.483 Y149.752 E.06905
G1 X193.08 Y150.615 E.03191
G1 X193.424 Y151.242 E.02398
G2 X199.04 Y154.781 I5.71 J-2.836 E.23394
G2 X199.976 Y154.193 I-.189 J-1.341 E.03814
G2 X200.912 Y152.594 I-12.966 J-8.661 E.06214
G3 X206.527 Y149.056 I5.71 J2.836 E.23394
G3 X207.463 Y149.643 I-.189 J1.341 E.03814
G3 X208.399 Y151.242 I-12.969 J8.663 E.06214
G2 X214.015 Y154.781 I5.71 J-2.836 E.23394
G1 X214.483 Y154.624 E.01654
G2 X215.348 Y153.562 I-1.515 J-2.116 E.04645
G1 X215.54 Y155.662 E.07068
G1 X215.45 Y156.69 E.03457
G1 X214.951 Y157.131 E.02232
G2 X214.015 Y158.73 I12.969 J8.663 E.06214
G3 X208.399 Y162.269 I-5.71 J-2.836 E.23394
G3 X207.463 Y161.681 I.189 J-1.341 E.03814
G3 X206.527 Y160.082 I12.969 J-8.663 E.06214
G2 X200.912 Y156.543 I-5.71 J2.836 E.23394
G2 X199.976 Y157.131 I.189 J1.341 E.03814
G2 X199.04 Y158.73 I12.967 J8.661 E.06214
G3 X193.951 Y162.24 I-5.713 J-2.838 E.21628
G1 X194.665 Y163.26 E.04172
G1 X196.121 Y164.717 E.06904
G1 X197.809 Y165.899 E.06905
G1 X199.677 Y166.77 E.06904
G1 X201.158 Y167.166 E.05137
G3 X206.527 Y164.031 I5.411 J3.1 E.21815
G3 X207.463 Y164.618 I-.189 J1.341 E.03814
G3 X208.52 Y166.416 I-38.391 J23.783 E.0699
G1 X209.63 Y165.899 E.04101
G1 X209.961 Y165.667 E.01355
; WIPE_START
G1 F18423.913
G1 X209.63 Y165.899 E-.15369
G1 X209.09 Y166.151 E-.22632
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z10 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z10 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 49/82
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X216.389 Y155.662 F60000
G1 Z9.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5174
M204 S8000
G1 X216.197 Y157.862 E.07401
G1 X215.625 Y159.995 E.07401
G1 X214.692 Y161.997 E.07401
G1 X213.425 Y163.806 E.07401
G1 X211.864 Y165.368 E.07401
G1 X210.796 Y166.115 E.04368
G1 X210.054 Y166.634 E.03033
G1 X208.053 Y167.568 E.07401
G1 X205.92 Y168.139 E.07401
G1 X203.72 Y168.332 E.07401
G1 X201.52 Y168.139 E.07401
G1 X199.386 Y167.568 E.07401
G1 X197.385 Y166.634 E.07401
G1 X195.576 Y165.368 E.07401
G1 X194.014 Y163.806 E.07401
G1 X193.266 Y162.738 E.04368
G1 X192.747 Y161.997 E.03033
G1 X191.814 Y159.995 E.07401
G1 X191.242 Y157.862 E.07401
G1 X191.05 Y155.662 E.07401
G1 X191.242 Y153.462 E.07401
G1 X191.814 Y151.329 E.07401
G1 X192.747 Y149.327 E.07401
G1 X194.014 Y147.518 E.07401
G1 X195.576 Y145.956 E.07401
G1 X197.385 Y144.69 E.07401
G1 X199.386 Y143.756 E.07401
G1 X201.519 Y143.185 E.07401
G1 X203.72 Y142.992 E.07401
G1 X205.018 Y143.106 E.04367
G1 X205.92 Y143.185 E.03033
G1 X208.053 Y143.756 E.07401
G1 X210.054 Y144.69 E.07401
G1 X211.864 Y145.956 E.07401
G1 X213.425 Y147.518 E.07401
G1 X214.692 Y149.327 E.07401
G1 X215.625 Y151.329 E.07401
G1 X215.963 Y152.588 E.04367
G1 X216.197 Y153.462 E.03033
G1 X216.384 Y155.602 E.072
; COOLING_NODE: 0
M204 S10000
G1 X216.782 Y155.651 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5174
M204 S5000
G1 X216.783 Y155.662 E.00034
G1 X216.584 Y157.93 E.07068
G1 X215.995 Y160.13 E.07068
G1 X215.033 Y162.194 E.07068
G1 X213.727 Y164.059 E.07068
G1 X212.117 Y165.669 E.07068
G1 X211.021 Y166.436 E.04152
G1 X210.251 Y166.975 E.02916
G1 X208.187 Y167.938 E.07068
G1 X205.988 Y168.527 E.07068
G1 X203.72 Y168.725 E.07068
G1 X201.451 Y168.527 E.07068
G1 X199.252 Y167.938 E.07068
G1 X197.188 Y166.975 E.07068
G1 X195.323 Y165.669 E.07068
G1 X193.713 Y164.059 E.07068
G1 X192.945 Y162.963 E.04152
G1 X192.406 Y162.194 E.02916
G1 X191.444 Y160.13 E.07068
G1 X190.855 Y157.93 E.07068
G1 X190.656 Y155.662 E.07068
G1 X190.855 Y153.394 E.07068
G1 X191.444 Y151.194 E.07068
G1 X192.406 Y149.13 E.07068
G1 X193.713 Y147.265 E.07068
G1 X195.323 Y145.655 E.07068
G1 X197.188 Y144.349 E.07068
G1 X199.252 Y143.387 E.07068
G1 X201.451 Y142.797 E.07068
G1 X203.72 Y142.599 E.07068
G1 X205.052 Y142.715 E.04152
G1 X205.988 Y142.797 E.02916
G1 X208.187 Y143.387 E.07068
G1 X210.251 Y144.349 E.07068
G1 X212.117 Y145.655 E.07068
G1 X213.727 Y147.265 E.07068
G1 X215.033 Y149.13 E.07068
G1 X215.995 Y151.194 E.07068
G1 X216.341 Y152.486 E.04152
G1 X216.584 Y153.394 E.02916
G1 X216.777 Y155.591 E.06848
M204 S10000
G1 X215.894 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.622465
G1 F5174
M204 S8000
G1 X215.711 Y153.567 E.10035
G1 X215.122 Y151.415 E.1064
G1 X214.271 Y149.591 E.09603
G1 X213.056 Y147.851 E.10123
G1 X211.558 Y146.349 E.10122
G1 X209.822 Y145.129 E.10123
G1 X207.9 Y144.23 E.10121
G1 X205.833 Y143.677 E.10209
G1 X203.701 Y143.489 E.10209
G1 X201.624 Y143.671 E.09949
G1 X199.573 Y144.217 E.10123
G1 X197.649 Y145.111 E.10123
G1 X195.871 Y146.358 E.10363
G1 X194.406 Y147.824 E.09882
G1 X193.187 Y149.56 E.10123
G1 X192.287 Y151.482 E.10123
G1 X191.735 Y153.53 E.10123
G1 X191.547 Y155.644 E.10123
G1 X191.728 Y157.758 E.10122
G1 X192.274 Y159.808 E.10121
G1 X193.181 Y161.747 E.1021
G1 X194.416 Y163.511 E.10275
G1 X195.881 Y164.975 E.09882
G1 X197.617 Y166.195 E.10123
G1 X199.539 Y167.095 E.10123
G1 X201.588 Y167.647 E.10123
G1 X203.701 Y167.835 E.10123
G1 X205.815 Y167.653 E.10122
G1 X207.866 Y167.107 E.10122
G1 X209.79 Y166.213 E.10124
G1 X211.569 Y164.966 E.10363
G1 X213.033 Y163.5 E.09882
G1 X214.277 Y161.72 E.10362
G1 X215.169 Y159.795 E.10122
G1 X215.704 Y157.794 E.09883
G1 X215.889 Y155.722 E.09924
M204 S10000
G1 X212.222 Y147.708 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5174
M204 S8000
G1 X211.045 Y146.587 E.05447
G3 X209.335 Y147.017 I-2.162 J-4.976 E.05935
G3 X207.463 Y146.229 I-.229 J-2.074 E.07108
G2 X206.112 Y144.265 I-55.238 J36.562 E.0799
G1 X205.69 Y144.154 E.01462
G1 X203.72 Y143.982 E.06627
G1 X201.691 Y144.159 E.06823
G1 X199.725 Y144.686 E.06822
G1 X197.879 Y145.546 E.06823
G1 X196.212 Y146.714 E.06823
G1 X194.772 Y148.154 E.06822
G1 X193.604 Y149.822 E.06823
G1 X193.068 Y150.972 E.04252
G1 X193.424 Y151.496 E.02124
G2 X198.104 Y154.505 I5.279 J-3.067 E.19357
G2 X199.976 Y153.717 I.229 J-2.074 E.07108
G1 X200.912 Y152.34 E.05577
G3 X205.591 Y149.332 I5.279 J3.067 E.19357
G3 X207.463 Y150.12 I.229 J2.074 E.07108
G1 X208.399 Y151.496 E.05577
G2 X213.079 Y154.505 I5.279 J-3.067 E.19357
G2 X215.161 Y153.408 I.218 J-2.11 E.08357
G1 X215.4 Y155.662 E.07595
G1 X215.256 Y157.312 E.05551
G1 X214.951 Y157.607 E.01421
G1 X214.015 Y158.984 E.05577
G3 X209.335 Y161.992 I-5.279 J-3.067 E.19357
G3 X207.463 Y161.204 I-.229 J-2.074 E.07108
G1 X206.527 Y159.828 E.05577
G2 X201.848 Y156.819 I-5.279 J3.067 E.19357
G2 X199.976 Y157.607 I-.229 J2.074 E.07108
G1 X199.04 Y158.984 E.05577
G3 X193.946 Y161.991 I-5.193 J-2.977 E.20732
G1 X194.772 Y163.17 E.04823
G1 X196.211 Y164.61 E.06822
G1 X197.879 Y165.778 E.06824
G1 X199.725 Y166.638 E.06823
G1 X201.125 Y167.013 E.04859
M73 P77 R3
G3 X205.591 Y164.307 I5.013 J3.235 E.18112
G3 X207.463 Y165.095 I.229 J2.074 E.07108
G1 X208.321 Y166.355 E.05108
G1 X209.774 Y165.628 E.05445
; WIPE_START
G1 F18423.913
G1 X208.879 Y166.076 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z10.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z10.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 10
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 50/82
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X216.249 Y155.662 F60000
G1 Z10
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5088
M204 S8000
G1 X216.059 Y157.838 E.07319
G1 X215.494 Y159.947 E.07319
G1 X214.571 Y161.927 E.07319
G1 X213.318 Y163.716 E.07319
G1 X211.774 Y165.26 E.07319
G1 X209.984 Y166.513 E.07319
G1 X208.005 Y167.436 E.07319
G1 X206.565 Y167.822 E.04994
G1 X205.895 Y168.001 E.02325
G1 X203.72 Y168.192 E.07319
G1 X201.544 Y168.001 E.07319
G1 X199.434 Y167.436 E.07319
G1 X197.455 Y166.513 E.07319
G1 X195.666 Y165.26 E.07319
G1 X194.121 Y163.716 E.07319
G1 X192.869 Y161.927 E.07319
G1 X191.945 Y159.947 E.07319
G1 X191.56 Y158.508 E.04994
G1 X191.38 Y157.838 E.02325
G1 X191.19 Y155.662 E.07319
G1 X191.38 Y153.486 E.07319
G1 X191.945 Y151.377 E.07319
G1 X192.869 Y149.397 E.07319
G1 X194.121 Y147.608 E.07319
G1 X195.666 Y146.064 E.07319
G1 X197.455 Y144.811 E.07319
G1 X199.434 Y143.888 E.07319
G1 X201.544 Y143.323 E.07319
G1 X203.72 Y143.132 E.07319
G1 X205.204 Y143.262 E.04994
G1 X205.895 Y143.323 E.02325
G1 X208.005 Y143.888 E.07319
G1 X209.984 Y144.811 E.07319
G1 X211.774 Y146.064 E.07319
G1 X213.318 Y147.608 E.07319
G1 X214.571 Y149.397 E.07319
G1 X215.494 Y151.377 E.07319
G1 X215.879 Y152.816 E.04994
G1 X216.059 Y153.486 E.02325
G1 X216.244 Y155.602 E.07118
; COOLING_NODE: 0
M204 S10000
G1 X216.642 Y155.653 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5088
M204 S5000
G1 X216.643 Y155.662 E.00029
G1 X216.447 Y157.906 E.06992
G1 X215.863 Y160.082 E.06992
G1 X214.911 Y162.124 E.06992
G1 X213.619 Y163.969 E.06993
G1 X212.027 Y165.562 E.06992
G1 X210.181 Y166.854 E.06993
G1 X208.14 Y167.806 E.06992
G1 X206.667 Y168.201 E.04733
G1 X205.964 Y168.389 E.0226
G1 X203.72 Y168.585 E.06992
G1 X201.475 Y168.389 E.06992
G1 X199.3 Y167.806 E.06992
G1 X197.258 Y166.854 E.06992
G1 X195.413 Y165.562 E.06993
G1 X193.82 Y163.969 E.06992
G1 X192.528 Y162.124 E.06993
G1 X191.576 Y160.082 E.06992
G1 X191.181 Y158.609 E.04733
G1 X190.993 Y157.906 E.0226
G1 X190.796 Y155.662 E.06992
G1 X190.993 Y153.418 E.06992
G1 X191.576 Y151.242 E.06992
G1 X192.528 Y149.2 E.06992
G1 X193.82 Y147.355 E.06993
G1 X195.413 Y145.762 E.06992
G1 X197.258 Y144.47 E.06993
G1 X199.3 Y143.518 E.06992
G1 X201.475 Y142.935 E.06992
G1 X203.72 Y142.739 E.06992
G1 X205.238 Y142.872 E.04733
G1 X205.964 Y142.935 E.0226
G1 X208.14 Y143.518 E.06992
G1 X210.181 Y144.47 E.06992
G1 X212.027 Y145.762 E.06993
G1 X213.619 Y147.355 E.06992
G1 X214.911 Y149.2 E.06993
G1 X215.863 Y151.242 E.06992
G1 X216.258 Y152.715 E.04733
G1 X216.447 Y153.418 E.0226
G1 X216.637 Y155.593 E.06777
M204 S10000
G1 X215.74 Y155.662 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.650266
G1 F5088
M204 S8000
G1 X215.559 Y153.594 E.10378
G1 X215.02 Y151.57 E.10474
G1 X214.138 Y149.67 E.10474
G1 X212.904 Y147.911 E.10738
G1 X211.46 Y146.468 E.1021
G1 X209.746 Y145.263 E.10474
G1 X207.848 Y144.375 E.10474
G1 X205.826 Y143.829 E.10475
G1 X203.719 Y143.644 E.10573
G1 X201.652 Y143.823 E.10373
G1 X199.627 Y144.362 E.10476
G1 X197.727 Y145.244 E.10474
G1 X195.969 Y146.477 E.10738
G1 X194.492 Y147.963 E.10473
G1 X193.321 Y149.636 E.1021
G1 X192.446 Y151.504 E.10311
G1 X191.887 Y153.556 E.10633
G1 X191.701 Y155.643 E.10476
G1 X191.88 Y157.73 E.10474
G1 X192.419 Y159.754 E.10474
G1 X193.301 Y161.655 E.10474
G1 X194.535 Y163.413 E.10738
G1 X195.979 Y164.856 E.1021
G1 X197.693 Y166.061 E.10474
G1 X199.591 Y166.949 E.10474
G1 X201.613 Y167.495 E.10474
G1 X203.7 Y167.681 E.10474
G1 X205.787 Y167.501 E.10474
G1 X207.812 Y166.963 E.10474
G1 X209.712 Y166.08 E.10474
G1 X211.47 Y164.847 E.10738
G1 X212.914 Y163.402 E.1021
G1 X214.144 Y161.642 E.10738
G1 X215.024 Y159.741 E.10474
G1 X215.552 Y157.768 E.1021
G1 X215.735 Y155.722 E.10271
M204 S10000
G1 X211.963 Y147.687 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5088
M204 S8000
G2 X210.763 Y146.593 I-3.7 J2.857 E.05468
G1 X210.271 Y146.731 E.01711
G3 X207.931 Y146.327 I-.718 J-2.814 E.08197
G3 X206.43 Y144.516 I13.346 J-12.587 E.07888
G1 X205.719 Y144.325 E.02469
G1 X203.752 Y144.153 E.06617
G1 X201.72 Y144.325 E.06832
G1 X199.782 Y144.844 E.06722
G1 X197.964 Y145.692 E.06725
G1 X196.32 Y146.843 E.06725
G1 X194.901 Y148.262 E.06724
G1 X193.75 Y149.906 E.06725
G1 X193.104 Y151.29 E.05118
G1 X193.424 Y151.712 E.01774
G2 X198.104 Y154.301 I4.874 J-3.286 E.18606
G2 X199.976 Y153.358 I-.068 J-2.466 E.07254
G1 X200.912 Y152.124 E.0519
G3 X205.591 Y149.536 I4.874 J3.286 E.18606
G3 X207.463 Y150.478 I-.068 J2.466 E.07254
G1 X208.399 Y151.712 E.0519
G2 X213.079 Y154.301 I4.874 J-3.286 E.18606
G2 X214.969 Y153.335 I-.115 J-2.556 E.07334
G1 X215.057 Y153.663 E.01139
G1 X215.232 Y155.662 E.06724
G1 X215.057 Y157.661 E.06725
M73 P77 R2
G3 X214.951 Y157.966 I-.309 J.063 E.01134
G1 X214.015 Y159.2 E.0519
G3 X209.335 Y161.789 I-4.874 J-3.286 E.18606
G3 X207.463 Y160.846 I.068 J-2.466 E.07254
G1 X206.527 Y159.612 E.0519
G2 X201.848 Y157.023 I-4.874 J3.286 E.18606
G2 X199.976 Y157.966 I.068 J2.466 E.07254
G3 X198.572 Y159.785 I-36.612 J-26.799 E.07702
G3 X193.98 Y161.746 I-4.185 J-3.443 E.1739
G1 X194.901 Y163.062 E.05382
G1 X196.32 Y164.481 E.06724
G1 X197.964 Y165.632 E.06725
G1 X199.782 Y166.48 E.06725
G1 X201.12 Y166.839 E.04642
G3 X203.72 Y164.855 I4.749 J3.529 E.111
G3 X206.527 Y164.711 I1.61 J3.941 E.09602
G3 X208.089 Y166.278 I-2.243 J3.796 E.07495
G1 X209.556 Y165.575 E.05452
; WIPE_START
G1 F18423.913
G1 X208.655 Y166.007 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z10.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z10.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 10.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 51/82
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X216.109 Y155.662 F60000
G1 Z10.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F7971
M204 S8000
G1 X215.921 Y157.813 E.07237
G1 X215.362 Y159.9 E.07237
G1 X214.449 Y161.857 E.07237
G1 X213.211 Y163.626 E.07237
G1 X211.683 Y165.153 E.07237
G1 X209.914 Y166.392 E.07237
G1 X207.957 Y167.305 E.07237
G1 X206.337 Y167.739 E.05621
G1 X205.871 Y167.863 E.01616
G1 X203.72 Y168.052 E.07237
G1 X201.568 Y167.863 E.07237
G1 X199.482 Y167.305 E.07237
G1 X197.525 Y166.392 E.07237
G1 X195.756 Y165.153 E.07237
G1 X194.229 Y163.626 E.07237
G1 X192.99 Y161.857 E.07237
G1 X192.077 Y159.9 E.07237
G1 X191.643 Y158.279 E.05621
G1 X191.518 Y157.813 E.01616
G1 X191.33 Y155.662 E.07237
G1 X191.518 Y153.511 E.07237
G1 X192.077 Y151.425 E.07237
G1 X192.99 Y149.467 E.07237
G1 X194.229 Y147.698 E.07237
G1 X195.756 Y146.171 E.07237
G1 X197.525 Y144.932 E.07237
G1 X199.482 Y144.02 E.07237
G1 X201.568 Y143.461 E.07237
G1 X203.72 Y143.272 E.07237
G1 X205.391 Y143.419 E.05621
G1 X205.871 Y143.461 E.01616
G1 X207.957 Y144.02 E.07237
G1 X209.914 Y144.932 E.07237
G1 X211.683 Y146.171 E.07237
G1 X213.211 Y147.698 E.07237
G1 X214.449 Y149.467 E.07237
G1 X215.362 Y151.425 E.07237
G1 X215.796 Y153.045 E.05621
G1 X215.921 Y153.511 E.01616
G1 X216.104 Y155.602 E.07036
; COOLING_NODE: 0
M204 S10000
G1 X216.502 Y155.655 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5208
M204 S5000
G1 X216.503 Y155.662 E.00023
G1 X216.309 Y157.882 E.06917
G1 X215.732 Y160.034 E.06917
G1 X214.79 Y162.054 E.06917
G1 X213.512 Y163.879 E.06917
G1 X211.936 Y165.455 E.06917
G1 X210.111 Y166.733 E.06917
G1 X208.092 Y167.674 E.06917
G1 X205.939 Y168.251 E.06917
G1 X203.72 Y168.445 E.06917
G1 X201.5 Y168.251 E.06917
G1 X199.347 Y167.674 E.06917
G1 X197.328 Y166.733 E.06917
G1 X195.503 Y165.455 E.06917
G1 X193.927 Y163.879 E.06917
G1 X192.649 Y162.054 E.06917
G1 X191.707 Y160.034 E.06917
G1 X191.131 Y157.882 E.06917
G1 X190.936 Y155.662 E.06917
G1 X191.131 Y153.442 E.06917
G1 X191.707 Y151.29 E.06917
G1 X192.649 Y149.27 E.06917
G1 X193.927 Y147.445 E.06917
G1 X195.503 Y145.87 E.06917
G1 X197.328 Y144.591 E.06917
G1 X199.347 Y143.65 E.06917
G1 X201.5 Y143.073 E.06917
G1 X203.72 Y142.879 E.06917
G1 X205.425 Y143.028 E.05313
G1 X205.939 Y143.073 E.01603
G1 X208.092 Y143.65 E.06917
G1 X210.111 Y144.591 E.06917
G1 X211.936 Y145.87 E.06917
G1 X213.512 Y147.445 E.06917
G1 X214.79 Y149.27 E.06917
G1 X215.732 Y151.29 E.06917
G1 X216.309 Y153.442 E.06917
G1 X216.497 Y155.595 E.06707
M204 S10000
G1 X215.736 Y155.677 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.376381
G1 F7971
M204 S8000
G1 X215.558 Y153.612 E.05689
G1 X214.991 Y151.506 E.05987
G1 X214.143 Y149.686 E.0551
G1 X212.947 Y147.967 E.05749
G1 X211.47 Y146.482 E.05749
G1 X209.759 Y145.275 E.05749
G1 X207.863 Y144.385 E.05749
G1 X205.842 Y143.836 E.05749
G1 X203.683 Y143.647 E.05949
G1 X201.669 Y143.824 E.05548
G1 X199.645 Y144.359 E.05749
G1 X197.744 Y145.239 E.05749
G1 X195.958 Y146.492 E.05987
G1 X194.539 Y147.911 E.0551
G1 X193.333 Y149.623 E.05749
G1 X192.442 Y151.518 E.05749
G1 X191.894 Y153.54 E.05749
G1 X191.705 Y155.626 E.05749
G1 X191.881 Y157.712 E.05748
G1 X192.417 Y159.737 E.05749
G1 X193.296 Y161.638 E.05749
G1 X194.549 Y163.423 E.05987
G1 X195.969 Y164.842 E.0551
G1 X197.681 Y166.049 E.05749
G1 X199.576 Y166.94 E.05749
G1 X201.597 Y167.488 E.05749
G1 X203.683 Y167.677 E.05749
G1 X205.77 Y167.5 E.05748
G1 X207.794 Y166.965 E.05749
G1 X209.695 Y166.085 E.05749
G1 X211.481 Y164.833 E.05987
G1 X212.9 Y163.413 E.0551
G1 X214.149 Y161.625 E.05987
G1 X215.026 Y159.723 E.05748
G1 X215.545 Y157.784 E.0551
G1 X215.731 Y155.736 E.05645
M204 S10000
G1 X215.22 Y153.612 F60000
; Slow Down Start
; LINE_WIDTH: 0.376649
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X215.402 Y155.67 E.05673
G1 X215.223 Y157.698 E.05594
G1 X214.695 Y159.665 E.05594
G1 X213.833 Y161.51 E.05594
G1 X212.682 Y163.154 E.05514
G1 X211.223 Y164.616 E.05674
G1 X209.554 Y165.783 E.05594
G1 X207.708 Y166.642 E.05594
G1 X205.741 Y167.168 E.05594
G1 X203.741 Y167.344 E.05514
G1 X201.684 Y167.165 E.05674
G1 X199.717 Y166.637 E.05594
G1 X197.872 Y165.775 E.05594
G1 X196.205 Y164.606 E.05594
M73 P78 R2
G1 X194.785 Y163.188 E.05515
G1 X193.599 Y161.497 E.05674
G1 X192.739 Y159.65 E.05594
G1 X192.214 Y157.683 E.05594
G1 X192.037 Y155.655 E.05594
G1 X192.211 Y153.655 E.05515
G1 X192.745 Y151.659 E.05674
G1 X193.606 Y149.814 E.05594
G1 X194.775 Y148.147 E.05594
G1 X196.216 Y146.708 E.05594
G1 X197.86 Y145.556 E.05515
G1 X199.721 Y144.685 E.05644
G3 X201.699 Y144.156 I114.004 J422.471 E.05625
G1 X203.712 Y143.98 E.05552
G1 X205.756 Y144.159 E.05636
G1 X207.722 Y144.687 E.05594
G1 X209.567 Y145.549 E.05594
G1 X211.234 Y146.718 E.05594
G1 X212.673 Y148.159 E.05594
G1 X213.84 Y149.828 E.05595
G1 X214.7 Y151.674 E.05594
G1 X215.205 Y153.554 E.0535
; Slow Down End
M204 S10000
G1 X211.641 Y147.646 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7971
M204 S8000
G2 X210.41 Y146.59 I-3.612 J2.962 E.05464
G1 X210.271 Y146.62 E.00476
G3 X208.399 Y146.345 I-.482 J-3.229 E.06432
G3 X206.851 Y144.834 I3.072 J-4.698 E.07294
G1 X205.684 Y144.522 E.04049
G1 X203.72 Y144.35 E.06608
G1 X201.755 Y144.522 E.06608
G1 X199.851 Y145.032 E.06607
G1 X198.064 Y145.865 E.06608
G1 X196.448 Y146.996 E.06608
G1 X195.054 Y148.391 E.06608
G1 X193.923 Y150.006 E.06608
G1 X193.177 Y151.606 E.05917
G1 X193.424 Y151.906 E.01302
G2 X196.232 Y153.905 I4.959 J-3.993 E.11697
G2 X199.04 Y153.832 I1.307 J-3.787 E.09617
G2 X200.912 Y151.931 I-3.964 J-5.774 E.08997
G3 X203.72 Y149.931 I4.959 J3.993 E.11697
G3 X206.527 Y150.004 I1.307 J3.787 E.09617
G3 X208.399 Y151.906 I-3.964 J5.774 E.08997
G2 X212.143 Y154.107 I4.559 J-3.469 E.14927
G2 X214.744 Y153.264 I.497 J-2.897 E.09528
G1 X214.86 Y153.698 E.01505
G1 X215.032 Y155.662 E.06608
G1 X214.86 Y157.626 E.06608
G1 X214.564 Y158.729 E.03824
G1 X214.015 Y159.393 E.0289
G3 X211.207 Y161.393 I-4.959 J-3.993 E.11697
G3 X208.399 Y161.32 I-1.307 J-3.787 E.09617
G3 X206.527 Y159.418 I3.963 J-5.774 E.08997
G2 X202.784 Y157.217 I-4.559 J3.469 E.14927
G2 X200.444 Y157.808 I-.498 J2.957 E.08323
G2 X198.104 Y160.362 I807.827 J742.389 E.11608
G3 X194.084 Y161.549 I-3.347 J-3.934 E.14461
G1 X195.054 Y162.933 E.05664
G1 X196.448 Y164.328 E.06608
G1 X198.063 Y165.459 E.06608
G1 X199.851 Y166.292 E.06608
G1 X201.165 Y166.644 E.04559
G3 X204.656 Y164.705 I4.14 J3.34 E.13718
G3 X207.822 Y166.183 I.439 J3.19 E.12379
G1 X209.298 Y165.495 E.05457
; WIPE_START
G1 F18423.913
G1 X208.392 Y165.917 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z10.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z10.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 52/82
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X215.969 Y155.662 F60000
G1 Z10.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F7767
M204 S8000
G1 X215.783 Y157.789 E.07155
G1 X215.23 Y159.852 E.07155
G1 X214.328 Y161.787 E.07155
G1 X213.103 Y163.536 E.07155
G1 X211.593 Y165.046 E.07155
G1 X209.844 Y166.271 E.07155
G1 X207.909 Y167.173 E.07155
G1 X206.108 Y167.655 E.06248
G1 X205.847 Y167.726 E.00908
G1 X203.72 Y167.912 E.07155
G1 X201.592 Y167.726 E.07155
G1 X199.53 Y167.173 E.07155
G1 X197.595 Y166.271 E.07155
G1 X195.846 Y165.046 E.07155
G1 X194.336 Y163.536 E.07155
G1 X193.111 Y161.787 E.07155
G1 X192.209 Y159.852 E.07155
G1 X191.726 Y158.051 E.06248
G1 X191.656 Y157.789 E.00908
G1 X191.47 Y155.662 E.07155
G1 X191.656 Y153.535 E.07155
G1 X192.209 Y151.472 E.07155
G1 X193.111 Y149.537 E.07155
G1 X194.336 Y147.788 E.07155
G1 X195.846 Y146.278 E.07155
G1 X197.595 Y145.054 E.07155
G1 X199.53 Y144.151 E.07155
G1 X201.592 Y143.599 E.07155
G1 X203.72 Y143.412 E.07155
G1 X205.577 Y143.575 E.06248
G1 X205.847 Y143.599 E.00908
G1 X207.909 Y144.151 E.07155
G1 X209.844 Y145.054 E.07155
G1 X211.593 Y146.278 E.07155
G1 X213.103 Y147.788 E.07155
G1 X214.328 Y149.537 E.07155
G1 X215.23 Y151.472 E.07155
G1 X215.713 Y153.273 E.06248
G1 X215.783 Y153.535 E.00908
G1 X215.964 Y155.602 E.06954
; COOLING_NODE: 0
M204 S10000
G1 X216.362 Y155.657 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5216
M204 S5000
G1 X216.363 Y155.662 E.00017
G1 X216.171 Y157.858 E.06841
G1 X215.6 Y159.986 E.06841
G1 X214.669 Y161.984 E.06841
G1 X213.405 Y163.789 E.06841
G1 X211.846 Y165.347 E.06841
G1 X210.041 Y166.611 E.06841
G1 X208.044 Y167.543 E.06841
G1 X205.915 Y168.113 E.06841
G1 X203.72 Y168.305 E.06841
G1 X201.524 Y168.113 E.06841
G1 X199.395 Y167.543 E.06841
G1 X197.398 Y166.611 E.06841
G1 X195.593 Y165.347 E.06841
G1 X194.034 Y163.789 E.06841
G1 X192.77 Y161.984 E.06841
G1 X191.839 Y159.986 E.06841
G1 X191.268 Y157.858 E.06841
G1 X191.076 Y155.662 E.06841
G1 X191.268 Y153.467 E.06841
G1 X191.839 Y151.338 E.06841
G1 X192.77 Y149.34 E.06841
G1 X194.034 Y147.535 E.06841
G1 X195.593 Y145.977 E.06841
G1 X197.398 Y144.713 E.06841
G1 X199.395 Y143.781 E.06841
G1 X201.524 Y143.211 E.06841
G1 X203.72 Y143.019 E.06841
G1 X205.611 Y143.184 E.05894
G1 X205.915 Y143.211 E.00947
G1 X208.044 Y143.781 E.06841
G1 X210.041 Y144.713 E.06841
G1 X211.846 Y145.977 E.06841
G1 X213.405 Y147.535 E.06841
G1 X214.669 Y149.34 E.06841
G1 X215.6 Y151.338 E.06841
G1 X216.171 Y153.467 E.06841
G1 X216.357 Y155.597 E.06638
M204 S10000
G1 X215.581 Y155.678 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.406244
G1 F7767
M204 S8000
G1 X215.406 Y153.643 E.0611
G1 X214.844 Y151.555 E.06465
G1 X214.01 Y149.767 E.059
G1 X212.83 Y148.07 E.06183
G1 X211.373 Y146.603 E.06182
G1 X209.684 Y145.412 E.06183
G1 X207.814 Y144.532 E.06183
G1 X205.819 Y143.99 E.06183
G1 X203.679 Y143.803 E.06424
G1 X201.7 Y143.976 E.05941
G1 X199.702 Y144.504 E.06183
G1 X197.825 Y145.371 E.06183
G1 X196.055 Y146.613 E.06466
G1 X194.661 Y148.008 E.05899
G1 X193.469 Y149.698 E.06183
G1 X192.589 Y151.568 E.06182
G1 X192.047 Y153.563 E.06183
G1 X191.86 Y155.622 E.06183
G1 X192.033 Y157.682 E.06182
G1 X192.562 Y159.68 E.06182
G1 X193.429 Y161.557 E.06183
G1 X194.671 Y163.326 E.06466
G1 X196.066 Y164.721 E.05899
G1 X197.755 Y165.912 E.06183
G1 X199.625 Y166.792 E.06183
G1 X201.62 Y167.334 E.06183
G1 X203.679 Y167.521 E.06183
G1 X205.739 Y167.348 E.06182
G1 X207.738 Y166.82 E.06182
G1 X209.614 Y165.953 E.06183
G1 X211.384 Y164.711 E.06466
G1 X212.778 Y163.316 E.05899
G1 X214.016 Y161.544 E.06465
G1 X214.881 Y159.667 E.06182
G1 X215.392 Y157.761 E.05899
G1 X215.576 Y155.738 E.06077
M204 S10000
G1 X215.038 Y153.643 F60000
; Slow Down Start
; LINE_WIDTH: 0.406502
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X215.217 Y155.671 E.06092
G1 X215.04 Y157.667 E.05998
G1 X214.52 Y159.603 E.05998
G1 X213.672 Y161.418 E.05998
G1 X212.521 Y163.059 E.05998
G1 X211.103 Y164.475 E.05998
G1 X209.488 Y165.607 E.05904
G1 X207.643 Y166.469 E.06092
G1 X205.707 Y166.986 E.05998
G1 X203.711 Y167.159 E.05998
G1 X201.714 Y166.983 E.05998
G1 X199.779 Y166.463 E.05998
G1 X197.963 Y165.614 E.05998
G1 X196.347 Y164.484 E.05904
G1 X194.907 Y163.045 E.06092
G1 X193.758 Y161.403 E.05998
G1 X192.913 Y159.586 E.05998
G1 X192.396 Y157.65 E.05998
G1 X192.223 Y155.653 E.05998
G1 X192.399 Y153.657 E.05998
G1 X192.919 Y151.721 E.05998
G1 X193.767 Y149.906 E.05997
G1 X194.898 Y148.29 E.05904
G1 X196.336 Y146.849 E.06092
G1 X197.979 Y145.701 E.05999
G1 X199.796 Y144.855 E.05998
G1 X201.732 Y144.338 E.05998
G1 X203.711 Y144.165 E.05945
G1 X205.725 Y144.341 E.06051
G1 X207.66 Y144.861 E.05998
G1 X209.476 Y145.71 E.05998
G1 X211.116 Y146.86 E.05998
G1 X212.532 Y148.279 E.05998
G1 X213.681 Y149.921 E.05999
G1 X214.526 Y151.738 E.05998
G1 X215.022 Y153.585 E.05724
; Slow Down End
M204 S10000
G1 X211.211 Y147.498 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7767
M204 S8000
G2 X209.932 Y146.498 I-3.474 J3.126 E.05467
G3 X207.332 Y145.17 I.127 J-3.458 E.10102
G2 X204.077 Y144.581 I-3.296 J8.935 E.11139
G1 X203.72 Y144.55 E.01203
G1 X201.79 Y144.719 E.06492
G1 X199.919 Y145.22 E.0649
G1 X198.164 Y146.039 E.06491
G1 X196.577 Y147.15 E.06491
G1 X195.207 Y148.519 E.0649
G1 X194.096 Y150.106 E.06492
G1 X193.278 Y151.861 E.0649
G2 X196.232 Y153.864 I4.682 J-3.727 E.12145
G2 X199.04 Y153.594 I1.054 J-3.774 E.0967
G2 X200.912 Y151.751 I-4.995 J-6.944 E.08839
G3 X203.72 Y149.972 I4.525 J4.038 E.11282
G3 X206.527 Y150.242 I1.054 J3.774 E.0967
G3 X208.399 Y152.086 I-4.995 J6.945 E.08839
G2 X212.143 Y154.007 I4.166 J-3.509 E.14477
G2 X214.525 Y153.216 I.259 J-3.203 E.08639
G1 X214.663 Y153.732 E.0179
G1 X214.832 Y155.662 E.06491
G1 X214.663 Y157.592 E.06491
G1 X214.183 Y159.384 E.0622
G1 X214.015 Y159.573 E.00846
G3 X211.207 Y161.352 I-4.525 J-4.038 E.11282
G3 X208.399 Y161.082 I-1.054 J-3.774 E.0967
G3 X206.527 Y159.238 I4.994 J-6.944 E.08839
G2 X203.72 Y157.46 I-4.525 J4.038 E.11282
G2 X200.912 Y157.73 I-1.054 J3.774 E.0967
G2 X199.04 Y159.573 I4.995 J6.944 E.08839
G3 X194.36 Y161.437 I-4.058 J-3.384 E.17594
G1 X194.222 Y161.398 E.0048
G1 X195.207 Y162.805 E.05755
G1 X196.577 Y164.174 E.0649
G1 X198.164 Y165.286 E.06492
G1 X199.919 Y166.104 E.06491
G1 X201.207 Y166.449 E.04469
G3 X203.72 Y164.948 I4.078 J3.97 E.0992
G3 X207.551 Y166.09 I1.05 J3.475 E.14187
G1 X209.026 Y165.402 E.05457
; WIPE_START
G1 F18423.913
G1 X208.12 Y165.824 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z10.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z10.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 10.6
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 53/82
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X215.829 Y155.662 F60000
G1 Z10.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F7660
M204 S8000
G1 X215.645 Y157.765 E.07073
G1 X215.099 Y159.804 E.07073
G1 X214.207 Y161.717 E.07074
G1 X212.996 Y163.446 E.07073
G1 X211.503 Y164.939 E.07074
G1 X209.774 Y166.149 E.07074
G1 X207.861 Y167.041 E.07074
G1 X205.822 Y167.588 E.07073
G1 X203.72 Y167.772 E.07073
G1 X201.617 Y167.588 E.07073
G1 X199.578 Y167.041 E.07073
G1 X197.665 Y166.149 E.07074
G1 X195.936 Y164.939 E.07073
G1 X194.443 Y163.446 E.07073
G1 X193.266 Y161.765 E.06875
G1 X192.34 Y159.804 E.0727
G1 X191.794 Y157.765 E.07073
G1 X191.61 Y155.662 E.07073
G1 X191.794 Y153.559 E.07073
G1 X192.34 Y151.52 E.07073
G1 X193.232 Y149.607 E.07074
G1 X194.443 Y147.878 E.07074
G1 X195.936 Y146.386 E.07073
G1 X197.665 Y145.175 E.07074
G1 X199.578 Y144.283 E.07074
G1 X201.617 Y143.736 E.07073
G1 X203.72 Y143.552 E.07074
M73 P79 R2
G1 X205.763 Y143.731 E.06874
G1 X207.861 Y144.283 E.07269
G1 X209.774 Y145.175 E.07074
G1 X211.503 Y146.386 E.07074
G1 X212.996 Y147.878 E.07073
G1 X214.207 Y149.607 E.07073
G1 X215.074 Y151.466 E.06874
G1 X215.645 Y153.559 E.0727
G1 X215.824 Y155.602 E.06872
; COOLING_NODE: 0
M204 S10000
G1 X216.222 Y155.659 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5222
M204 S5000
G1 X216.223 Y155.662 E.00011
G1 X216.033 Y157.833 E.06765
G1 X215.469 Y159.938 E.06765
G1 X214.548 Y161.914 E.06765
G1 X213.351 Y163.622 E.06474
G1 X213.298 Y163.699 E.00291
G1 X211.756 Y165.24 E.06765
G1 X209.971 Y166.49 E.06765
G1 X207.996 Y167.411 E.06765
G1 X205.891 Y167.975 E.06765
G1 X203.72 Y168.165 E.06765
G1 X201.548 Y167.975 E.06765
G1 X199.443 Y167.411 E.06765
G1 X197.468 Y166.49 E.06765
G1 X195.683 Y165.24 E.06765
G1 X194.142 Y163.699 E.06765
G1 X192.892 Y161.914 E.06765
G1 X191.97 Y159.938 E.06765
G1 X191.406 Y157.833 E.06765
G1 X191.216 Y155.662 E.06765
G1 X191.406 Y153.491 E.06765
G1 X191.97 Y151.386 E.06765
G1 X192.891 Y149.41 E.06765
G1 X194.142 Y147.625 E.06765
G1 X195.683 Y146.084 E.06765
G1 X197.468 Y144.834 E.06765
G1 X199.443 Y143.913 E.06765
G1 X201.548 Y143.349 E.06765
G1 X203.72 Y143.159 E.06765
G1 X205.797 Y143.341 E.06474
G1 X205.891 Y143.349 E.00291
G1 X207.996 Y143.913 E.06765
G1 X209.971 Y144.834 E.06765
G1 X211.756 Y146.084 E.06765
G1 X213.298 Y147.625 E.06765
G1 X214.548 Y149.41 E.06765
G1 X215.469 Y151.386 E.06765
G1 X216.033 Y153.491 E.06765
G1 X216.217 Y155.599 E.06568
; WIPE_START
G1 F12000
M204 S8000
G1 X216.223 Y155.662 E-.02414
G1 X216.141 Y156.595 E-.35586
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z11 I1.165 J-.352 P1  F60000
G1 X215.251 Y153.648 Z11
G1 Z10.6
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.435897
G1 F7660
M204 S8000
G1 X214.69 Y151.589 E.06901
G1 X213.878 Y149.848 E.06215
G1 X212.714 Y148.173 E.066
G1 X211.197 Y146.659 E.06931
G1 X209.61 Y145.548 E.06268
G1 X207.666 Y144.645 E.06934
G1 X205.678 Y144.125 E.06649
G1 X203.778 Y143.959 E.06169
G1 X201.731 Y144.128 E.06644
G1 X199.758 Y144.649 E.066
G1 X197.906 Y145.504 E.066
G1 X196.23 Y146.668 E.066
G1 X194.717 Y148.184 E.06931
G1 X193.606 Y149.772 E.06268
G1 X192.737 Y151.617 E.06599
G1 X192.201 Y153.586 E.066
G1 X192.016 Y155.618 E.066
G1 X192.186 Y157.651 E.06599
G1 X192.706 Y159.623 E.066
G1 X193.623 Y161.578 E.06983
G1 X194.725 Y163.151 E.06215
G1 X196.242 Y164.665 E.06931
G1 X197.829 Y165.776 E.06268
G1 X199.675 Y166.645 E.066
G1 X201.644 Y167.18 E.066
G1 X203.675 Y167.366 E.066
G1 X205.708 Y167.196 E.06599
G1 X207.681 Y166.675 E.066
G1 X209.533 Y165.82 E.066
G1 X211.209 Y164.656 E.066
G1 X212.722 Y163.14 E.06931
G1 X213.833 Y161.552 E.06268
G1 X214.737 Y159.61 E.06931
G1 X215.255 Y157.637 E.06599
G1 X215.423 Y155.706 E.06268
G1 X215.256 Y153.707 E.06489
M204 S10000
G1 X214.855 Y153.674 F60000
; Slow Down Start
; LINE_WIDTH: 0.436045
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X215.031 Y155.672 E.06491
G1 X214.858 Y157.636 E.06381
G1 X214.346 Y159.54 E.06381
G1 X213.528 Y161.297 E.06271
G1 X212.379 Y162.941 E.06491
G1 X210.983 Y164.334 E.06381
G1 X209.396 Y165.446 E.06271
G1 X207.579 Y166.295 E.06491
G1 X205.674 Y166.804 E.06381
G1 X203.744 Y166.974 E.0627
G1 X201.745 Y166.8 E.06491
G1 X199.841 Y166.288 E.06381
G1 X198.085 Y165.47 E.06271
G1 X196.441 Y164.321 E.06491
G1 X195.048 Y162.925 E.06381
G1 X193.945 Y161.352 E.06217
G1 X193.099 Y159.553 E.06433
G1 X192.578 Y157.616 E.06491
G1 X192.408 Y155.652 E.06381
G1 X192.581 Y153.688 E.06381
G1 X193.082 Y151.816 E.06271
G1 X193.921 Y150.009 E.06447
G3 X195.061 Y148.383 I282.118 J196.654 E.06425
G1 X196.456 Y146.99 E.06381
G1 X198.043 Y145.878 E.06271
G1 X199.86 Y145.029 E.06492
G1 X201.765 Y144.52 E.06381
G1 X203.709 Y144.35 E.06315
G1 X205.693 Y144.526 E.06445
G1 X207.598 Y145.036 E.06381
G1 X209.355 Y145.854 E.06271
G1 X210.998 Y147.003 E.06491
G1 X212.391 Y148.399 E.06381
G1 X213.521 Y150.015 E.06381
G1 X214.334 Y151.756 E.06217
G1 X214.839 Y153.616 E.06239
; Slow Down End
M204 S10000
G1 X210.625 Y147.226 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F7660
M204 S8000
G1 X209.291 Y146.292 E.05457
G3 X208.26 Y145.785 I1.04 J-3.413 E.03868
G1 X207.452 Y145.408 E.02988
G1 X205.614 Y144.916 E.06374
G1 X203.72 Y144.75 E.06374
G1 X201.825 Y144.916 E.06374
G1 X199.988 Y145.408 E.06373
G1 X198.263 Y146.212 E.06375
G1 X196.705 Y147.303 E.06374
G1 X195.36 Y148.648 E.06374
G1 X194.269 Y150.206 E.06375
G1 X193.465 Y151.93 E.06374
G1 X193.388 Y152.219 E.01003
G2 X195.296 Y153.559 I4.007 J-3.677 E.07874
G2 X199.04 Y153.378 I1.687 J-3.923 E.13003
G2 X200.912 Y151.579 I-6.872 J-9.022 E.0872
G3 X202.784 Y150.277 I3.967 J3.708 E.07698
G3 X206.527 Y150.458 I1.687 J3.923 E.13003
G3 X208.399 Y152.258 I-6.872 J9.022 E.0872
G2 X211.207 Y153.832 I4.103 J-4.024 E.10935
G2 X214.303 Y153.159 I.809 J-3.734 E.10947
G1 X214.466 Y153.767 E.02109
G1 X214.632 Y155.662 E.06374
G1 X214.466 Y157.557 E.06374
G1 X213.974 Y159.394 E.06374
G1 X213.675 Y160.035 E.02369
G3 X212.143 Y161.047 I-3.122 J-3.061 E.06198
G3 X208.399 Y160.866 I-1.687 J-3.923 E.13003
G3 X206.527 Y159.067 I6.871 J-9.021 E.0872
G2 X204.656 Y157.765 I-3.967 J3.707 E.07698
G2 X200.912 Y157.946 I-1.687 J3.922 E.13003
G2 X199.04 Y159.745 I6.871 J9.021 E.0872
G3 X194.387 Y161.287 I-3.716 J-3.422 E.17148
G1 X195.36 Y162.676 E.05684
G1 X196.705 Y164.021 E.06374
G1 X198.264 Y165.112 E.06374
G1 X199.987 Y165.916 E.06374
G1 X201.26 Y166.257 E.04416
G3 X203.72 Y164.979 I3.618 J3.957 E.09394
G3 X206.995 Y165.789 I.855 J3.571 E.11749
G2 X207.452 Y165.916 I.267 J-.074 E.01905
G1 X208.69 Y165.339 E.04577
; WIPE_START
G1 F18423.913
G1 X207.783 Y165.761 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z11 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z11 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 10.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 54/82
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X215.661 Y155.662 F60000
G1 Z10.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5562
M204 S8000
G1 X215.48 Y157.736 E.06975
G1 X214.941 Y159.746 E.06975
G1 X214.061 Y161.633 E.06975
G1 X212.867 Y163.338 E.06975
G1 X211.395 Y164.81 E.06975
G1 X209.69 Y166.004 E.06975
G1 X207.804 Y166.883 E.06976
G1 X205.793 Y167.422 E.06975
G1 X203.72 Y167.603 E.06975
G1 X201.646 Y167.422 E.06975
G1 X199.635 Y166.883 E.06975
G1 X197.749 Y166.004 E.06975
G1 X196.044 Y164.81 E.06975
G1 X194.572 Y163.338 E.06975
G1 X193.378 Y161.633 E.06975
G1 X192.498 Y159.746 E.06976
G1 X191.96 Y157.736 E.06975
G1 X191.778 Y155.662 E.06975
G1 X191.96 Y153.588 E.06975
G1 X192.512 Y151.548 E.07083
G1 X193.378 Y149.691 E.06866
G1 X194.572 Y147.986 E.06975
G1 X196.044 Y146.514 E.06975
G1 X197.749 Y145.321 E.06975
G1 X199.635 Y144.441 E.06975
G1 X201.646 Y143.902 E.06975
G1 X203.752 Y143.724 E.07083
G1 X205.793 Y143.902 E.06866
G1 X207.804 Y144.441 E.06975
G1 X209.69 Y145.321 E.06975
G1 X211.395 Y146.514 E.06975
G1 X212.867 Y147.986 E.06975
G1 X214.061 Y149.691 E.06975
G1 X214.941 Y151.578 E.06975
G1 X215.48 Y153.588 E.06975
G1 X215.656 Y155.602 E.06774
; COOLING_NODE: 0
M204 S10000
G1 X216.055 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5220
M204 S5000
G1 X215.867 Y157.804 E.06674
G1 X215.311 Y159.881 E.06674
G1 X214.402 Y161.829 E.06674
G1 X213.169 Y163.591 E.06674
G1 X211.648 Y165.111 E.06674
G1 X209.887 Y166.344 E.06674
G1 X207.874 Y167.27 E.06879
G1 X205.862 Y167.81 E.06466
G1 X203.72 Y167.997 E.06674
G1 X201.578 Y167.81 E.06674
G1 X199.501 Y167.253 E.06674
G1 X197.552 Y166.344 E.06674
G1 X195.791 Y165.111 E.06674
G1 X194.27 Y163.591 E.06674
G1 X193.037 Y161.83 E.06674
G1 X192.129 Y159.881 E.06674
G1 X191.572 Y157.804 E.06674
G1 X191.385 Y155.662 E.06674
G1 X191.572 Y153.52 E.06674
G1 X192.129 Y151.443 E.06674
G1 X193.037 Y149.495 E.06674
G1 X194.27 Y147.733 E.06674
G1 X195.791 Y146.213 E.06674
G1 X197.552 Y144.98 E.06674
G1 X199.501 Y144.071 E.06674
G1 X201.578 Y143.515 E.06674
G1 X203.786 Y143.333 E.06879
G1 X205.862 Y143.515 E.06466
G1 X207.938 Y144.071 E.06674
G1 X209.887 Y144.98 E.06674
G1 X211.648 Y146.213 E.06674
G1 X213.169 Y147.733 E.06674
G1 X214.402 Y149.495 E.06674
G1 X215.311 Y151.443 E.06674
G1 X215.867 Y153.52 E.06674
G1 X216.049 Y155.602 E.06488
M204 S10000
G1 X215.249 Y155.68 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.451863
G1 F5562
M204 S8000
G1 X215.08 Y153.706 E.06669
G1 X214.568 Y151.763 E.06764
G1 X213.726 Y149.938 E.06765
G1 X212.51 Y148.206 E.07123
G1 X211.165 Y146.861 E.06405
G1 X209.523 Y145.702 E.06764
G1 X207.706 Y144.846 E.06764
G1 X205.767 Y144.318 E.06765
G1 X203.752 Y144.133 E.06812
G2 X201.658 Y144.321 I7.713 J97.588 E.07075
G1 X199.821 Y144.814 E.06405
G1 X197.996 Y145.656 E.06765
G1 X196.345 Y146.802 E.06765
G1 X194.851 Y148.299 E.07123
G1 X193.76 Y149.858 E.06405
G1 X192.897 Y151.689 E.06812
G2 X192.358 Y153.72 I89.228 J24.783 E.07076
G1 X192.192 Y155.616 E.06406
G1 X192.359 Y157.618 E.06764
G1 X192.871 Y159.561 E.06764
G1 X193.713 Y161.386 E.06765
G1 X194.859 Y163.036 E.06765
G1 X196.274 Y164.463 E.06764
G1 X197.916 Y165.622 E.06764
G1 X199.733 Y166.479 E.06764
G1 X201.778 Y167.024 E.07123
G1 X203.673 Y167.19 E.06406
G1 X205.676 Y167.023 E.06764
G1 X207.619 Y166.51 E.06764
G1 X209.443 Y165.668 E.06765
G1 X211.094 Y164.522 E.06765
G1 X212.52 Y163.107 E.06764
G1 X213.732 Y161.373 E.07122
G1 X214.572 Y159.547 E.06764
G1 X215.064 Y157.709 E.06405
G1 X215.244 Y155.74 E.06659
M204 S10000
G1 X199.906 Y166.108 F60000
; LINE_WIDTH: 0.451859
G1 F5562
M204 S8000
G1 X198.15 Y165.287 E.06525
G1 X196.564 Y164.173 E.06525
G1 X195.194 Y162.801 E.06525
G1 X194.084 Y161.213 E.06525
G1 X193.279 Y159.488 E.06406
G1 X192.767 Y157.582 E.06644
G1 X192.6 Y155.651 E.06525
G1 X192.771 Y153.721 E.06525
G1 X193.276 Y151.846 E.06536
G1 X194.095 Y150.093 E.06514
G1 X195.208 Y148.506 E.06525
G1 X196.553 Y147.16 E.06406
G1 X198.169 Y146.027 E.06645
G1 X199.893 Y145.222 E.06406
G1 X201.799 Y144.709 E.06644
G1 X203.744 Y144.543 E.06571
G1 X205.661 Y144.713 E.06478
G1 X207.533 Y145.217 E.06525
G1 X209.289 Y146.037 E.06525
M73 P80 R2
G1 X210.875 Y147.151 E.06525
G1 X212.245 Y148.523 E.06525
G1 X213.355 Y150.112 E.06526
G1 X214.16 Y151.836 E.06406
G1 X214.672 Y153.742 E.06644
G1 X214.839 Y155.673 E.06525
G1 X214.669 Y157.604 E.06525
G1 X214.165 Y159.475 E.06525
G1 X213.344 Y161.231 E.06525
G1 X212.231 Y162.818 E.06525
G1 X210.859 Y164.187 E.06525
G1 X209.27 Y165.297 E.06526
G1 X207.512 Y166.115 E.06525
G1 X205.64 Y166.615 E.06525
G1 X203.709 Y166.782 E.06525
G1 X201.778 Y166.611 E.06525
G1 X199.963 Y166.126 E.06323
M204 S10000
G1 X208.322 Y165.29 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5562
M204 S8000
G3 X206.811 Y165.882 I-2.432 J-3.99 E.05465
G2 X202.784 Y165.218 I-2.583 J3.124 E.14334
G2 X201.322 Y166.067 I1.165 J3.687 E.05712
G1 X200.056 Y165.728 E.04392
G1 X198.364 Y164.939 E.06257
G1 X196.834 Y163.868 E.06258
G1 X195.514 Y162.548 E.06257
G1 X194.556 Y161.18 E.05593
G2 X199.04 Y159.913 I1.091 J-4.703 E.16293
G3 X201.38 Y157.864 I8.901 J7.802 E.10453
G3 X206.527 Y158.899 I1.797 J4.38 E.18651
G2 X208.867 Y160.948 I8.9 J-7.802 E.10453
G2 X213.226 Y160.526 I1.806 J-4.067 E.15342
G1 X213.786 Y159.326 E.04439
G1 X214.269 Y157.522 E.06257
G1 X214.432 Y155.662 E.06257
G1 X214.269 Y153.802 E.06257
G1 X214.086 Y153.118 E.02374
G3 X209.335 Y153.153 I-2.402 J-3.592 E.16854
G3 X207.463 Y151.48 I5.465 J-7.998 E.08437
G2 X204.656 Y149.999 I-3.394 J3.034 E.10865
G2 X200.912 Y151.411 I-.298 J4.879 E.13814
G3 X198.572 Y153.46 I-8.9 J-7.802 E.10453
G3 X193.519 Y152.499 I-1.805 J-4.272 E.18269
G3 X194.122 Y150.993 I4.575 J.957 E.05466
; WIPE_START
G1 F18423.913
G1 X193.7 Y151.899 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z11.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z11.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 55/82
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X215.461 Y155.662 F60000
G1 Z11
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5472
M204 S8000
G1 X215.283 Y157.701 E.06858
G1 X214.753 Y159.678 E.06858
G1 X213.888 Y161.533 E.06858
G1 X212.714 Y163.209 E.06858
G1 X211.267 Y164.656 E.06859
G1 X209.59 Y165.83 E.06858
G1 X209.396 Y165.921 E.00719
G1 X207.735 Y166.695 E.06139
G1 X205.758 Y167.225 E.06858
G1 X203.72 Y167.403 E.06858
G1 X201.681 Y167.225 E.06858
G1 X199.704 Y166.695 E.06858
G1 X197.849 Y165.83 E.06858
G1 X196.172 Y164.656 E.06858
G1 X194.725 Y163.209 E.06859
G1 X193.551 Y161.533 E.06858
G1 X193.461 Y161.338 E.00719
G1 X192.686 Y159.678 E.06139
G1 X192.157 Y157.701 E.06858
G1 X191.978 Y155.662 E.06858
G1 X192.157 Y153.623 E.06858
G1 X192.686 Y151.646 E.06859
G1 X193.551 Y149.791 E.06858
G1 X194.725 Y148.115 E.06858
G1 X196.172 Y146.668 E.06858
G1 X197.849 Y145.494 E.06858
G1 X199.704 Y144.629 E.06859
G1 X201.681 Y144.099 E.06858
G1 X203.72 Y143.921 E.06858
G1 X203.933 Y143.939 E.00719
G1 X205.758 Y144.099 E.06139
G1 X207.735 Y144.629 E.06859
G1 X209.59 Y145.494 E.06858
G1 X211.267 Y146.668 E.06858
G1 X212.714 Y148.115 E.06858
G1 X213.888 Y149.791 E.06858
G1 X214.753 Y151.646 E.06859
G1 X215.283 Y153.623 E.06858
G1 X215.456 Y155.602 E.06657
; COOLING_NODE: 0
M204 S10000
G1 X215.855 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5210
M204 S5000
G1 X215.67 Y157.769 E.06566
G1 X215.123 Y159.812 E.06566
G1 X214.229 Y161.73 E.06566
G1 X213.015 Y163.462 E.06566
G1 X211.52 Y164.958 E.06566
G1 X209.787 Y166.171 E.06566
G1 X209.561 Y166.276 E.00773
G1 X207.87 Y167.065 E.05793
G1 X205.827 Y167.613 E.06566
G1 X203.72 Y167.797 E.06566
G1 X201.612 Y167.613 E.06566
G1 X199.569 Y167.065 E.06566
G1 X197.652 Y166.171 E.06566
G1 X195.919 Y164.958 E.06566
G1 X194.424 Y163.462 E.06566
G1 X193.21 Y161.73 E.06566
G1 X193.105 Y161.504 E.00773
G1 X192.316 Y159.812 E.05793
G1 X191.769 Y157.769 E.06566
G1 X191.585 Y155.662 E.06566
G1 X191.769 Y153.555 E.06566
G1 X192.316 Y151.512 E.06566
G1 X192.422 Y151.286 E.00773
G1 X193.21 Y149.595 E.05793
G1 X194.424 Y147.862 E.06566
G1 X195.919 Y146.366 E.06566
G1 X197.652 Y145.153 E.06566
G1 X199.569 Y144.259 E.06566
G1 X201.612 Y143.711 E.06566
G1 X203.72 Y143.527 E.06566
G1 X203.967 Y143.549 E.00772
G1 X205.827 Y143.711 E.05793
G1 X207.87 Y144.259 E.06566
G1 X209.787 Y145.153 E.06566
G1 X211.52 Y146.366 E.06566
G1 X213.015 Y147.862 E.06566
G1 X214.229 Y149.595 E.06566
G1 X215.123 Y151.512 E.06566
G1 X215.67 Y153.555 E.06566
G1 X215.849 Y155.602 E.0638
M204 S10000
G1 X215.049 Y155.68 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.451937
G1 F5472
M204 S8000
G1 X214.883 Y153.741 E.06553
G1 X214.342 Y151.731 E.07006
G1 X213.553 Y150.038 E.0629
G1 X212.427 Y148.416 E.06649
G1 X211.036 Y147.014 E.06648
G1 X209.423 Y145.875 E.06648
G1 X207.637 Y145.034 E.06648
G1 X205.732 Y144.515 E.06649
G1 X203.673 Y144.334 E.0696
G1 X201.798 Y144.499 E.06336
G1 X199.889 Y145.002 E.06648
G1 X198.096 Y145.829 E.06649
G1 X196.392 Y147.024 E.07007
G1 X195.072 Y148.345 E.06289
G1 X193.933 Y149.958 E.06648
G1 X193.091 Y151.744 E.06648
G1 X192.572 Y153.649 E.06648
G1 X192.392 Y155.616 E.06648
G1 X192.556 Y157.583 E.06648
G1 X193.059 Y159.493 E.06648
G1 X193.886 Y161.286 E.06649
G1 X195.082 Y162.989 E.07007
G1 X196.403 Y164.31 E.06289
G1 X198.016 Y165.449 E.06648
G1 X199.802 Y166.291 E.06648
G1 X201.707 Y166.809 E.06648
G1 X203.673 Y166.99 E.06648
G1 X205.641 Y166.826 E.06648
G1 X207.55 Y166.322 E.06648
G1 X209.343 Y165.495 E.06649
G1 X211.047 Y164.3 E.07007
G1 X212.367 Y162.979 E.06289
G1 X213.559 Y161.273 E.07006
G1 X214.384 Y159.479 E.06647
G1 X214.867 Y157.675 E.06289
G1 X215.044 Y155.74 E.06542
M204 S10000
G1 X200.008 Y165.931 F60000
; LINE_WIDTH: 0.451937
G1 F5472
M204 S8000
G1 X198.25 Y165.113 E.06528
G1 X196.692 Y164.02 E.06409
G1 X195.348 Y162.673 E.06409
G1 X194.257 Y161.113 E.06409
G1 X193.455 Y159.386 E.06409
G1 X192.964 Y157.548 E.06408
G1 X192.8 Y155.687 E.06289
G1 X192.968 Y153.755 E.06528
G1 X193.462 Y151.917 E.06409
G1 X194.268 Y150.193 E.06409
G1 X195.361 Y148.635 E.06409
G1 X196.709 Y147.29 E.06409
G1 X198.269 Y146.2 E.06409
G1 X199.962 Y145.409 E.0629
G1 X201.834 Y144.906 E.06528
G1 X203.709 Y144.742 E.06336
G1 X205.626 Y144.91 E.06481
G1 X207.465 Y145.405 E.06409
G1 X209.189 Y146.211 E.06409
G1 X210.747 Y147.304 E.06409
G1 X212.091 Y148.651 E.06409
G1 X213.182 Y150.212 E.06409
G1 X213.972 Y151.904 E.0629
G1 X214.475 Y153.777 E.06528
G1 X214.639 Y155.673 E.06408
G1 X214.472 Y157.569 E.06409
G1 X213.977 Y159.407 E.06409
G1 X213.171 Y161.131 E.06409
G1 X212.078 Y162.689 E.06409
G1 X210.73 Y164.034 E.06409
G1 X209.17 Y165.124 E.06409
G1 X207.444 Y165.927 E.06409
G1 X205.605 Y166.418 E.06408
G1 X203.709 Y166.582 E.06409
G1 X201.813 Y166.414 E.06409
G1 X200.066 Y165.947 E.06087
M204 S10000
G1 X207.977 Y165.232 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5472
M204 S8000
G3 X206.447 Y165.773 I-2.299 J-4.066 E.05464
G2 X201.39 Y165.879 I-2.455 J3.524 E.18124
G1 X200.124 Y165.54 E.04392
G1 X198.464 Y164.766 E.0614
G1 X196.962 Y163.715 E.06141
G1 X195.667 Y162.419 E.0614
G1 X194.753 Y161.114 E.05341
G2 X199.04 Y160.08 I1.184 J-4.498 E.15396
G3 X200.912 Y158.331 I24.83 J24.688 E.08588
G3 X206.527 Y158.731 I2.557 J3.722 E.2037
G2 X208.399 Y160.481 I24.826 J-24.684 E.08588
G2 X212.864 Y160.832 I2.533 J-3.655 E.15726
G1 X213.598 Y159.257 E.0582
G1 X214.072 Y157.487 E.0614
G1 X214.232 Y155.662 E.0614
G1 X214.072 Y153.837 E.06141
G1 X213.868 Y153.077 E.02636
G3 X209.335 Y153.257 I-2.417 J-3.692 E.15967
G3 X207.463 Y151.686 I4.167 J-6.867 E.08221
G2 X205.591 Y150.312 I-4.049 J3.556 E.07842
G2 X200.912 Y151.244 I-1.544 J4.465 E.16762
G3 X199.04 Y152.993 I-24.833 J-24.691 E.08588
G3 X193.656 Y152.757 I-2.54 J-3.571 E.19448
G3 X194.227 Y151.239 I7.358 J1.9 E.05446
; WIPE_START
G1 F18423.913
G1 X193.841 Y152.067 E-.34704
G1 X193.819 Y152.15 E-.03296
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z11.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z11.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 11.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 56/82
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X215.261 Y155.662 F60000
G1 Z11.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5379
M204 S8000
G1 X215.086 Y157.666 E.06742
G1 X214.565 Y159.609 E.06741
G1 X213.715 Y161.433 E.06742
G1 X212.561 Y163.081 E.06742
G1 X211.138 Y164.503 E.06742
G1 X209.49 Y165.657 E.06742
G1 X207.667 Y166.507 E.06742
G1 X207.284 Y166.61 E.01328
G1 X205.724 Y167.028 E.05413
G1 X203.72 Y167.203 E.06741
G1 X201.715 Y167.028 E.06742
G1 X199.772 Y166.507 E.06741
G1 X197.949 Y165.657 E.06742
G1 X196.301 Y164.503 E.06742
G1 X194.878 Y163.081 E.06742
G1 X193.724 Y161.433 E.06742
G1 X192.874 Y159.609 E.06742
G1 X192.772 Y159.227 E.01328
G1 X192.354 Y157.666 E.05413
G1 X192.178 Y155.662 E.06741
G1 X192.354 Y153.658 E.06742
G1 X192.874 Y151.715 E.06742
G1 X193.724 Y149.891 E.06741
G1 X194.878 Y148.243 E.06742
G1 X196.301 Y146.821 E.06741
G1 X197.949 Y145.667 E.06742
G1 X199.772 Y144.817 E.06742
G1 X201.715 Y144.296 E.06741
G1 X203.72 Y144.121 E.06741
G1 X204.114 Y144.155 E.01328
G1 X205.724 Y144.296 E.05413
G1 X207.667 Y144.817 E.06741
G1 X209.49 Y145.667 E.06742
G1 X211.138 Y146.821 E.06742
G1 X212.561 Y148.243 E.06742
G1 X213.715 Y149.891 E.06742
G1 X214.565 Y151.715 E.06742
G1 X215.086 Y153.658 E.06741
G1 X215.256 Y155.602 E.06541
; COOLING_NODE: 0
M204 S10000
G1 X215.655 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5193
M204 S5000
G1 X215.473 Y157.735 E.06458
G1 X214.935 Y159.744 E.06458
G1 X214.056 Y161.629 E.06458
G1 X212.862 Y163.334 E.06458
G1 X211.391 Y164.805 E.06458
G1 X209.687 Y165.998 E.06458
G1 X207.802 Y166.877 E.06458
G1 X207.386 Y166.989 E.01337
G1 X205.792 Y167.416 E.05121
G1 X203.72 Y167.597 E.06458
G1 X201.647 Y167.416 E.06458
G1 X199.638 Y166.877 E.06458
G1 X197.752 Y165.998 E.06458
G1 X196.048 Y164.805 E.06458
G1 X194.577 Y163.334 E.06458
G1 X193.384 Y161.629 E.06458
G1 X192.504 Y159.744 E.06458
G1 X192.393 Y159.328 E.01337
G1 X191.966 Y157.735 E.05121
G1 X191.785 Y155.662 E.06458
G1 X191.966 Y153.59 E.06458
G1 X192.504 Y151.58 E.06458
G1 X192.686 Y151.19 E.01337
G1 X193.384 Y149.695 E.05121
G1 X194.577 Y147.99 E.06458
G1 X196.048 Y146.519 E.06458
G1 X197.752 Y145.326 E.06458
G1 X199.638 Y144.447 E.06458
G1 X201.647 Y143.908 E.06458
G1 X203.72 Y143.727 E.06458
G1 X204.149 Y143.765 E.01337
G1 X205.792 Y143.908 E.05121
G1 X207.802 Y144.447 E.06458
G1 X209.687 Y145.326 E.06458
G1 X211.391 Y146.519 E.06458
G1 X212.862 Y147.99 E.06458
G1 X214.056 Y149.695 E.06458
M73 P81 R2
G1 X214.935 Y151.58 E.06458
G1 X215.473 Y153.59 E.06458
G1 X215.649 Y155.602 E.06272
M204 S10000
G1 X214.849 Y155.68 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.451936
G1 F5379
M204 S8000
G1 X214.686 Y153.775 E.06436
G1 X214.154 Y151.8 E.06889
G1 X213.379 Y150.138 E.06172
G1 X212.273 Y148.545 E.06531
G1 X210.908 Y147.168 E.06531
G1 X209.323 Y146.048 E.06531
G1 X207.569 Y145.221 E.06531
G1 X205.697 Y144.712 E.06531
G1 X203.673 Y144.534 E.06842
G1 X201.833 Y144.695 E.06218
G1 X199.957 Y145.19 E.06531
G1 X198.196 Y146.002 E.06531
G1 X196.521 Y147.178 E.0689
G1 X195.225 Y148.474 E.06171
G1 X194.106 Y150.058 E.06531
G1 X193.279 Y151.813 E.06531
G1 X192.769 Y153.684 E.06531
G1 X192.592 Y155.616 E.06531
G1 X192.753 Y157.549 E.0653
G1 X193.247 Y159.424 E.0653
G1 X194.06 Y161.186 E.06531
G1 X195.235 Y162.861 E.06889
G1 X196.531 Y164.156 E.06172
G1 X198.116 Y165.276 E.06531
G1 X199.87 Y166.103 E.06531
G1 X201.742 Y166.612 E.06531
G1 X203.673 Y166.79 E.06531
G1 X205.606 Y166.629 E.06531
G1 X207.482 Y166.134 E.0653
G1 X209.243 Y165.322 E.06531
G1 X210.918 Y164.146 E.0689
G1 X212.214 Y162.85 E.06171
G1 X213.386 Y161.173 E.06889
G1 X214.196 Y159.411 E.0653
G1 X214.67 Y157.64 E.06172
G1 X214.844 Y155.74 E.06425
M204 S10000
G1 X200.05 Y145.589 F60000
; LINE_WIDTH: 0.451936
G1 F5379
M204 S8000
G3 X201.869 Y145.103 I76.227 J281.855 E.0634
G1 X203.709 Y144.942 E.06218
G1 X205.592 Y145.107 E.06364
G1 X207.396 Y145.592 E.06291
G1 X209.089 Y146.384 E.06292
G1 X210.618 Y147.457 E.06291
G1 X211.938 Y148.78 E.06291
G1 X213.009 Y150.312 E.06292
G1 X213.797 Y152.006 E.06292
G1 X214.272 Y153.776 E.06172
G1 X214.439 Y155.673 E.0641
G1 X214.275 Y157.534 E.06292
G1 X213.789 Y159.339 E.06291
G1 X212.998 Y161.031 E.06292
G1 X211.924 Y162.561 E.06291
G1 X210.602 Y163.881 E.06291
G1 X209.07 Y164.951 E.06292
G1 X207.376 Y165.739 E.06292
G1 X205.57 Y166.221 E.06291
G1 X203.709 Y166.382 E.06291
G1 X201.847 Y166.217 E.06292
G1 X200.043 Y165.732 E.06291
G1 X198.381 Y164.958 E.06172
G1 X196.821 Y163.867 E.06411
G1 X195.501 Y162.544 E.06291
G1 X194.431 Y161.013 E.06292
G1 X193.643 Y159.318 E.06292
G1 X193.161 Y157.513 E.06291
G1 X193 Y155.651 E.06291
G1 X193.165 Y153.79 E.06292
G1 X193.65 Y151.986 E.06291
G1 X194.441 Y150.293 E.06292
G1 X195.515 Y148.763 E.06291
G1 X196.837 Y147.443 E.06291
G1 X198.369 Y146.373 E.06292
G1 X199.995 Y145.614 E.06042
M204 S10000
G1 X213.119 Y151.512 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5379
M204 S8000
G3 X213.653 Y153.043 I-4.077 J2.281 E.05464
G3 X208.399 Y152.762 I-2.441 J-3.618 E.18924
G2 X206.527 Y151.02 I-177.678 J189.014 E.0857
G2 X200.912 Y151.074 I-2.775 J3.447 E.20387
G3 X199.04 Y152.816 I-178.077 J-189.441 E.0857
G3 X193.797 Y153.003 I-2.745 J-3.367 E.18876
G2 X194.789 Y160.818 I9.771 J2.73 E.27111
G1 X194.98 Y161.091 E.01115
G2 X199.04 Y160.25 I1.211 J-4.377 E.14429
G3 X200.912 Y158.508 I177.487 J188.808 E.0857
G3 X206.527 Y158.562 I2.775 J3.447 E.20387
G2 X208.399 Y160.304 I177.678 J-189.014 E.0857
G2 X212.481 Y161.059 I2.767 J-3.549 E.14459
G1 X211.619 Y162.291 E.05038
G1 X210.348 Y163.562 E.06023
G1 X208.876 Y164.593 E.06024
G1 X207.246 Y165.352 E.06024
G1 X206.024 Y165.68 E.04239
G2 X201.848 Y165.445 I-2.312 J3.85 E.14583
G1 X201.463 Y165.693 E.01533
G1 X200.193 Y165.352 E.04409
G1 X199.909 Y165.22 E.01048
; WIPE_START
G1 F18423.913
G1 X200.193 Y165.352 E-.11883
G1 X200.857 Y165.53 E-.26118
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z11.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z11.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 11.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 57/82
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X215.061 Y155.662 F60000
G1 Z11.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5262
M204 S8000
G1 X214.889 Y157.631 E.06625
G1 X214.377 Y159.541 E.06625
G1 X213.541 Y161.333 E.06625
G1 X212.408 Y162.952 E.06625
G1 X211.01 Y164.35 E.06625
G1 X209.39 Y165.484 E.06625
G1 X208.866 Y165.728 E.01938
G1 X207.599 Y166.319 E.04687
G1 X205.689 Y166.831 E.06625
G1 X203.72 Y167.003 E.06625
G1 X201.75 Y166.831 E.06625
G1 X199.841 Y166.319 E.06625
G1 X198.049 Y165.484 E.06625
G1 X196.429 Y164.35 E.06625
G1 X195.032 Y162.952 E.06625
G1 X193.898 Y161.333 E.06625
G1 X193.653 Y160.809 E.01938
G1 X193.062 Y159.541 E.04687
G1 X192.551 Y157.631 E.06625
G1 X192.378 Y155.662 E.06625
G1 X192.551 Y153.693 E.06625
G1 X193.062 Y151.783 E.06625
G1 X193.898 Y149.991 E.06625
G1 X195.032 Y148.372 E.06625
G1 X196.429 Y146.974 E.06625
G1 X198.049 Y145.84 E.06625
G1 X199.841 Y145.005 E.06625
G1 X201.75 Y144.493 E.06625
G1 X203.72 Y144.321 E.06625
G1 X204.296 Y144.371 E.01938
G1 X205.689 Y144.493 E.04687
G1 X207.598 Y145.005 E.06625
G1 X209.39 Y145.84 E.06625
G1 X211.01 Y146.974 E.06625
G1 X212.408 Y148.372 E.06625
G1 X213.541 Y149.991 E.06625
G1 X214.377 Y151.783 E.06625
G1 X214.889 Y153.693 E.06625
G1 X215.056 Y155.602 E.06424
; COOLING_NODE: 0
M204 S10000
G1 X215.455 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5175
M204 S5000
G1 X215.276 Y157.7 E.06349
G1 X214.747 Y159.676 E.06349
G1 X213.882 Y161.53 E.0635
G1 X212.709 Y163.205 E.06349
G1 X211.263 Y164.652 E.0635
G1 X209.587 Y165.825 E.06349
G1 X209.032 Y166.084 E.01901
G1 X207.733 Y166.689 E.04448
G1 X205.757 Y167.219 E.06349
G1 X203.72 Y167.397 E.06349
G1 X201.682 Y167.219 E.06349
G1 X199.706 Y166.689 E.06349
G1 X197.852 Y165.825 E.0635
G1 X196.177 Y164.652 E.06349
G1 X194.73 Y163.205 E.0635
G1 X193.557 Y161.53 E.06349
G1 X193.298 Y160.974 E.01901
G1 X192.692 Y159.676 E.04448
G1 X192.163 Y157.7 E.06349
G1 X191.985 Y155.662 E.0635
G1 X192.163 Y153.624 E.06349
G1 X192.692 Y151.648 E.06349
G1 X192.951 Y151.093 E.01901
G1 X193.557 Y149.795 E.04448
G1 X194.73 Y148.119 E.0635
G1 X196.177 Y146.673 E.0635
G1 X197.852 Y145.499 E.06349
G1 X199.706 Y144.635 E.0635
G1 X201.682 Y144.105 E.06349
G1 X203.72 Y143.927 E.06349
G1 X204.33 Y143.981 E.01901
G1 X205.757 Y144.105 E.04448
G1 X207.733 Y144.635 E.06349
G1 X209.587 Y145.499 E.0635
G1 X211.263 Y146.673 E.06349
G1 X212.709 Y148.119 E.0635
G1 X213.882 Y149.795 E.06349
G1 X214.747 Y151.648 E.0635
G1 X215.276 Y153.624 E.06349
G1 X215.449 Y155.602 E.06163
M204 S10000
G1 X214.649 Y155.68 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.451936
G1 F5262
M204 S8000
G1 X214.489 Y153.81 E.06318
G1 X213.967 Y151.868 E.06771
G1 X213.206 Y150.238 E.06055
G1 X212.12 Y148.673 E.06414
G1 X210.779 Y147.321 E.06413
G1 X209.223 Y146.222 E.06413
G1 X207.501 Y145.409 E.06413
G1 X205.663 Y144.909 E.06414
G1 X203.673 Y144.734 E.06725
G1 X201.868 Y144.892 E.06101
G1 X200.026 Y145.378 E.06414
G1 X198.296 Y146.175 E.06414
G1 X196.65 Y147.331 E.06772
G1 X195.378 Y148.602 E.06054
G1 X194.279 Y150.158 E.06413
G1 X193.467 Y151.881 E.06413
G1 X192.966 Y153.719 E.06413
G1 X192.792 Y155.616 E.06414
G1 X192.95 Y157.514 E.06413
G1 X193.435 Y159.356 E.06413
G1 X194.233 Y161.086 E.06414
G1 X195.388 Y162.732 E.06772
G1 X196.66 Y164.003 E.06054
G1 X198.216 Y165.102 E.06414
G1 X199.939 Y165.915 E.06413
G1 X201.776 Y166.416 E.06414
G1 X203.673 Y166.59 E.06413
G1 X205.571 Y166.432 E.06413
G1 X207.413 Y165.946 E.06413
G1 X209.143 Y165.149 E.06414
G1 X210.79 Y163.993 E.06772
G1 X212.061 Y162.722 E.06054
G1 X213.213 Y161.073 E.06772
G1 X214.008 Y159.342 E.06413
G1 X214.473 Y157.605 E.06055
G1 X214.644 Y155.74 E.06307
M204 S10000
G1 X200.118 Y145.777 F60000
; LINE_WIDTH: 0.451936
G1 F5262
M204 S8000
G3 X201.904 Y145.3 I73.449 J271.536 E.06222
G1 X203.709 Y145.142 E.06101
G1 X205.557 Y145.304 E.06247
G1 X207.328 Y145.78 E.06174
G1 X208.989 Y146.557 E.06174
G1 X210.49 Y147.61 E.06174
G1 X211.785 Y148.908 E.06174
G1 X212.835 Y150.412 E.06175
G1 X213.609 Y152.074 E.06175
G1 X214.075 Y153.811 E.06054
G1 X214.239 Y155.673 E.06293
G1 X214.078 Y157.499 E.06174
G1 X213.601 Y159.27 E.06174
G1 X212.825 Y160.931 E.06174
G1 X211.771 Y162.432 E.06174
G1 X210.473 Y163.728 E.06174
G1 X208.97 Y164.778 E.06175
G1 X207.307 Y165.551 E.06174
G1 X205.536 Y166.024 E.06174
G1 X203.709 Y166.182 E.06174
G1 X201.882 Y166.02 E.06174
G1 X200.111 Y165.544 E.06174
G1 X198.481 Y164.785 E.06055
G1 X196.949 Y163.714 E.06293
G1 X195.654 Y162.416 E.06174
G1 X194.604 Y160.913 E.06174
G1 X193.83 Y159.25 E.06175
G1 X193.358 Y157.478 E.06174
G1 X193.2 Y155.651 E.06174
G1 X193.361 Y153.825 E.06174
G1 X193.838 Y152.054 E.06174
G1 X194.615 Y150.393 E.06174
G1 X195.668 Y148.892 E.06174
G1 X196.966 Y147.597 E.06174
G1 X198.469 Y146.546 E.06175
G1 X200.064 Y145.802 E.05925
M204 S10000
G1 X194.452 Y151.7 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5262
M204 S8000
G2 X193.94 Y153.239 I4.11 J2.223 E.05466
G1 X194.36 Y153.485 E.01633
G2 X199.04 Y152.646 I1.627 J-4.394 E.1671
G3 X200.912 Y150.899 I33.77 J34.325 E.08579
G3 X206.527 Y151.191 I2.627 J3.627 E.20372
G2 X208.399 Y152.937 I33.77 J-34.325 E.08579
G2 X213.446 Y153.038 I2.593 J-3.428 E.18077
G1 X213.678 Y153.906 E.03011
G3 X212.115 Y161.235 I-9.796 J1.742 E.25748
G3 X208.399 Y160.133 I-.681 J-4.518 E.13412
G2 X206.527 Y158.387 I-33.763 J34.317 E.08579
G2 X200.912 Y158.679 I-2.627 J3.627 E.20372
G3 X199.04 Y160.425 I-33.777 J-34.332 E.08579
G3 X195.242 Y161.118 I-2.641 J-3.719 E.13357
G1 X195.973 Y162.162 E.0427
G2 X201.539 Y165.507 I7.615 J-6.369 E.22169
G1 X201.848 Y165.326 E.01198
G3 X205.663 Y165.57 I1.631 J4.44 E.13188
G1 X207.232 Y165.139 E.05454
; WIPE_START
G1 F18423.913
G1 X206.268 Y165.404 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z11.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z11.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 58/82
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X214.861 Y155.662 F60000
G1 Z11.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5153
M204 S8000
G1 X214.692 Y157.597 E.06508
G1 X214.189 Y159.473 E.06508
G1 X213.368 Y161.233 E.06508
G1 X212.254 Y162.824 E.06508
G1 X210.881 Y164.197 E.06508
G1 X209.29 Y165.311 E.06508
G1 X207.53 Y166.132 E.06508
G1 X206.796 Y166.328 E.02547
G1 X205.654 Y166.634 E.03961
G1 X203.72 Y166.803 E.06508
G1 X201.785 Y166.634 E.06508
G1 X199.909 Y166.132 E.06508
G1 X198.149 Y165.311 E.06508
G1 X196.558 Y164.197 E.06508
G1 X195.185 Y162.824 E.06508
G1 X194.071 Y161.233 E.06508
G1 X193.25 Y159.473 E.06508
G1 X193.053 Y158.738 E.02547
M73 P82 R2
G1 X192.747 Y157.597 E.03961
G1 X192.578 Y155.662 E.06508
G1 X192.747 Y153.727 E.06508
G1 X193.25 Y151.851 E.06508
G1 X194.071 Y150.091 E.06508
G1 X195.185 Y148.501 E.06508
G1 X196.558 Y147.127 E.06508
G1 X198.149 Y146.013 E.06508
G1 X199.909 Y145.193 E.06508
G1 X201.785 Y144.69 E.06508
G1 X203.72 Y144.521 E.06508
G1 X204.477 Y144.587 E.02547
G1 X205.654 Y144.69 E.03961
G1 X207.53 Y145.193 E.06508
G1 X209.29 Y146.013 E.06508
G1 X210.881 Y147.127 E.06508
G1 X212.254 Y148.501 E.06508
G1 X213.368 Y150.091 E.06508
G1 X214.189 Y151.852 E.06508
G1 X214.692 Y153.727 E.06508
G1 X214.856 Y155.602 E.06307
; COOLING_NODE: 0
M204 S10000
G1 X215.255 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5153
M204 S5000
G1 X215.079 Y157.665 E.06241
G1 X214.559 Y159.607 E.06241
G1 X213.709 Y161.43 E.06241
G1 X212.556 Y163.077 E.06241
G1 X211.134 Y164.498 E.06241
G1 X209.487 Y165.652 E.06241
G1 X207.665 Y166.501 E.06241
G1 X206.897 Y166.707 E.02466
G1 X205.723 Y167.022 E.03776
G1 X203.72 Y167.197 E.06241
G1 X201.717 Y167.022 E.06241
G1 X199.774 Y166.501 E.06241
G1 X197.952 Y165.652 E.06241
G1 X196.305 Y164.498 E.06241
G1 X194.883 Y163.077 E.06241
G1 X193.73 Y161.429 E.06241
G1 X192.88 Y159.607 E.06241
G1 X192.675 Y158.84 E.02466
G1 X192.36 Y157.665 E.03776
G1 X192.185 Y155.662 E.06241
G1 X192.36 Y153.659 E.06241
G1 X192.88 Y151.717 E.06241
G1 X193.216 Y150.997 E.02466
G1 X193.73 Y149.895 E.03776
G1 X194.883 Y148.248 E.06241
G1 X196.305 Y146.826 E.06241
G1 X197.952 Y145.672 E.06241
G1 X199.774 Y144.823 E.06241
G1 X201.717 Y144.302 E.06241
G1 X203.72 Y144.127 E.06241
G1 X204.511 Y144.196 E.02466
G1 X205.723 Y144.302 E.03776
G1 X207.665 Y144.823 E.06241
G1 X209.487 Y145.673 E.06241
G1 X211.134 Y146.826 E.06241
G1 X212.556 Y148.248 E.06241
G1 X213.709 Y149.895 E.06241
G1 X214.559 Y151.717 E.06241
G1 X215.079 Y153.659 E.06241
G1 X215.249 Y155.602 E.06055
M204 S10000
G1 X214.449 Y155.68 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.451936
G1 F5153
M204 S8000
G1 X214.292 Y153.845 E.06201
G1 X213.779 Y151.937 E.06654
G1 X213.033 Y150.338 E.05937
G1 X211.967 Y148.802 E.06297
G1 X210.651 Y147.474 E.06296
G1 X209.123 Y146.395 E.06296
G1 X207.432 Y145.597 E.06296
G1 X205.628 Y145.106 E.06296
G1 X203.673 Y144.934 E.06607
G1 X201.903 Y145.089 E.05983
G1 X200.094 Y145.566 E.06297
G1 X198.396 Y146.349 E.06297
G1 X196.778 Y147.484 E.06655
G1 X195.532 Y148.731 E.05937
G1 X194.452 Y150.258 E.06296
G1 X193.655 Y151.949 E.06296
G1 X193.163 Y153.754 E.06296
G1 X192.992 Y155.616 E.06296
G1 X193.147 Y157.479 E.06296
G1 X193.623 Y159.287 E.06296
G1 X194.406 Y160.986 E.06297
G1 X195.542 Y162.603 E.06655
G1 X196.789 Y163.85 E.05937
G1 X198.316 Y164.929 E.06296
G1 X200.007 Y165.727 E.06296
G1 X201.811 Y166.219 E.06296
G1 X203.673 Y166.39 E.06296
G1 X205.537 Y166.235 E.06296
G1 X207.345 Y165.759 E.06296
G1 X209.043 Y164.976 E.06297
G1 X210.661 Y163.84 E.06655
G1 X211.908 Y162.593 E.05937
G1 X213.039 Y160.973 E.06654
G1 X213.82 Y159.274 E.06295
G1 X214.276 Y157.57 E.05937
G1 X214.444 Y155.74 E.0619
M204 S10000
G1 X200.213 Y165.368 F60000
; LINE_WIDTH: 0.451936
G1 F5153
M204 S8000
G1 X198.55 Y164.594 E.06176
G1 X197.078 Y163.56 E.06057
G1 X195.807 Y162.287 E.06056
G1 X194.777 Y160.813 E.06057
G1 X194.018 Y159.181 E.06057
G1 X193.555 Y157.443 E.06056
G1 X193.4 Y155.687 E.05937
G1 X193.558 Y153.859 E.06176
G1 X194.026 Y152.122 E.06057
G1 X194.788 Y150.493 E.06057
G1 X195.821 Y149.02 E.06057
G1 X197.094 Y147.75 E.06056
G1 X198.569 Y146.719 E.06057
G1 X200.167 Y145.973 E.05938
G1 X201.938 Y145.497 E.06176
G1 X203.709 Y145.342 E.05983
G1 X205.522 Y145.501 E.06129
G1 X207.259 Y145.968 E.06057
G1 X208.889 Y146.73 E.06057
G1 X210.361 Y147.764 E.06057
G1 X211.632 Y149.037 E.06056
G1 X212.662 Y150.512 E.06057
G1 X213.408 Y152.11 E.05938
G1 X213.884 Y153.881 E.06175
G1 X214.039 Y155.673 E.06056
G1 X213.881 Y157.465 E.06057
G1 X213.413 Y159.202 E.06057
G1 X212.651 Y160.831 E.06057
G1 X211.618 Y162.304 E.06057
G1 X210.345 Y163.574 E.06056
G1 X208.87 Y164.605 E.06057
G1 X207.239 Y165.363 E.06057
G1 X205.501 Y165.827 E.06056
G1 X203.709 Y165.982 E.06056
G1 X201.917 Y165.823 E.06057
G1 X200.271 Y165.383 E.05735
M204 S10000
G1 X206.769 Y165.068 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5153
M204 S8000
G3 X205.189 Y165.446 I-2.46 J-6.792 E.05457
G2 X201.848 Y165.199 I-1.965 J3.871 E.11526
G1 X201.616 Y165.321 E.00878
G3 X196.126 Y162.034 I1.984 J-9.539 E.21847
G1 X195.498 Y161.137 E.03669
G2 X199.04 Y160.608 I1.22 J-3.951 E.12409
G1 X199.976 Y159.779 E.04189
G3 X201.848 Y158.139 I6.891 J5.979 E.08365
G3 X206.527 Y158.204 I2.287 J3.829 E.1651
G3 X208.399 Y159.965 I-13.98 J16.733 E.08618
G2 X211.827 Y161.298 I3.287 J-3.379 E.12662
G2 X213.481 Y153.941 I-7.946 J-5.651 E.25948
G1 X213.245 Y153.059 E.03057
G3 X208.399 Y153.12 I-2.468 J-3.59 E.17221
G1 X207.463 Y152.291 E.04189
G2 X205.591 Y150.652 I-6.891 J5.979 E.08365
G2 X200.912 Y150.716 I-2.287 J3.829 E.1651
G2 X199.04 Y152.478 I13.977 J16.73 E.08618
G3 X194.36 Y153.613 I-3.325 J-3.493 E.16895
G1 X194.085 Y153.468 E.01043
G1 X194.405 Y152.272 E.04148
G1 X194.57 Y151.918 E.01308
; WIPE_START
G1 F18423.913
G1 X194.405 Y152.272 E-.14833
G1 X194.247 Y152.861 E-.23167
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z12 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z12 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 11.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 59/82
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X214.661 Y155.662 F60000
G1 Z11.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5062
M204 S8000
G1 X214.495 Y157.562 E.06391
G1 X214.001 Y159.404 E.06391
G1 X213.195 Y161.133 E.06391
G1 X212.101 Y162.695 E.06391
G1 X210.753 Y164.044 E.06391
G1 X209.19 Y165.138 E.06391
G1 X207.462 Y165.944 E.06391
G1 X205.62 Y166.437 E.06391
G1 X203.72 Y166.603 E.06391
G1 X201.82 Y166.437 E.06391
G1 X199.977 Y165.944 E.06391
G1 X198.249 Y165.138 E.06391
G1 X196.687 Y164.044 E.06391
G1 X195.338 Y162.695 E.06391
G1 X194.244 Y161.133 E.06391
G1 X193.438 Y159.404 E.06391
G1 X192.944 Y157.562 E.06391
G1 X192.778 Y155.662 E.06391
G1 X192.944 Y153.762 E.06391
G1 X193.438 Y151.92 E.06391
G1 X193.836 Y151.066 E.03156
G1 X194.244 Y150.191 E.03235
G1 X195.338 Y148.629 E.06391
G1 X196.687 Y147.28 E.06391
G1 X198.249 Y146.187 E.06391
G1 X199.977 Y145.381 E.06391
G1 X201.82 Y144.887 E.06391
G1 X203.72 Y144.721 E.06391
G1 X204.658 Y144.803 E.03156
G1 X205.62 Y144.887 E.03235
G1 X207.462 Y145.381 E.06391
G1 X209.19 Y146.187 E.06391
G1 X210.753 Y147.28 E.06391
G1 X212.101 Y148.629 E.06391
G1 X213.195 Y150.191 E.06391
G1 X214.001 Y151.92 E.06391
G1 X214.495 Y153.762 E.06391
G1 X214.656 Y155.602 E.0619
; COOLING_NODE: 0
M204 S10000
G1 X215.055 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5062
M204 S5000
G1 X214.882 Y157.63 E.06133
G1 X214.371 Y159.539 E.06133
G1 X213.536 Y161.33 E.06133
G1 X212.403 Y162.948 E.06133
G1 X211.006 Y164.345 E.06133
G1 X209.387 Y165.478 E.06133
G1 X207.596 Y166.313 E.06133
G1 X205.688 Y166.825 E.06133
G1 X203.72 Y166.997 E.06133
G1 X201.751 Y166.825 E.06133
G1 X199.843 Y166.313 E.06133
G1 X198.052 Y165.478 E.06133
G1 X196.434 Y164.345 E.06133
G1 X195.037 Y162.948 E.06133
G1 X193.903 Y161.329 E.06133
G1 X193.068 Y159.539 E.06133
G1 X192.557 Y157.63 E.06133
G1 X192.385 Y155.662 E.06133
G1 X192.557 Y153.694 E.06133
G1 X193.068 Y151.785 E.06133
G1 X193.903 Y149.995 E.06133
G1 X195.036 Y148.376 E.06133
G1 X196.434 Y146.979 E.06133
G1 X198.052 Y145.846 E.06133
G1 X199.843 Y145.011 E.06133
G1 X201.751 Y144.499 E.06133
G1 X203.72 Y144.327 E.06133
G1 X204.692 Y144.412 E.0303
G1 X205.688 Y144.499 E.03103
G1 X207.596 Y145.011 E.06133
G1 X209.387 Y145.846 E.06133
G1 X211.006 Y146.979 E.06133
G1 X212.403 Y148.376 E.06133
G1 X213.536 Y149.995 E.06133
G1 X214.371 Y151.785 E.06133
G1 X214.882 Y153.694 E.06133
G1 X215.049 Y155.602 E.05947
M204 S10000
G1 X214.249 Y155.68 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.451935
G1 F5062
M204 S8000
G1 X214.095 Y153.88 E.06084
G1 X213.591 Y152.005 E.06537
G1 X212.86 Y150.438 E.0582
G1 X211.814 Y148.93 E.06179
G1 X210.522 Y147.627 E.06178
G1 X209.023 Y146.568 E.06179
G1 X207.364 Y145.785 E.06179
G1 X205.593 Y145.302 E.06179
G1 X203.673 Y145.134 E.0649
G1 X201.937 Y145.286 E.05866
G1 X200.163 Y145.753 E.06179
G1 X198.496 Y146.522 E.06179
G1 X196.907 Y147.637 E.06538
G1 X195.685 Y148.86 E.05819
G1 X194.626 Y150.358 E.06179
G1 X193.843 Y152.018 E.06179
G1 X193.36 Y153.788 E.06179
G1 X193.192 Y155.616 E.06179
G1 X193.344 Y157.444 E.06178
G1 X193.811 Y159.219 E.06178
G1 X194.579 Y160.886 E.06179
G1 X195.695 Y162.475 E.06537
G1 X196.917 Y163.697 E.0582
G1 X198.416 Y164.756 E.06179
G1 X200.075 Y165.539 E.06179
G1 X201.846 Y166.022 E.06179
G1 X203.673 Y166.19 E.06179
G1 X205.502 Y166.038 E.06178
G1 X207.277 Y165.571 E.06178
G1 X208.943 Y164.802 E.06179
G1 X210.532 Y163.687 E.06538
G1 X211.754 Y162.465 E.05819
G1 X212.866 Y160.873 E.06537
G1 X213.632 Y159.205 E.06178
G1 X214.079 Y157.536 E.0582
G1 X214.244 Y155.74 E.06073
M204 S10000
G1 X200.282 Y165.18 F60000
; LINE_WIDTH: 0.451935
G1 F5062
M204 S8000
G1 X198.65 Y164.421 E.06059
G1 X197.206 Y163.407 E.05939
G1 X195.96 Y162.159 E.05939
G1 X194.95 Y160.713 E.05939
G1 X194.206 Y159.113 E.0594
G1 X193.752 Y157.409 E.05939
G1 X193.6 Y155.687 E.0582
G1 X193.755 Y153.894 E.06058
G1 X194.214 Y152.191 E.05939
G1 X194.961 Y150.593 E.05939
G1 X195.974 Y149.149 E.05939
G1 X197.223 Y147.903 E.05939
G1 X198.669 Y146.893 E.0594
G1 X200.235 Y146.161 E.0582
G1 X201.973 Y145.694 E.06058
G1 X203.709 Y145.542 E.05866
G1 X205.487 Y145.698 E.06012
G1 X207.191 Y146.156 E.05939
G1 X208.789 Y146.903 E.05939
G1 X210.233 Y147.917 E.05939
G1 X211.479 Y149.165 E.05939
G1 X212.489 Y150.612 E.0594
G1 X213.22 Y152.178 E.05821
G1 X213.687 Y153.915 E.06058
G1 X213.839 Y155.673 E.05939
G1 X213.684 Y157.43 E.05939
G1 X213.225 Y159.133 E.05939
G1 X212.478 Y160.731 E.05939
G1 X211.465 Y162.175 E.05939
G1 X210.216 Y163.421 E.05939
G1 X208.77 Y164.431 E.0594
G1 X207.17 Y165.175 E.0594
G1 X205.466 Y165.63 E.05939
G1 X203.709 Y165.782 E.05939
G1 X201.952 Y165.626 E.05939
G1 X200.34 Y165.195 E.05618
M204 S10000
G1 X206.331 Y164.979 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5062
M204 S8000
G3 X204.738 Y165.285 I-1.665 J-4.364 E.05464
G2 X201.848 Y165.062 I-1.768 J4.057 E.09897
G1 X201.667 Y165.129 E.00646
G3 X196.28 Y161.905 I1.938 J-9.351 E.21436
G1 X195.778 Y161.188 E.02933
G2 X199.04 Y160.802 I1.188 J-3.941 E.11323
G2 X200.912 Y159.014 I-7.674 J-9.906 E.08691
M73 P83 R2
G3 X202.784 Y157.755 I3.831 J3.676 E.07617
G3 X206.527 Y158.01 I1.61 J3.973 E.13015
G3 X208.399 Y159.798 I-7.674 J9.906 E.08691
G2 X211.557 Y161.337 I3.622 J-3.424 E.1203
G2 X213.284 Y153.975 I-8.049 J-5.771 E.25998
G1 X213.05 Y153.1 E.03036
G1 X212.143 Y153.569 E.0342
G3 X208.399 Y153.314 I-1.61 J-3.973 E.13015
G3 X206.527 Y151.526 I7.673 J-9.905 E.08691
G2 X204.656 Y150.267 I-3.831 J3.676 E.07617
G2 X200.912 Y150.522 I-1.61 J3.973 E.13015
G2 X199.04 Y152.31 I7.674 J9.906 E.08691
G3 X194.36 Y153.75 I-3.62 J-3.443 E.17147
G1 X194.228 Y153.701 E.0047
G1 X194.686 Y152.142 E.05447
; WIPE_START
G1 F18423.913
G1 X194.404 Y153.101 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z12.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z12.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 12
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 60/82
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X214.461 Y155.662 F60000
G1 Z12
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5842
M204 S8000
G1 X214.298 Y157.527 E.06274
G1 X213.813 Y159.336 E.06274
G1 X213.022 Y161.033 E.06274
G1 X211.948 Y162.566 E.06274
G1 X210.624 Y163.89 E.06274
G1 X209.704 Y164.535 E.03765
G1 X209.09 Y164.964 E.02509
G1 X207.393 Y165.756 E.06274
G1 X205.585 Y166.24 E.06274
G1 X203.72 Y166.403 E.06274
G1 X201.854 Y166.24 E.06274
G1 X200.046 Y165.756 E.06274
G1 X198.349 Y164.964 E.06274
G1 X196.815 Y163.89 E.06274
G1 X195.491 Y162.566 E.06274
G1 X194.847 Y161.646 E.03765
G1 X194.417 Y161.033 E.02509
G1 X193.626 Y159.336 E.06274
G1 X193.141 Y157.527 E.06274
G1 X192.978 Y155.662 E.06274
G1 X193.141 Y153.797 E.06274
G1 X193.626 Y151.988 E.06274
G1 X194.417 Y150.291 E.06274
G1 X195.491 Y148.758 E.06274
G1 X196.815 Y147.434 E.06274
G1 X198.349 Y146.36 E.06274
G1 X200.046 Y145.568 E.06274
G1 X201.854 Y145.084 E.06274
G1 X203.72 Y144.921 E.06274
G1 X204.839 Y145.019 E.03765
G1 X205.585 Y145.084 E.02509
G1 X207.393 Y145.568 E.06274
G1 X209.09 Y146.36 E.06274
G1 X210.624 Y147.434 E.06274
G1 X211.948 Y148.758 E.06274
G1 X213.022 Y150.291 E.06274
G1 X213.813 Y151.988 E.06274
G1 X214.104 Y153.074 E.03765
G1 X214.298 Y153.797 E.02509
G1 X214.456 Y155.602 E.06073
; COOLING_NODE: 0
M204 S10000
G1 X214.855 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5166
M204 S5000
G1 X214.685 Y157.596 E.06025
G1 X214.183 Y159.47 E.06025
G1 X213.363 Y161.229 E.06025
G1 X212.249 Y162.819 E.06025
G1 X210.877 Y164.192 E.06025
G1 X209.928 Y164.856 E.03594
G1 X209.287 Y165.305 E.02431
G1 X207.528 Y166.125 E.06025
G1 X205.653 Y166.628 E.06025
G1 X203.72 Y166.797 E.06025
G1 X201.786 Y166.628 E.06025
G1 X199.911 Y166.125 E.06025
G1 X198.152 Y165.305 E.06025
G1 X196.562 Y164.192 E.06025
G1 X195.19 Y162.819 E.06025
G1 X194.526 Y161.871 E.03594
G1 X194.076 Y161.229 E.02431
G1 X193.256 Y159.47 E.06025
G1 X192.754 Y157.596 E.06025
G1 X192.585 Y155.662 E.06025
G1 X192.754 Y153.728 E.06025
G1 X193.256 Y151.854 E.06025
G1 X194.076 Y150.095 E.06025
G1 X195.19 Y148.505 E.06025
G1 X196.562 Y147.132 E.06025
G1 X198.152 Y146.019 E.06025
G1 X199.911 Y145.199 E.06025
G1 X201.786 Y144.696 E.06025
G1 X203.72 Y144.527 E.06025
G1 X204.873 Y144.628 E.03594
G1 X205.653 Y144.696 E.02431
G1 X207.528 Y145.199 E.06025
G1 X209.287 Y146.019 E.06025
G1 X210.877 Y147.132 E.06025
G1 X212.249 Y148.505 E.06025
G1 X213.363 Y150.095 E.06025
G1 X214.183 Y151.854 E.06025
G1 X214.483 Y152.972 E.03594
G1 X214.685 Y153.728 E.02431
G1 X214.849 Y155.602 E.05839
M204 S10000
G1 X214.043 Y155.68 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.46479
G1 F5842
M204 S8000
G1 X213.892 Y153.917 E.06146
G1 X213.396 Y152.074 E.06629
G1 X212.682 Y150.543 E.05866
G1 X211.657 Y149.065 E.06248
G1 X210.39 Y147.787 E.06248
G1 X208.922 Y146.748 E.06247
G1 X207.295 Y145.98 E.06248
G1 X205.559 Y145.506 E.06248
G1 X203.671 Y145.341 E.06581
G1 X201.975 Y145.49 E.05914
G1 X200.235 Y145.947 E.06248
G1 X198.601 Y146.7 E.06248
G1 X197.038 Y147.797 E.0663
G1 X195.844 Y148.991 E.05866
G1 X194.805 Y150.46 E.06247
G1 X194.037 Y152.087 E.06248
G1 X193.564 Y153.823 E.06248
G1 X193.399 Y155.614 E.06248
G1 X193.547 Y157.407 E.06248
G1 X194.005 Y159.147 E.06247
G1 X194.757 Y160.781 E.06248
G1 X195.854 Y162.343 E.06629
G1 X197.049 Y163.538 E.05866
G1 X198.518 Y164.576 E.06248
G1 X200.144 Y165.344 E.06248
G1 X201.88 Y165.818 E.06248
G1 X203.672 Y165.983 E.06248
G1 X205.465 Y165.835 E.06248
G1 X207.204 Y165.377 E.06247
G1 X208.838 Y164.624 E.06248
G1 X210.401 Y163.527 E.0663
G1 X211.595 Y162.333 E.05866
G1 X212.688 Y160.768 E.06629
G1 X213.439 Y159.133 E.06247
G1 X213.875 Y157.501 E.05866
G1 X214.038 Y155.74 E.06142
M204 S10000
G1 X213.465 Y153.918 F60000
; Slow Down Start
; LINE_WIDTH: 0.465054
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X213.62 Y155.673 E.06123
G1 X213.468 Y157.392 E.05997
G1 X213.019 Y159.059 E.05997
G1 X212.306 Y160.59 E.0587
G1 X211.296 Y162.034 E.06123
G1 X210.075 Y163.253 E.05997
G1 X208.66 Y164.242 E.05998
G1 X207.129 Y164.956 E.0587
G1 X205.428 Y165.414 E.06123
G1 X203.708 Y165.562 E.05997
G1 X201.989 Y165.41 E.05997
G1 X200.323 Y164.961 E.05997
G1 X198.791 Y164.248 E.0587
G1 X197.347 Y163.239 E.06123
G1 X196.128 Y162.017 E.05997
G1 X195.14 Y160.602 E.05997
G1 X194.412 Y159.037 E.05997
G1 X193.974 Y157.406 E.0587
G1 X193.819 Y155.651 E.06123
G1 X193.972 Y153.932 E.05997
G3 X194.414 Y152.279 I31.393 J7.519 E.05947
G3 X195.151 Y150.702 I220.003 J101.892 E.06049
G1 X196.143 Y149.29 E.05997
G1 X197.364 Y148.071 E.05997
G1 X198.779 Y147.082 E.05997
G1 X200.31 Y146.368 E.05871
G1 X202.012 Y145.91 E.06123
G1 X203.708 Y145.762 E.05917
G1 X205.45 Y145.914 E.06076
G1 X207.116 Y146.363 E.05997
G1 X208.648 Y147.076 E.0587
G1 X210.092 Y148.085 E.06123
G1 X211.311 Y149.307 E.05997
G1 X212.299 Y150.722 E.05997
G1 X213.027 Y152.287 E.05997
G1 X213.449 Y153.86 E.05661
; Slow Down End
M204 S10000
G1 X205.779 Y164.894 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5842
M204 S8000
G3 X204.17 Y165.109 I-1.415 J-4.456 E.05468
G2 X201.848 Y164.912 I-1.565 J4.667 E.07884
G3 X196.453 Y161.76 I1.667 J-9.045 E.21364
G1 X196.137 Y161.309 E.01844
G2 X199.04 Y161.012 I1.062 J-3.95 E.09999
G2 X200.912 Y159.184 I-5.499 J-7.503 E.08797
G3 X203.72 Y157.471 I4.39 J4.039 E.11166
G3 X206.527 Y157.8 I.979 J3.789 E.09693
G3 X208.399 Y159.628 I-5.498 J7.503 E.08797
G2 X211.207 Y161.341 I4.39 J-4.039 E.11166
G1 X211.274 Y161.35 E.00225
G2 X213.062 Y154.015 I-7.785 J-5.783 E.25986
G1 X212.827 Y153.139 E.03039
G3 X211.207 Y153.853 I-2.502 J-3.479 E.05976
G3 X208.399 Y153.524 I-.979 J-3.789 E.09693
G3 X206.527 Y151.696 I5.498 J-7.502 E.08797
G2 X203.72 Y149.983 I-4.39 J4.039 E.11166
G2 X200.912 Y150.312 I-.979 J3.789 E.09693
G2 X199.04 Y152.14 I5.499 J7.503 E.08797
G3 X194.407 Y153.903 I-3.941 J-3.388 E.17315
G1 X194.843 Y152.336 E.05452
; WIPE_START
G1 F18423.913
G1 X194.575 Y153.299 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z12.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z12.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 12.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 61/82
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X214.261 Y155.662 F60000
G1 Z12.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5630
M204 S8000
G1 X214.101 Y157.493 E.06157
G1 X213.625 Y159.267 E.06157
G1 X212.849 Y160.933 E.06158
G1 X211.795 Y162.438 E.06158
G1 X210.495 Y163.737 E.06157
G1 X208.99 Y164.791 E.06158
G1 X207.325 Y165.568 E.06158
G1 X205.55 Y166.043 E.06157
G1 X203.72 Y166.203 E.06157
G1 X201.889 Y166.043 E.06157
G1 X200.114 Y165.568 E.06157
G1 X198.449 Y164.791 E.06158
G1 X196.944 Y163.737 E.06158
G1 X195.644 Y162.438 E.06157
G1 X194.59 Y160.933 E.06158
G1 X193.814 Y159.267 E.06158
G1 X193.338 Y157.493 E.06157
G1 X193.178 Y155.662 E.06157
G1 X193.338 Y153.832 E.06157
G1 X193.814 Y152.057 E.06157
G1 X194.59 Y150.391 E.06158
G1 X195.644 Y148.886 E.06157
G1 X196.944 Y147.587 E.06157
G1 X198.449 Y146.533 E.06158
G1 X200.114 Y145.756 E.06158
G1 X201.889 Y145.281 E.06157
G1 X203.72 Y145.121 E.06157
G1 X205.02 Y145.234 E.04375
G1 X205.55 Y145.281 E.01783
G1 X207.325 Y145.756 E.06157
G1 X208.99 Y146.533 E.06158
G1 X210.495 Y147.587 E.06157
G1 X211.795 Y148.886 E.06157
G1 X212.849 Y150.391 E.06157
G1 X213.625 Y152.057 E.06158
G1 X214.101 Y153.832 E.06157
G1 X214.256 Y155.602 E.05956
; COOLING_NODE: 0
M204 S10000
G1 X214.655 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5170
M204 S5000
G1 X214.488 Y157.561 E.05917
G1 X213.995 Y159.402 E.05917
G1 X213.19 Y161.129 E.05917
G1 X212.096 Y162.691 E.05917
G1 X210.748 Y164.039 E.05916
G1 X209.187 Y165.132 E.05917
G1 X207.46 Y165.938 E.05917
G1 X205.618 Y166.431 E.05917
G1 X203.72 Y166.597 E.05917
G1 X201.821 Y166.431 E.05917
G1 X199.98 Y165.938 E.05917
G1 X198.252 Y165.132 E.05917
G1 X196.691 Y164.039 E.05917
G1 X195.343 Y162.691 E.05916
G1 X194.25 Y161.129 E.05917
G1 X193.444 Y159.402 E.05917
G1 X192.951 Y157.561 E.05917
G1 X192.785 Y155.662 E.05917
G1 X192.951 Y153.763 E.05917
G1 X193.444 Y151.922 E.05917
G1 X194.25 Y150.195 E.05917
G1 X195.343 Y148.633 E.05917
G1 X196.691 Y147.285 E.05916
G1 X198.252 Y146.192 E.05917
G1 X199.98 Y145.387 E.05917
G1 X201.821 Y144.893 E.05917
G1 X203.72 Y144.727 E.05917
G1 X205.054 Y144.844 E.04159
G1 X205.618 Y144.893 E.01758
G1 X207.46 Y145.387 E.05917
G1 X209.187 Y146.192 E.05917
G1 X210.748 Y147.285 E.05917
G1 X212.096 Y148.633 E.05916
G1 X213.19 Y150.195 E.05917
G1 X213.995 Y151.922 E.05917
G1 X214.488 Y153.763 E.05917
G1 X214.649 Y155.602 E.0573
M204 S10000
G1 X213.821 Y155.682 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.507441
G1 F5630
M204 S8000
G1 X213.674 Y153.961 E.06605
G1 X213.186 Y152.145 E.07193
G1 X212.492 Y150.659 E.06269
G1 X211.49 Y149.211 E.06732
G1 X210.252 Y147.96 E.06731
G1 X208.815 Y146.943 E.06732
G1 X207.224 Y146.19 E.06731
G1 X205.526 Y145.726 E.06732
G1 X203.666 Y145.563 E.0714
G1 X202.019 Y145.707 E.06321
G1 X200.316 Y146.154 E.06732
G1 X198.716 Y146.889 E.06732
G1 X197.176 Y147.97 E.07194
G1 X196.018 Y149.129 E.06268
G1 X195 Y150.566 E.06732
G1 X194.248 Y152.158 E.06731
G1 X193.783 Y153.856 E.06732
G1 X193.62 Y155.609 E.06732
G1 X193.765 Y157.363 E.06731
G1 X194.211 Y159.066 E.06731
G1 X194.947 Y160.665 E.06732
G1 X196.028 Y162.205 E.07194
G1 X197.187 Y163.364 E.06268
G1 X198.624 Y164.381 E.06732
G1 X200.215 Y165.134 E.06731
G1 X201.913 Y165.598 E.06732
G1 X203.666 Y165.761 E.06732
G1 X205.42 Y165.617 E.06731
G1 X207.123 Y165.17 E.06731
G1 X208.723 Y164.435 E.06732
G1 X210.263 Y163.354 E.07195
G1 X211.421 Y162.195 E.06268
G1 X212.499 Y160.652 E.07194
G1 X213.232 Y159.052 E.06731
G1 X213.656 Y157.468 E.06269
G1 X213.816 Y155.742 E.0663
M204 S10000
G1 X213.204 Y153.962 F60000
; Slow Down Start
; LINE_WIDTH: 0.507704
M73 P84 R2
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X213.356 Y155.675 E.06579
G1 X213.207 Y157.348 E.06427
G1 X212.77 Y158.97 E.06427
G1 X212.078 Y160.456 E.06272
G1 X211.093 Y161.866 E.0658
G1 X209.903 Y163.052 E.06426
G1 X208.526 Y164.014 E.06427
G1 X207.041 Y164.707 E.06273
G1 X205.38 Y165.154 E.0658
G1 X203.706 Y165.298 E.06426
G1 X202.033 Y165.149 E.06427
G1 X200.411 Y164.712 E.06427
G1 X198.925 Y164.02 E.06272
G1 X197.515 Y163.035 E.06581
G1 X196.33 Y161.846 E.06426
G1 X195.368 Y160.469 E.06427
G1 X194.66 Y158.945 E.06427
G1 X194.235 Y157.362 E.06272
G1 X194.084 Y155.649 E.0658
G1 X194.232 Y153.976 E.06427
G3 X194.662 Y152.369 I31.243 J7.504 E.06364
G3 X195.381 Y150.833 I187.998 J86.996 E.0649
G1 X196.346 Y149.458 E.06427
G1 X197.536 Y148.272 E.06426
G1 X198.913 Y147.31 E.06427
G1 X200.399 Y146.617 E.06273
G1 X202.059 Y146.17 E.0658
G1 X203.706 Y146.026 E.06325
G1 X205.406 Y146.175 E.06527
G1 X207.028 Y146.612 E.06427
G1 X208.514 Y147.304 E.06272
G1 X209.924 Y148.289 E.0658
G1 X211.11 Y149.478 E.06426
G1 X212.071 Y150.855 E.06427
G1 X212.779 Y152.379 E.06427
G1 X213.189 Y153.904 E.06043
; Slow Down End
M204 S10000
G1 X204.809 Y164.767 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5630
M204 S8000
G1 X203.72 Y164.863 E.03666
G2 X202.349 Y164.743 I-1.628 J10.708 E.04614
G3 X197.805 Y162.71 I1.275 J-8.944 E.16898
G1 X196.581 Y161.447 E.05894
G2 X199.04 Y161.242 I.959 J-3.345 E.08452
G2 X200.912 Y159.361 I-4.073 J-5.924 E.08946
G3 X203.72 Y157.433 I4.822 J4.014 E.11559
G3 X206.527 Y157.569 I1.224 J3.771 E.0963
G3 X208.399 Y159.451 I-4.073 J5.924 E.08946
G2 X210.971 Y161.285 I4.725 J-3.905 E.10707
G2 X212.781 Y154.064 I-7.506 J-5.718 E.25643
G1 X212.561 Y153.244 E.02846
G3 X211.207 Y153.891 I-2.228 J-2.918 E.05064
G3 X208.399 Y153.755 I-1.224 J-3.772 E.0963
G3 X206.527 Y151.873 I4.073 J-5.923 E.08946
G2 X202.784 Y149.762 I-4.434 J3.488 E.14776
G2 X200.444 Y150.405 I-.429 J3.018 E.08363
G3 X198.104 Y152.901 I-214.398 J-198.61 E.11466
G3 X194.658 Y154.066 I-3.227 J-3.868 E.12469
G1 X195.083 Y152.495 E.05455
; WIPE_START
G1 F18423.913
G1 X194.822 Y153.46 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z12.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z12.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 12.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 62/82
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X214.061 Y155.662 F60000
G1 Z12.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5266
M204 S8000
G1 X213.904 Y157.458 E.06041
G1 X213.437 Y159.199 E.06041
G1 X212.675 Y160.833 E.06041
G1 X211.641 Y162.309 E.06041
G1 X210.367 Y163.584 E.06041
G1 X208.89 Y164.618 E.06041
G1 X207.256 Y165.38 E.06041
G1 X205.82 Y165.765 E.04984
G1 X205.515 Y165.846 E.01057
G1 X203.72 Y166.003 E.06041
G1 X201.924 Y165.846 E.06041
G1 X200.183 Y165.38 E.06041
G1 X198.549 Y164.618 E.06041
G1 X197.072 Y163.584 E.06041
G1 X195.798 Y162.309 E.06041
G1 X194.764 Y160.833 E.06041
G1 X194.002 Y159.199 E.06041
G1 X193.617 Y157.762 E.04984
G1 X193.535 Y157.458 E.01057
G1 X193.378 Y155.662 E.06041
G1 X193.535 Y153.866 E.06041
G1 X194.002 Y152.125 E.06041
G1 X194.764 Y150.491 E.06041
G1 X195.798 Y149.015 E.06041
G1 X197.072 Y147.74 E.06041
G1 X198.549 Y146.706 E.06041
G1 X200.183 Y145.944 E.06041
G1 X201.924 Y145.478 E.06041
G1 X203.72 Y145.321 E.06041
G1 X205.201 Y145.45 E.04984
G1 X205.515 Y145.478 E.01057
G1 X207.256 Y145.944 E.06041
G1 X208.89 Y146.706 E.06041
G1 X210.367 Y147.74 E.06041
G1 X211.641 Y149.015 E.06041
G1 X212.675 Y150.491 E.06041
G1 X213.437 Y152.125 E.06041
G1 X213.822 Y153.562 E.04984
G1 X213.904 Y153.866 E.01057
G1 X214.056 Y155.602 E.0584
; COOLING_NODE: 0
M204 S10000
G1 X214.455 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5169
M204 S5000
G1 X214.291 Y157.526 E.05808
G1 X213.807 Y159.334 E.05808
G1 X213.016 Y161.029 E.05808
G1 X211.943 Y162.562 E.05809
G1 X210.62 Y163.885 E.05808
G1 X209.087 Y164.959 E.05809
G1 X207.391 Y165.75 E.05808
G1 X205.584 Y166.234 E.05808
G1 X203.72 Y166.397 E.05808
G1 X201.855 Y166.234 E.05808
G1 X200.048 Y165.75 E.05808
G1 X198.352 Y164.959 E.05808
G1 X196.819 Y163.885 E.05809
G1 X195.496 Y162.562 E.05808
G1 X194.423 Y161.029 E.05809
G1 X193.632 Y159.334 E.05808
G1 X193.148 Y157.526 E.05808
G1 X192.985 Y155.662 E.05808
G1 X193.148 Y153.798 E.05808
G1 X193.632 Y151.991 E.05808
G1 X194.423 Y150.295 E.05808
G1 X195.496 Y148.762 E.05809
G1 X196.819 Y147.439 E.05808
G1 X198.352 Y146.365 E.05809
G1 X200.048 Y145.575 E.05808
G1 X201.855 Y145.09 E.05808
G1 X203.72 Y144.927 E.05808
G1 X205.235 Y145.06 E.04723
G1 X205.584 Y145.09 E.01085
G1 X207.391 Y145.575 E.05808
G1 X209.087 Y146.365 E.05808
G1 X210.62 Y147.439 E.05809
G1 X211.943 Y148.762 E.05808
G1 X213.016 Y150.295 E.05809
G1 X213.807 Y151.991 E.05808
G1 X214.201 Y153.46 E.04723
G1 X214.291 Y153.798 E.01085
G1 X214.449 Y155.602 E.05622
M204 S10000
G1 X213.6 Y155.684 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.550093
G1 F5266
M204 S8000
G1 X213.457 Y154.005 E.07035
G1 X213.021 Y152.34 E.07187
G1 X212.975 Y152.215 E.00554
G1 X212.303 Y150.775 E.06637
G1 X211.324 Y149.358 E.07189
G1 X210.114 Y148.134 E.07188
G1 X208.709 Y147.138 E.07188
G1 X207.153 Y146.401 E.07188
G1 X205.493 Y145.945 E.07188
G1 X203.66 Y145.785 E.0768
G1 X202.063 Y145.925 E.06694
G1 X200.397 Y146.36 E.07189
G1 X198.832 Y147.079 E.07189
G1 X197.416 Y148.058 E.07189
G1 X197.315 Y148.144 E.00554
G1 X196.191 Y149.268 E.06636
G1 X195.195 Y150.672 E.07188
G1 X194.458 Y152.228 E.07188
G1 X194.003 Y153.889 E.07188
G1 X193.842 Y155.603 E.07189
G1 X193.982 Y157.319 E.07188
G1 X194.418 Y158.985 E.07188
G1 X195.136 Y160.55 E.07189
G1 X196.115 Y161.966 E.07188
G1 X196.201 Y162.067 E.00554
G1 X197.325 Y163.19 E.06636
G1 X198.73 Y164.186 E.07188
G1 X200.286 Y164.923 E.07188
G1 X201.946 Y165.379 E.07188
G1 X203.661 Y165.539 E.07188
G1 X205.377 Y165.399 E.07188
G1 X207.042 Y164.964 E.07188
G1 X208.607 Y164.245 E.07189
G1 X210.023 Y163.266 E.07189
G1 X210.124 Y163.18 E.00554
G1 X211.332 Y161.954 E.07187
G1 X212.309 Y160.536 E.07187
G1 X213.025 Y158.971 E.07188
G1 X213.436 Y157.435 E.06636
G1 X213.595 Y155.744 E.07092
M204 S10000
G1 X212.943 Y154.006 F60000
; Slow Down Start
; LINE_WIDTH: 0.550355
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X213.091 Y155.677 E.07006
G1 X212.946 Y157.304 E.06824
G1 X212.521 Y158.881 E.06824
G1 X211.85 Y160.323 E.06641
G1 X210.889 Y161.697 E.07007
G1 X209.732 Y162.851 E.06823
G1 X208.392 Y163.786 E.06824
G1 X206.952 Y164.458 E.06641
G1 X205.332 Y164.894 E.07006
G1 X203.705 Y165.034 E.06823
G1 X202.077 Y164.889 E.06824
G1 X200.5 Y164.463 E.06824
G1 X199.059 Y163.792 E.06641
G1 X197.684 Y162.831 E.07007
G1 X196.531 Y161.675 E.06824
G1 X195.596 Y160.335 E.06824
G1 X194.908 Y158.853 E.06825
G1 X194.496 Y157.318 E.0664
G1 X194.348 Y155.647 E.07006
G1 X194.493 Y154.02 E.06824
G3 X194.911 Y152.46 I30.267 J7.269 E.06748
G3 X195.611 Y150.963 I161.537 J74.683 E.06901
G1 X196.55 Y149.627 E.06824
G1 X197.707 Y148.473 E.06823
G1 X199.047 Y147.538 E.06824
G1 X200.487 Y146.866 E.06641
G1 X202.107 Y146.43 E.07007
G1 X203.704 Y146.29 E.06697
G1 X205.362 Y146.435 E.06949
G1 X206.939 Y146.861 E.06824
G1 X208.38 Y147.532 E.06641
G1 X209.755 Y148.493 E.07007
G1 X210.908 Y149.65 E.06823
G1 X211.843 Y150.989 E.06824
G1 X212.531 Y152.471 E.06824
G1 X212.928 Y153.948 E.06389
; Slow Down End
M204 S10000
G1 X211.748 Y151.865 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5266
M204 S8000
G3 X212.305 Y153.388 I-4.042 J2.34 E.05463
G3 X210.271 Y154.183 I-3.288 J-5.417 E.07353
G3 X207.931 Y153.716 I-.648 J-2.849 E.08236
G3 X206.527 Y152.062 I5.346 J-5.96 E.07293
G2 X202.784 Y149.654 I-4.993 J3.649 E.15258
G2 X200.444 Y150.121 I-.648 J2.849 E.08236
G2 X199.04 Y151.775 I5.345 J5.96 E.07293
G3 X194.932 Y154.205 I-4.733 J-3.313 E.16489
G2 X195.867 Y159.838 I8.517 J1.479 E.19498
G1 X195.999 Y160.12 E.01043
G1 X196.89 Y161.393 E.05208
G1 X197.168 Y161.67 E.01315
G2 X199.508 Y161.203 I.648 J-2.85 E.08237
G2 X200.912 Y159.549 I-5.347 J-5.961 E.07293
G3 X204.656 Y157.142 I4.993 J3.649 E.15258
G3 X206.995 Y157.608 I.648 J2.849 E.08236
G3 X208.399 Y159.262 I-5.347 J5.961 E.07293
G2 X210.271 Y160.995 I5.666 J-4.242 E.08595
G1 X210.691 Y161.189 E.01551
G1 X209.573 Y162.368 E.05446
; WIPE_START
G1 F18423.913
G1 X210.261 Y161.643 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z12.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z12.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 12.6
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 63/82
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X213.861 Y155.662 F60000
G1 Z12.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6435
M204 S8000
G1 X213.707 Y157.423 E.05924
G1 X213.249 Y159.131 E.05924
G1 X212.502 Y160.733 E.05924
G1 X211.488 Y162.181 E.05924
G1 X210.238 Y163.431 E.05924
G1 X208.871 Y164.388 E.05593
G1 X208.79 Y164.445 E.00331
G1 X207.188 Y165.192 E.05924
G1 X205.481 Y165.649 E.05924
G1 X203.72 Y165.803 E.05924
G1 X201.959 Y165.649 E.05924
G1 X200.251 Y165.192 E.05924
G1 X198.649 Y164.445 E.05924
G1 X197.201 Y163.431 E.05924
G1 X195.951 Y162.181 E.05924
G1 X194.993 Y160.814 E.05593
G1 X194.937 Y160.733 E.00331
G1 X194.19 Y159.131 E.05924
G1 X193.732 Y157.423 E.05924
G1 X193.578 Y155.662 E.05924
G1 X193.732 Y153.901 E.05924
G1 X194.19 Y152.194 E.05924
G1 X194.937 Y150.591 E.05924
G1 X195.951 Y149.143 E.05924
G1 X197.201 Y147.893 E.05924
G1 X198.649 Y146.879 E.05924
G1 X200.251 Y146.132 E.05924
G1 X201.959 Y145.675 E.05924
G1 X203.72 Y145.521 E.05924
G1 X205.382 Y145.666 E.05593
G1 X205.481 Y145.675 E.00331
G1 X207.188 Y146.132 E.05924
G1 X208.79 Y146.879 E.05924
G1 X210.238 Y147.893 E.05924
G1 X211.488 Y149.143 E.05924
G1 X212.502 Y150.591 E.05924
G1 X213.249 Y152.194 E.05924
G1 X213.681 Y153.806 E.05593
G1 X213.707 Y153.901 E.00331
G1 X213.856 Y155.602 E.05723
; COOLING_NODE: 0
M204 S10000
G1 X214.255 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5157
M204 S5000
G1 X214.094 Y157.491 E.057
G1 X213.619 Y159.265 E.057
G1 X212.843 Y160.929 E.057
G1 X211.79 Y162.434 E.057
G1 X210.491 Y163.732 E.057
G1 X209.096 Y164.709 E.05287
G1 X208.987 Y164.786 E.00413
G1 X207.323 Y165.562 E.057
G1 X205.549 Y166.037 E.057
G1 X203.72 Y166.197 E.057
G1 X201.89 Y166.037 E.057
G1 X200.116 Y165.562 E.057
G1 X198.452 Y164.786 E.057
G1 X196.948 Y163.732 E.057
G1 X195.649 Y162.434 E.057
G1 X194.672 Y161.038 E.05287
G1 X194.596 Y160.93 E.00413
G1 X193.82 Y159.265 E.057
G1 X193.345 Y157.491 E.057
G1 X193.185 Y155.662 E.057
G1 X193.345 Y153.833 E.057
G1 X193.82 Y152.059 E.057
G1 X194.596 Y150.395 E.057
G1 X195.649 Y148.89 E.057
G1 X196.948 Y147.592 E.057
G1 X198.452 Y146.539 E.057
G1 X200.116 Y145.762 E.057
G1 X201.89 Y145.287 E.057
M73 P85 R2
G1 X203.72 Y145.127 E.057
G1 X205.416 Y145.276 E.05287
G1 X205.549 Y145.287 E.00413
G1 X207.323 Y145.762 E.057
G1 X208.987 Y146.539 E.057
G1 X210.491 Y147.592 E.057
G1 X211.79 Y148.89 E.057
G1 X212.843 Y150.395 E.057
G1 X213.619 Y152.059 E.057
G1 X214.06 Y153.704 E.05287
M73 P85 R1
G1 X214.094 Y153.833 E.00413
G1 X214.249 Y155.602 E.05514
; WIPE_START
G1 F12000
M204 S8000
G1 X214.168 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z13 I1.157 J-.377 P1  F60000
G1 X213.322 Y154.001 Z13
G1 Z12.6
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F6435
M204 S8000
G1 X212.88 Y152.328 E.05371
G1 X212.161 Y150.788 E.05275
G1 X211.187 Y149.396 E.05274
G1 X209.985 Y148.195 E.05274
G1 X208.593 Y147.22 E.05274
G1 X207.053 Y146.502 E.05275
G1 X205.412 Y146.062 E.05274
G1 X203.72 Y145.914 E.05274
G1 X202.027 Y146.062 E.05274
G1 X200.386 Y146.502 E.05274
G1 X198.846 Y147.22 E.05275
G1 X197.454 Y148.195 E.05274
G1 X196.252 Y149.396 E.05274
G1 X195.278 Y150.788 E.05274
G1 X194.56 Y152.328 E.05275
G1 X194.12 Y153.969 E.05274
G1 X193.972 Y155.662 E.05274
G1 X194.12 Y157.355 E.05274
G1 X194.56 Y158.996 E.05274
G1 X195.278 Y160.536 E.05275
G1 X196.252 Y161.928 E.05274
G1 X197.454 Y163.129 E.05274
G1 X198.846 Y164.104 E.05274
G1 X200.386 Y164.822 E.05275
G1 X202.027 Y165.262 E.05274
G1 X203.72 Y165.41 E.05274
G1 X205.412 Y165.262 E.05274
G1 X207.053 Y164.822 E.05274
G1 X208.594 Y164.104 E.05275
G1 X209.985 Y163.129 E.05274
G1 X211.187 Y161.928 E.05274
G1 X212.161 Y160.536 E.05274
G1 X212.88 Y158.996 E.05275
G1 X213.319 Y157.355 E.05274
G1 X213.467 Y155.662 E.05274
G1 X213.327 Y154.061 E.0499
M204 S10000
G1 X212.189 Y152.555 F60000
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X212.599 Y154.073 E.04881
G1 X212.741 Y155.639 E.04881
G1 X212.608 Y157.206 E.04881
G1 X212.193 Y158.756 E.04982
G1 X211.527 Y160.181 E.04881
G1 X210.645 Y161.443 E.04779
G1 X209.536 Y162.557 E.04881
G1 X208.25 Y163.463 E.04881
G1 X206.827 Y164.131 E.04882
G1 X205.309 Y164.542 E.04881
G1 X203.743 Y164.683 E.04881
G1 X202.176 Y164.55 E.04881
G1 X200.625 Y164.136 E.04982
G1 X199.201 Y163.47 E.04881
G1 X197.939 Y162.588 E.0478
G1 X196.824 Y161.479 E.04881
G1 X195.919 Y160.193 E.04881
G1 X195.251 Y158.769 E.04881
G1 X194.84 Y157.251 E.04881
G1 X194.699 Y155.685 E.0488
G1 X194.832 Y154.119 E.04881
G1 X195.246 Y152.568 E.04983
G1 X195.912 Y151.143 E.0488
G1 X196.794 Y149.881 E.0478
G1 X197.903 Y148.767 E.04881
G1 X199.189 Y147.861 E.04881
G1 X200.612 Y147.193 E.04881
G1 X202.13 Y146.782 E.04881
G1 X203.71 Y146.641 E.04924
G1 X205.295 Y146.78 E.04939
G1 X206.814 Y147.188 E.04881
G1 X208.238 Y147.854 E.04881
G1 X209.525 Y148.757 E.0488
G1 X210.636 Y149.871 E.04881
G1 X211.52 Y151.131 E.0478
G1 X212.163 Y152.501 E.04695
; Slow Down End
M204 S10000
G1 X212.961 Y154.032 F60000
; LINE_WIDTH: 0.38843
G1 F6435
M204 S8000
G2 X212.516 Y152.402 I-67.789 J17.642 E.04808
G1 X211.864 Y151.007 E.0438
G1 X210.932 Y149.663 E.04652
G1 X209.781 Y148.502 E.04651
G1 X208.445 Y147.558 E.0465
G1 X206.966 Y146.86 E.04651
G1 X205.389 Y146.43 E.04651
G1 X203.679 Y146.281 E.04882
G1 X202.131 Y146.416 E.04419
G1 X200.549 Y146.833 E.04652
G1 X199.064 Y147.517 E.04652
G1 X197.72 Y148.45 E.04651
G1 X196.559 Y149.601 E.04651
G1 X195.615 Y150.936 E.04651
G1 X194.918 Y152.415 E.04651
G1 X194.488 Y153.993 E.04652
G1 X194.338 Y155.622 E.04651
G1 X194.491 Y157.345 E.04922
G1 X194.89 Y158.832 E.04379
G1 X195.575 Y160.317 E.04651
G1 X196.507 Y161.661 E.04651
G1 X197.658 Y162.822 E.04651
G1 X198.994 Y163.766 E.04651
G1 X200.473 Y164.464 E.04651
G1 X202.051 Y164.894 E.04651
G1 X203.679 Y165.043 E.04651
G1 X205.309 Y164.908 E.04651
G1 X206.89 Y164.491 E.04651
G1 X208.375 Y163.807 E.04652
G1 X209.719 Y162.875 E.04651
G1 X210.941 Y161.649 E.04922
G1 X211.824 Y160.388 E.04379
G1 X212.553 Y158.818 E.04923
G1 X212.967 Y157.237 E.04651
G1 X213.101 Y155.703 E.04379
G1 X212.967 Y154.092 E.04596
M204 S10000
G1 X199.05 Y162.887 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6435
M204 S8000
G3 X197.779 Y161.879 I2.223 J-4.109 E.05466
G2 X199.976 Y161.083 I.456 J-2.169 E.08247
G1 X200.912 Y159.757 E.05438
G3 X205.591 Y156.886 I5.131 J3.113 E.1911
G3 X207.463 Y157.729 I.15 J2.166 E.07166
G1 X208.399 Y159.054 E.05438
G2 X210.425 Y161.074 I5.363 J-3.354 E.09668
G2 X212.349 Y155.662 I-6.63 J-5.405 E.19628
G1 X212.218 Y154.163 E.05041
G1 X212.054 Y153.552 E.02121
G3 X209.335 Y154.438 I-3.303 J-5.518 E.09664
G3 X207.463 Y153.595 I-.15 J-2.166 E.07166
G1 X206.527 Y152.27 E.05438
G2 X201.848 Y149.398 I-5.131 J3.113 E.1911
G2 X199.976 Y150.241 I-.15 J2.166 E.07166
G1 X199.04 Y151.567 E.05438
G3 X195.208 Y154.315 I-5.142 J-3.123 E.16238
G1 X195.603 Y152.738 E.0545
; WIPE_START
G1 F18423.913
G1 X195.36 Y153.708 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z13 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z13 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 12.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 64/82
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X213.635 Y155.662 F60000
G1 Z12.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6168
M204 S8000
G1 X213.484 Y157.384 E.05792
G1 X213.037 Y159.053 E.05792
G1 X212.307 Y160.62 E.05792
G1 X211.315 Y162.036 E.05792
G1 X210.093 Y163.258 E.05792
G1 X208.677 Y164.249 E.05792
G1 X207.111 Y164.98 E.05792
G1 X205.441 Y165.427 E.05792
G1 X203.72 Y165.578 E.05792
G1 X201.998 Y165.427 E.05792
G1 X200.328 Y164.98 E.05792
G1 X198.762 Y164.249 E.05792
G1 X197.346 Y163.258 E.05792
G1 X196.124 Y162.036 E.05792
G1 X195.132 Y160.62 E.05792
G1 X194.402 Y159.053 E.05792
G1 X193.955 Y157.384 E.05792
G1 X193.804 Y155.662 E.05792
G1 X193.955 Y153.94 E.05792
G1 X194.402 Y152.271 E.05792
G1 X195.132 Y150.704 E.05792
G1 X196.124 Y149.288 E.05792
G1 X197.346 Y148.066 E.05792
G1 X198.762 Y147.075 E.05792
G1 X200.328 Y146.344 E.05792
G1 X201.998 Y145.897 E.05792
G1 X203.72 Y145.746 E.05792
G1 X205.441 Y145.897 E.05792
G1 X207.111 Y146.344 E.05792
G1 X208.677 Y147.075 E.05792
G1 X210.093 Y148.066 E.05792
G1 X211.315 Y149.288 E.05792
G1 X212.307 Y150.704 E.05792
G1 X213.037 Y152.271 E.05792
G1 X213.484 Y153.94 E.05792
G1 X213.63 Y155.602 E.05591
; COOLING_NODE: 0
M204 S10000
G1 X214.029 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5130
M204 S5000
G1 X213.872 Y157.452 E.05578
G1 X213.407 Y159.188 E.05578
G1 X212.648 Y160.817 E.05578
G1 X211.617 Y162.289 E.05578
G1 X210.346 Y163.559 E.05578
G1 X208.874 Y164.59 E.05578
G1 X207.245 Y165.349 E.05578
G1 X205.51 Y165.815 E.05578
G1 X203.72 Y165.971 E.05578
G1 X201.929 Y165.815 E.05578
G1 X200.194 Y165.349 E.05578
G1 X198.565 Y164.59 E.05578
G1 X197.093 Y163.559 E.05578
G1 X195.822 Y162.289 E.05578
G1 X194.792 Y160.817 E.05578
G1 X194.032 Y159.188 E.05578
G1 X193.567 Y157.452 E.05578
G1 X193.41 Y155.662 E.05578
G1 X193.567 Y153.872 E.05578
G1 X194.047 Y152.105 E.05682
G1 X194.792 Y150.507 E.05472
G1 X195.822 Y149.035 E.05578
G1 X197.093 Y147.765 E.05578
G1 X198.565 Y146.734 E.05578
G1 X200.194 Y145.975 E.05578
G1 X201.929 Y145.51 E.05578
G1 X203.754 Y145.356 E.05683
G1 X205.51 Y145.51 E.05472
G1 X207.245 Y145.975 E.05578
G1 X208.874 Y146.734 E.05578
G1 X210.346 Y147.765 E.05578
G1 X211.617 Y149.035 E.05578
G1 X212.648 Y150.507 E.05578
G1 X213.407 Y152.136 E.05578
G1 X213.872 Y153.872 E.05578
G1 X214.023 Y155.602 E.05392
M204 S10000
G1 X213.239 Y155.696 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F6168
M204 S8000
G1 X213.097 Y154.009 E.05257
G1 X212.667 Y152.405 E.05151
G1 X211.966 Y150.901 E.05152
G1 X211.014 Y149.541 E.05152
G1 X209.84 Y148.368 E.05152
G1 X208.481 Y147.416 E.05152
G1 X206.976 Y146.714 E.05152
G1 X205.373 Y146.285 E.05152
G1 X203.72 Y146.14 E.05152
G1 X202.066 Y146.285 E.05152
G1 X200.463 Y146.714 E.05151
G1 X198.959 Y147.416 E.05152
G1 X197.599 Y148.368 E.05152
G1 X196.425 Y149.541 E.05152
G1 X195.473 Y150.901 E.05152
G1 X194.772 Y152.405 E.05152
G1 X194.342 Y154.009 E.05152
G1 X194.198 Y155.662 E.05152
G1 X194.342 Y157.316 E.05152
G1 X194.772 Y158.919 E.05152
G1 X195.473 Y160.423 E.05152
G1 X196.425 Y161.783 E.05152
G1 X197.599 Y162.956 E.05152
G1 X198.959 Y163.908 E.05152
G1 X200.463 Y164.61 E.05152
G1 X202.066 Y165.039 E.05152
G1 X203.72 Y165.184 E.05152
G1 X205.373 Y165.039 E.05152
G1 X206.976 Y164.61 E.05152
G1 X208.481 Y163.908 E.05152
G1 X209.84 Y162.956 E.05152
G1 X211.014 Y161.783 E.05152
G1 X211.966 Y160.423 E.05152
G1 X212.667 Y158.919 E.05152
G1 X213.097 Y157.316 E.05152
G1 X213.233 Y155.756 E.04859
M204 S10000
G1 X212.318 Y154.122 F60000
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X212.455 Y155.639 E.04726
G1 X212.326 Y157.156 E.04727
G1 X211.936 Y158.628 E.04726
G1 X211.28 Y160.038 E.04828
G1 X210.426 Y161.259 E.04625
G1 X209.353 Y162.339 E.04726
G1 X208.107 Y163.215 E.04727
G1 X206.729 Y163.863 E.04726
G1 X205.259 Y164.261 E.04726
G1 X203.743 Y164.397 E.04726
G1 X202.226 Y164.269 E.04727
G1 X200.754 Y163.879 E.04726
G1 X199.344 Y163.222 E.04828
G1 X198.122 Y162.369 E.04625
G1 X197.043 Y161.295 E.04726
G1 X196.166 Y160.05 E.04727
G1 X195.519 Y158.672 E.04727
G1 X195.121 Y157.202 E.04726
G1 X194.984 Y155.685 E.04726
G1 X195.113 Y154.168 E.04727
G1 X195.503 Y152.696 E.04726
G1 X196.159 Y151.286 E.04828
G1 X197.013 Y150.065 E.04625
G1 X198.087 Y148.985 E.04726
G1 X199.332 Y148.109 E.04727
G1 X200.71 Y147.461 E.04727
G1 X202.18 Y147.063 E.04726
G1 X203.71 Y146.927 E.04769
G1 X205.213 Y147.055 E.04683
G1 X206.685 Y147.445 E.04726
G1 X208.095 Y148.102 E.04828
G1 X209.342 Y148.976 E.04726
G1 X210.417 Y150.054 E.04726
G1 X211.289 Y151.303 E.04727
G1 X211.92 Y152.653 E.04626
G1 X212.303 Y154.064 E.0454
; Slow Down End
M204 S10000
G1 X212.848 Y155.662 F60000
; LINE_WIDTH: 0.448029
G1 F6168
M204 S8000
G2 X212.696 Y154.021 I-63.483 J5.063 E.05497
G1 X212.309 Y152.582 E.04968
G1 X211.644 Y151.137 E.05305
G1 X210.738 Y149.829 E.05305
G1 X209.618 Y148.699 E.05304
G1 X208.32 Y147.781 E.05304
G1 X206.881 Y147.102 E.05305
G1 X205.347 Y146.683 E.05305
G1 X203.676 Y146.537 E.05593
G1 X202.178 Y146.668 E.05015
G1 X200.639 Y147.072 E.05306
G1 X199.194 Y147.738 E.05305
G1 X197.887 Y148.644 E.05305
G1 X196.757 Y149.763 E.05304
G1 X195.838 Y151.062 E.05304
G1 X195.159 Y152.5 E.05305
G1 X194.74 Y154.035 E.05305
G1 X194.595 Y155.72 E.0564
G1 X194.725 Y157.204 E.04968
G1 X195.13 Y158.742 E.05304
G1 X195.795 Y160.187 E.05305
G1 X196.701 Y161.495 E.05305
G1 X197.821 Y162.625 E.05304
G1 X199.12 Y163.543 E.05305
G1 X200.558 Y164.222 E.05305
G1 X202.092 Y164.641 E.05305
G1 X203.676 Y164.787 E.05305
G1 X205.262 Y164.656 E.05304
G1 X206.8 Y164.252 E.05304
G1 X208.245 Y163.586 E.05305
G1 X209.629 Y162.615 E.05641
G1 X210.682 Y161.561 E.04968
G1 X211.651 Y160.174 E.0564
G1 X212.314 Y158.728 E.05304
G1 X212.699 Y157.289 E.04969
G1 X212.843 Y155.722 E.05249
M204 S10000
G1 X199.849 Y163.028 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6168
M204 S8000
G1 X199.548 Y162.888 E.01113
G1 X198.486 Y162.145 E.04344
G2 X199.508 Y161.954 I.276 J-1.356 E.03571
G2 X200.912 Y159.997 I-4.743 J-4.884 E.08115
G3 X203.72 Y157.257 I5.706 J3.039 E.13356
G3 X206.527 Y156.667 I2.554 J5.181 E.09716
M73 P86 R1
G1 X206.995 Y156.857 E.01692
G3 X207.931 Y158.01 I-1.978 J2.563 E.0502
G2 X210.18 Y160.927 I7.769 J-3.665 E.12439
G2 X212.063 Y155.662 I-6.405 J-5.26 E.19111
G1 X211.937 Y154.213 E.04874
G1 X211.803 Y153.714 E.01731
G3 X208.399 Y154.657 I-3.089 J-4.538 E.12049
G1 X207.931 Y154.467 E.01692
G3 X206.527 Y152.509 I4.743 J-4.884 E.08115
G2 X203.72 Y149.77 I-5.706 J3.039 E.13356
G2 X200.912 Y149.18 I-2.554 J5.182 E.09716
G1 X200.444 Y149.37 E.01692
G2 X199.04 Y151.327 I4.743 J4.884 E.08115
G3 X195.49 Y154.359 I-5.576 J-2.934 E.16027
G1 X195.89 Y152.784 E.05448
; WIPE_START
G1 F18423.913
G1 X195.644 Y153.753 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z13.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z13.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 13
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 65/82
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X213.35 Y155.662 F60000
G1 Z13
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6001
M204 S8000
G1 X213.203 Y157.334 E.05625
G1 X212.769 Y158.956 E.05625
G1 X212.059 Y160.477 E.05625
G1 X211.097 Y161.852 E.05625
G1 X209.91 Y163.039 E.05625
G1 X208.535 Y164.002 E.05625
G1 X207.013 Y164.711 E.05625
G1 X205.392 Y165.146 E.05625
G1 X203.72 Y165.292 E.05625
G1 X202.047 Y165.146 E.05625
G1 X200.426 Y164.711 E.05625
G1 X198.905 Y164.002 E.05625
G1 X197.53 Y163.039 E.05625
G1 X197.406 Y162.916 E.00584
G1 X196.343 Y161.852 E.05041
G1 X195.38 Y160.477 E.05625
G1 X194.67 Y158.956 E.05625
G1 X194.236 Y157.334 E.05625
G1 X194.09 Y155.662 E.05625
G1 X194.236 Y153.99 E.05625
G1 X194.67 Y152.368 E.05625
G1 X195.38 Y150.847 E.05625
G1 X196.343 Y149.472 E.05625
G1 X197.53 Y148.285 E.05625
G1 X198.905 Y147.322 E.05625
G1 X200.426 Y146.613 E.05625
G1 X202.047 Y146.178 E.05625
G1 X203.72 Y146.032 E.05625
G1 X203.893 Y146.047 E.00584
G1 X205.392 Y146.178 E.05041
G1 X207.013 Y146.613 E.05625
G1 X208.535 Y147.322 E.05625
G1 X209.91 Y148.285 E.05625
G1 X211.097 Y149.472 E.05625
G1 X212.059 Y150.847 E.05625
G1 X212.769 Y152.368 E.05625
G1 X213.203 Y153.99 E.05625
G1 X213.344 Y155.602 E.05424
; COOLING_NODE: 0
M204 S10000
G1 X213.743 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5089
M204 S5000
G1 X213.591 Y157.403 E.05424
G1 X213.139 Y159.09 E.05423
G1 X212.4 Y160.674 E.05423
G1 X211.398 Y162.105 E.05424
G1 X210.163 Y163.34 E.05423
G1 X208.731 Y164.343 E.05424
G1 X207.148 Y165.081 E.05423
G1 X205.46 Y165.533 E.05423
G1 X203.72 Y165.686 E.05423
G1 X201.979 Y165.533 E.05424
G1 X200.291 Y165.081 E.05423
G1 X198.708 Y164.343 E.05423
G1 X197.277 Y163.34 E.05424
G1 X197.129 Y163.193 E.00647
G1 X196.041 Y162.105 E.04776
G1 X195.039 Y160.674 E.05424
G1 X194.301 Y159.09 E.05423
G1 X193.848 Y157.403 E.05423
G1 X193.696 Y155.662 E.05423
G1 X193.848 Y153.921 E.05423
G1 X194.301 Y152.234 E.05423
G1 X195.039 Y150.65 E.05424
G1 X196.041 Y149.219 E.05424
G1 X197.277 Y147.984 E.05423
G1 X198.708 Y146.981 E.05424
G1 X200.291 Y146.243 E.05423
G1 X201.979 Y145.791 E.05423
G1 X203.72 Y145.639 E.05423
G1 X203.927 Y145.657 E.00647
G1 X205.46 Y145.791 E.04776
G1 X207.148 Y146.243 E.05423
G1 X208.731 Y146.981 E.05423
G1 X210.163 Y147.984 E.05424
G1 X211.398 Y149.219 E.05423
G1 X212.4 Y150.65 E.05424
G1 X213.139 Y152.234 E.05423
G1 X213.591 Y153.921 E.05423
G1 X213.738 Y155.602 E.05237
; WIPE_START
G1 F12000
M204 S8000
G1 X213.656 Y156.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z13.4 I1.154 J-.386 P1  F60000
G1 X212.819 Y154.092 Z13.4
G1 Z13
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F6001
M204 S8000
G1 X212.399 Y152.503 E.05102
G1 X211.718 Y151.044 E.04998
G1 X210.795 Y149.725 E.04997
G1 X209.657 Y148.587 E.04997
G1 X208.338 Y147.663 E.04997
G1 X206.878 Y146.983 E.04998
G1 X205.323 Y146.566 E.04997
G1 X203.72 Y146.426 E.04998
G1 X202.116 Y146.566 E.04997
G1 X200.561 Y146.983 E.04997
G1 X199.101 Y147.663 E.04998
G1 X197.783 Y148.587 E.04997
G1 X196.644 Y149.725 E.04997
G1 X195.721 Y151.044 E.04997
G1 X195.04 Y152.503 E.04998
G1 X194.624 Y154.058 E.04997
G1 X194.483 Y155.662 E.04998
G1 X194.624 Y157.266 E.04998
G1 X195.04 Y158.821 E.04997
G1 X195.721 Y160.28 E.04998
G1 X196.644 Y161.599 E.04998
G1 X197.782 Y162.737 E.04997
G1 X199.101 Y163.661 E.04998
G1 X200.561 Y164.341 E.04998
G1 X202.116 Y164.758 E.04997
G1 X203.72 Y164.898 E.04998
G1 X205.323 Y164.758 E.04997
G1 X206.878 Y164.341 E.04997
G1 X208.338 Y163.661 E.04998
G1 X209.657 Y162.738 E.04997
G1 X210.795 Y161.599 E.04997
G1 X211.718 Y160.28 E.04997
G1 X212.399 Y158.821 E.04998
G1 X212.816 Y157.266 E.04997
G1 X212.956 Y155.662 E.04998
G1 X212.824 Y154.152 E.04705
M204 S10000
G1 X212.037 Y154.172 F60000
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X212.169 Y155.639 E.04572
G1 X212.045 Y157.106 E.04572
G1 X211.668 Y158.53 E.04572
G1 X211.033 Y159.895 E.04673
G1 X210.207 Y161.076 E.04471
G1 X209.169 Y162.12 E.04571
G1 X207.965 Y162.968 E.04573
G1 X206.631 Y163.594 E.04572
G1 X205.21 Y163.979 E.04571
G1 X203.743 Y164.112 E.04572
G1 X202.275 Y163.987 E.04572
G1 X200.852 Y163.61 E.04572
G1 X199.487 Y162.975 E.04673
G1 X198.306 Y162.15 E.04471
G1 X197.262 Y161.111 E.04572
G1 X196.414 Y159.907 E.04572
G1 X195.787 Y158.574 E.04572
G1 X195.402 Y157.152 E.04571
G1 X195.27 Y155.685 E.04571
G1 X195.394 Y154.218 E.04572
G1 X195.771 Y152.794 E.04572
G1 X196.407 Y151.429 E.04673
G1 X197.232 Y150.249 E.04471
G1 X198.27 Y149.204 E.04571
G1 X199.475 Y148.356 E.04572
G1 X200.808 Y147.73 E.04572
G1 X202.229 Y147.345 E.04571
G1 X203.71 Y147.212 E.04615
G1 X205.164 Y147.337 E.04529
G1 X206.588 Y147.714 E.04572
G1 X207.953 Y148.349 E.04673
G1 X209.158 Y149.195 E.04572
G1 X210.198 Y150.238 E.04571
G1 X211.042 Y151.445 E.04572
G1 X211.652 Y152.75 E.04471
G1 X212.021 Y154.114 E.04385
; Slow Down End
M204 S10000
G1 X212.428 Y154.126 F60000
; LINE_WIDTH: 0.448027
G1 F6001
M204 S8000
G2 X212.006 Y152.585 I-57.915 J15.026 E.05331
G1 X211.397 Y151.28 E.04803
G1 X210.519 Y150.013 E.05139
G1 X209.435 Y148.918 E.05138
G1 X208.177 Y148.028 E.05138
G1 X206.783 Y147.37 E.05139
G1 X205.297 Y146.964 E.05138
G1 X203.676 Y146.822 E.05427
G1 X202.228 Y146.949 E.04849
G1 X200.737 Y147.341 E.0514
G1 X199.337 Y147.985 E.05139
G1 X198.07 Y148.863 E.05139
G1 X196.976 Y149.947 E.05138
G1 X196.086 Y151.205 E.05138
G1 X195.428 Y152.598 E.05139
G1 X195.022 Y154.085 E.05138
G1 X194.88 Y155.619 E.05139
G1 X195.025 Y157.254 E.05474
G1 X195.398 Y158.645 E.04802
G1 X196.043 Y160.044 E.05139
G1 X196.92 Y161.311 E.05139
G1 X198.004 Y162.406 E.05138
G1 X199.262 Y163.296 E.05138
G1 X200.656 Y163.954 E.05139
G1 X202.142 Y164.36 E.05138
G1 X203.676 Y164.502 E.05139
G1 X205.212 Y164.375 E.05138
G1 X206.702 Y163.983 E.05138
G1 X208.102 Y163.339 E.05139
G1 X209.369 Y162.461 E.05139
G1 X210.528 Y161.299 E.05473
G1 X211.353 Y160.119 E.04802
G1 X212.045 Y158.631 E.05474
G1 X212.434 Y157.14 E.05138
G1 X212.559 Y155.705 E.04803
G1 X212.434 Y154.186 E.05083
M204 S10000
G1 X200.981 Y163.239 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6001
M204 S8000
G1 X199.522 Y162.523 E.05446
G1 X199.976 Y162.171 E.01923
G1 X200.444 Y161.301 E.03311
G3 X202.316 Y158.212 I10.548 J4.281 E.12154
G3 X206.527 Y156.237 I5.405 J6.047 E.15811
G1 X206.995 Y156.277 E.01574
G1 X207.463 Y156.641 E.01985
G1 X207.931 Y157.511 E.03311
G2 X209.962 Y160.742 I8.326 J-2.98 E.12891
G2 X211.655 Y154.263 I-6.525 J-5.166 E.23096
G1 X211.562 Y153.914 E.01209
G3 X208.399 Y155.087 I-4.196 J-6.463 E.11396
G1 X207.931 Y155.047 E.01574
G1 X207.463 Y154.684 E.01985
G1 X206.995 Y153.813 E.03311
G2 X205.123 Y150.725 I-10.548 J4.281 E.12154
G2 X200.912 Y148.749 I-5.405 J6.047 E.15811
G1 X200.444 Y148.79 E.01574
G1 X199.976 Y149.153 E.01985
G2 X199.04 Y151.032 I15.434 J8.861 E.07038
G3 X195.775 Y154.36 I-5.867 J-2.489 E.15994
G1 X196.2 Y152.792 E.05445
; WIPE_START
G1 F18423.913
G1 X195.939 Y153.757 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z13.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z13.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 13.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 66/82
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X213.064 Y155.662 F60000
G1 Z13.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5743
M204 S8000
G1 X212.922 Y157.285 E.05458
G1 X212.5 Y158.858 E.05458
G1 X211.812 Y160.334 E.05458
G1 X210.878 Y161.668 E.05458
G1 X209.726 Y162.82 E.05458
G1 X208.392 Y163.754 E.05458
G1 X208.076 Y163.902 E.01168
G1 X206.915 Y164.443 E.0429
G1 X205.342 Y164.864 E.05458
G1 X203.72 Y165.006 E.05458
G1 X202.097 Y164.864 E.05458
G1 X200.524 Y164.443 E.05458
G1 X199.047 Y163.754 E.05458
G1 X197.713 Y162.82 E.05458
G1 X196.561 Y161.668 E.05458
G1 X195.627 Y160.334 E.05458
G1 X195.48 Y160.018 E.01168
G1 X194.939 Y158.858 E.0429
G1 X194.517 Y157.285 E.05458
G1 X194.375 Y155.662 E.05458
G1 X194.517 Y154.039 E.05458
G1 X194.607 Y153.703 E.01168
G1 X194.939 Y152.466 E.0429
G1 X195.627 Y150.99 E.05458
G1 X196.561 Y149.656 E.05458
G1 X197.713 Y148.504 E.05458
G1 X199.047 Y147.57 E.05458
G1 X200.524 Y146.881 E.05459
G1 X202.097 Y146.46 E.05458
G1 X203.72 Y146.318 E.05458
G1 X204.067 Y146.348 E.01168
G1 X205.342 Y146.46 E.0429
G1 X206.915 Y146.881 E.05458
G1 X208.392 Y147.57 E.05458
G1 X209.726 Y148.504 E.05458
G1 X210.878 Y149.656 E.05458
G1 X211.812 Y150.99 E.05458
G1 X212.5 Y152.466 E.05458
G1 X212.922 Y154.039 E.05458
G1 X213.059 Y155.602 E.05257
; COOLING_NODE: 0
M204 S10000
G1 X213.457 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F5035
M204 S5000
G1 X213.309 Y157.353 E.05269
G1 X212.87 Y158.993 E.05269
G1 X212.153 Y160.531 E.05269
G1 X211.179 Y161.921 E.05269
G1 X209.979 Y163.122 E.05269
G1 X208.588 Y164.095 E.05269
G1 X208.242 Y164.257 E.01188
G1 X207.05 Y164.813 E.04081
G1 X205.411 Y165.252 E.05269
G1 X203.72 Y165.4 E.05269
G1 X202.029 Y165.252 E.05269
G1 X200.389 Y164.813 E.05269
G1 X198.851 Y164.095 E.05269
G1 X197.46 Y163.122 E.05269
G1 X196.26 Y161.921 E.05269
G1 X195.286 Y160.531 E.05269
G1 X195.125 Y160.184 E.01188
G1 X194.569 Y158.993 E.04081
G1 X194.13 Y157.353 E.05269
G1 X193.982 Y155.662 E.05269
G1 X194.13 Y153.971 E.05269
G1 X194.229 Y153.601 E.01188
G1 X194.569 Y152.332 E.0408
G1 X195.286 Y150.793 E.05269
G1 X196.26 Y149.403 E.05269
G1 X197.46 Y148.202 E.05269
G1 X198.851 Y147.229 E.05269
G1 X200.389 Y146.511 E.05269
G1 X202.029 Y146.072 E.05269
G1 X203.72 Y145.924 E.05269
G1 X204.101 Y145.958 E.01188
G1 X205.411 Y146.072 E.04081
G1 X207.05 Y146.511 E.05269
G1 X208.588 Y147.229 E.05269
G1 X209.979 Y148.202 E.05269
G1 X211.179 Y149.403 E.05269
G1 X212.153 Y150.793 E.05269
G1 X212.87 Y152.332 E.05269
G1 X213.309 Y153.971 E.05269
G1 X213.452 Y155.602 E.05083
M204 S10000
G1 X212.667 Y155.696 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F5743
M204 S8000
G1 X212.534 Y154.108 E.04948
G1 X212.131 Y152.601 E.04842
G1 X211.471 Y151.187 E.04843
G1 X210.576 Y149.909 E.04843
G1 X209.473 Y148.805 E.04843
G1 X208.195 Y147.91 E.04843
G1 X206.781 Y147.251 E.04843
G1 X205.274 Y146.847 E.04842
G1 X203.72 Y146.711 E.04843
G1 X202.165 Y146.847 E.04843
G1 X200.658 Y147.251 E.04842
G1 X199.244 Y147.911 E.04843
G1 X197.966 Y148.805 E.04843
G1 X196.863 Y149.909 E.04843
G1 X195.968 Y151.187 E.04843
G1 X195.309 Y152.601 E.04843
G1 X194.905 Y154.108 E.04843
G1 X194.769 Y155.662 E.04843
G1 X194.905 Y157.216 E.04843
G1 X195.309 Y158.723 E.04842
G1 X195.968 Y160.137 E.04843
G1 X196.863 Y161.415 E.04843
G1 X197.966 Y162.519 E.04843
G1 X199.244 Y163.414 E.04843
G1 X200.658 Y164.073 E.04843
G1 X202.165 Y164.477 E.04842
G1 X203.72 Y164.613 E.04843
G1 X205.274 Y164.477 E.04843
G1 X206.781 Y164.073 E.04842
G1 X208.195 Y163.414 E.04843
G1 X209.473 Y162.519 E.04843
G1 X210.576 Y161.415 E.04843
G1 X211.471 Y160.137 E.04843
G1 X212.131 Y158.723 E.04843
G1 X212.534 Y157.216 E.04842
G1 X212.662 Y155.756 E.0455
M204 S10000
G1 X211.756 Y154.221 F60000
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X211.884 Y155.639 E.04417
G1 X211.764 Y157.057 E.04418
G1 X211.399 Y158.432 E.04417
G1 X210.785 Y159.752 E.04518
M73 P87 R1
G1 X209.989 Y160.892 E.04316
G1 X208.985 Y161.901 E.04417
G1 X207.822 Y162.721 E.04418
G1 X206.534 Y163.326 E.04418
G1 X205.16 Y163.698 E.04417
G1 X203.743 Y163.826 E.04417
G1 X202.325 Y163.706 E.04418
G1 X200.949 Y163.342 E.04417
G1 X199.629 Y162.728 E.04518
G1 X198.49 Y161.931 E.04316
G1 X197.481 Y160.928 E.04417
G1 X196.661 Y159.764 E.04418
G1 X196.056 Y158.476 E.04418
G1 X195.684 Y157.103 E.04417
G1 X195.555 Y155.685 E.04417
G1 X195.675 Y154.267 E.04418
G1 X196.04 Y152.892 E.04417
G1 X196.654 Y151.572 E.04518
G1 X197.45 Y150.432 E.04316
G1 X198.454 Y149.423 E.04417
G1 X199.617 Y148.603 E.04418
G1 X200.906 Y147.998 E.04418
G1 X202.279 Y147.626 E.04417
G1 X203.71 Y147.498 E.0446
G1 X205.114 Y147.618 E.04374
G1 X206.49 Y147.982 E.04418
G1 X207.81 Y148.596 E.04518
G1 X208.974 Y149.414 E.04417
G1 X209.98 Y150.421 E.04417
G1 X210.795 Y151.588 E.04418
G1 X211.383 Y152.848 E.04317
G1 X211.74 Y154.163 E.04231
; Slow Down End
M204 S10000
G1 X212.277 Y155.662 F60000
; LINE_WIDTH: 0.448028
G1 F5743
M204 S8000
G2 X212.133 Y154.12 I-56.057 J4.443 E.05166
G1 X211.773 Y152.777 E.04636
G1 X211.149 Y151.422 E.04973
G1 X210.3 Y150.197 E.04973
G1 X209.251 Y149.137 E.04972
G1 X208.034 Y148.276 E.04972
G1 X206.686 Y147.639 E.04972
G1 X205.247 Y147.245 E.04973
G1 X203.676 Y147.108 E.0526
G1 X202.277 Y147.23 E.04683
G1 X200.835 Y147.609 E.04974
G1 X199.48 Y148.232 E.04973
G1 X198.254 Y149.082 E.04973
G1 X197.194 Y150.131 E.04972
G1 X196.333 Y151.348 E.04973
G1 X195.696 Y152.696 E.04972
G1 X195.303 Y154.134 E.04972
G1 X195.166 Y155.72 E.05308
G1 X195.288 Y157.105 E.04636
G1 X195.667 Y158.547 E.04972
G1 X196.29 Y159.902 E.04973
G1 X197.139 Y161.127 E.04973
G1 X198.188 Y162.187 E.04972
G1 X199.405 Y163.049 E.04973
G1 X200.753 Y163.685 E.04972
G1 X202.192 Y164.079 E.04972
G1 X203.676 Y164.216 E.04973
G1 X205.162 Y164.094 E.04972
G1 X206.605 Y163.715 E.04972
G1 X207.959 Y163.092 E.04973
G1 X209.262 Y162.177 E.05308
G1 X210.245 Y161.193 E.04636
G1 X211.156 Y159.889 E.05308
G1 X211.777 Y158.533 E.04972
G1 X212.136 Y157.19 E.04637
G1 X212.272 Y155.722 E.04917
M204 S10000
G1 X210.839 Y152.608 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5743
M204 S8000
G3 X211.332 Y154.155 I-9.286 J3.811 E.05446
G3 X208.411 Y155.662 I-119.764 J-228.541 E.11013
G1 X208.055 Y156.13 E.01972
G1 X208.022 Y156.598 E.01572
G2 X209.763 Y160.531 I8.264 J-1.307 E.14576
G1 X209.674 Y160.658 E.00522
G3 X200.631 Y162.765 I-5.931 J-4.996 E.33359
G1 X200.567 Y162.682 E.00352
G1 X200.534 Y162.214 E.01572
G3 X202.526 Y158.002 I8.109 J1.258 E.1583
G3 X205.636 Y156.13 I7.328 J8.653 E.12214
G1 X206.515 Y155.662 E.03339
G1 X206.872 Y155.194 E.01972
G1 X206.905 Y154.726 E.01572
G2 X204.913 Y150.514 I-8.109 J1.259 E.1583
G2 X201.803 Y148.642 I-7.328 J8.653 E.12214
G1 X201.199 Y148.321 E.02292
G1 X199.833 Y148.931 E.05013
G1 X199.39 Y149.241 E.01813
G3 X196.206 Y154.258 I-6.99 J-.917 E.20555
G1 X196.063 Y154.335 E.00543
G1 X195.947 Y155.662 E.04465
G1 X195.973 Y155.957 E.00992
; WIPE_START
G1 F18423.913
G1 X195.947 Y155.662 E-.11247
G1 X196.008 Y154.961 E-.26753
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z13.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z13.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 13.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 67/82
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X212.778 Y155.662 F60000
G1 Z13.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5467
M204 S8000
G1 X212.641 Y157.235 E.05291
G1 X212.232 Y158.76 E.05291
G1 X211.565 Y160.191 E.05292
G1 X210.659 Y161.485 E.05291
G1 X209.542 Y162.601 E.05291
G1 X208.249 Y163.507 E.05291
G1 X206.818 Y164.174 E.05292
G1 X205.293 Y164.583 E.05291
G1 X203.72 Y164.721 E.05291
G1 X202.147 Y164.583 E.05291
G1 X200.621 Y164.174 E.05291
G1 X199.19 Y163.507 E.05292
G1 X197.897 Y162.601 E.05291
G1 X196.78 Y161.485 E.05291
G1 X195.875 Y160.191 E.05291
G1 X195.207 Y158.76 E.05292
G1 X194.799 Y157.235 E.05291
G1 X194.661 Y155.662 E.05291
G1 X194.799 Y154.089 E.05291
G1 X195.207 Y152.564 E.05291
G1 X195.428 Y152.09 E.01752
G1 X195.875 Y151.133 E.03539
G1 X196.78 Y149.839 E.05291
G1 X197.897 Y148.723 E.05291
G1 X199.19 Y147.817 E.05291
G1 X200.621 Y147.15 E.05292
G1 X202.147 Y146.741 E.05291
G1 X203.72 Y146.603 E.05291
G1 X204.24 Y146.649 E.01752
G1 X205.293 Y146.741 E.03539
G1 X206.818 Y147.15 E.05291
G1 X208.249 Y147.817 E.05292
G1 X209.542 Y148.723 E.05291
G1 X210.659 Y149.839 E.05291
G1 X211.565 Y151.133 E.05291
G1 X212.232 Y152.564 E.05292
G1 X212.641 Y154.089 E.05291
G1 X212.773 Y155.602 E.0509
; COOLING_NODE: 0
M204 S10000
G1 X213.172 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4970
M204 S5000
G1 X213.028 Y157.303 E.05114
G1 X212.602 Y158.895 E.05114
G1 X211.905 Y160.388 E.05114
G1 X210.96 Y161.738 E.05114
G1 X209.795 Y162.903 E.05114
G1 X208.446 Y163.848 E.05115
G1 X206.952 Y164.544 E.05114
G1 X205.361 Y164.971 E.05114
G1 X203.72 Y165.114 E.05114
G1 X202.078 Y164.971 E.05114
G1 X200.487 Y164.544 E.05114
G1 X198.993 Y163.848 E.05114
G1 X197.644 Y162.903 E.05114
G1 X196.479 Y161.738 E.05114
G1 X195.534 Y160.388 E.05115
G1 X194.837 Y158.895 E.05114
G1 X194.411 Y157.303 E.05114
G1 X194.267 Y155.662 E.05114
G1 X194.411 Y154.021 E.05114
G1 X194.837 Y152.429 E.05114
G1 X195.073 Y151.924 E.0173
G1 X195.534 Y150.936 E.03385
G1 X196.479 Y149.586 E.05114
G1 X197.644 Y148.421 E.05114
G1 X198.993 Y147.476 E.05115
G1 X200.487 Y146.78 E.05114
G1 X202.078 Y146.353 E.05114
G1 X203.72 Y146.21 E.05114
G1 X204.275 Y146.258 E.0173
G1 X205.361 Y146.353 E.03385
G1 X206.952 Y146.78 E.05114
G1 X208.446 Y147.476 E.05114
G1 X209.795 Y148.421 E.05114
G1 X210.96 Y149.586 E.05114
G1 X211.905 Y150.936 E.05115
G1 X212.602 Y152.429 E.05114
G1 X213.028 Y154.021 E.05114
G1 X213.167 Y155.602 E.04928
M204 S10000
G1 X212.382 Y155.696 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F5467
M204 S8000
G1 X212.253 Y154.157 E.04793
G1 X211.862 Y152.699 E.04688
G1 X211.224 Y151.329 E.04689
G1 X210.357 Y150.092 E.04688
G1 X209.289 Y149.024 E.04689
G1 X208.052 Y148.158 E.04688
G1 X206.683 Y147.519 E.04689
G1 X205.224 Y147.129 E.04688
G1 X203.72 Y146.997 E.04689
G1 X202.215 Y147.129 E.04688
G1 X200.756 Y147.519 E.04688
G1 X199.387 Y148.158 E.04689
G1 X198.15 Y149.024 E.04688
G1 X197.082 Y150.092 E.04688
G1 X196.215 Y151.33 E.04688
G1 X195.577 Y152.698 E.04688
G1 X195.186 Y154.157 E.04688
G1 X195.054 Y155.662 E.04688
G1 X195.186 Y157.167 E.04688
G1 X195.577 Y158.626 E.04688
G1 X196.215 Y159.995 E.04689
G1 X197.082 Y161.232 E.04688
G1 X198.15 Y162.3 E.04688
G1 X199.387 Y163.166 E.04688
G1 X200.756 Y163.805 E.04689
G1 X202.215 Y164.195 E.04688
G1 X203.72 Y164.327 E.04688
G1 X205.224 Y164.195 E.04688
G1 X206.683 Y163.805 E.04688
G1 X208.052 Y163.166 E.04689
G1 X209.289 Y162.3 E.04688
G1 X210.357 Y161.232 E.04688
G1 X211.224 Y159.995 E.04688
G1 X211.862 Y158.626 E.04689
G1 X212.253 Y157.167 E.04688
G1 X212.376 Y155.756 E.04396
M204 S10000
G1 X211.115 Y152.946 F60000
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X211.474 Y154.271 E.04262
G1 X211.598 Y155.639 E.04262
G1 X211.482 Y157.007 E.04263
G1 X211.12 Y158.365 E.04364
G1 X210.538 Y159.609 E.04263
G1 X209.77 Y160.708 E.04162
G1 X208.802 Y161.682 E.04262
G1 X207.679 Y162.473 E.04263
G1 X206.436 Y163.058 E.04263
G1 X205.111 Y163.417 E.04262
G1 X203.743 Y163.541 E.04262
G1 X202.374 Y163.425 E.04263
G1 X201.016 Y163.062 E.04364
G1 X199.772 Y162.48 E.04263
G1 X198.673 Y161.712 E.04162
G1 X197.699 Y160.744 E.04263
G1 X196.908 Y159.622 E.04263
G1 X196.324 Y158.378 E.04263
G1 X195.965 Y157.053 E.04262
G1 X195.841 Y155.685 E.04262
G1 X195.957 Y154.317 E.04263
G1 X196.319 Y152.959 E.04364
G1 X196.901 Y151.715 E.04263
G1 X197.669 Y150.616 E.04162
G1 X198.637 Y149.642 E.04262
G1 X199.76 Y148.851 E.04263
G1 X201.003 Y148.267 E.04263
G1 X202.329 Y147.907 E.04262
G1 X203.71 Y147.784 E.04306
G1 X205.097 Y147.905 E.04321
G1 X206.423 Y148.262 E.04263
G1 X207.667 Y148.844 E.04263
G1 X208.791 Y149.633 E.04263
G1 X209.761 Y150.605 E.04262
G1 X210.531 Y151.703 E.04162
G1 X211.09 Y152.891 E.04077
; Slow Down End
M204 S10000
G1 X211.991 Y155.662 F60000
; LINE_WIDTH: 0.448028
G1 F5467
M204 S8000
G2 X211.852 Y154.169 I-52.487 J4.146 E.05
G1 X211.504 Y152.875 E.0447
G1 X210.902 Y151.565 E.04807
G1 X210.081 Y150.38 E.04807
G1 X209.067 Y149.356 E.04806
G1 X207.891 Y148.523 E.04807
G1 X206.588 Y147.907 E.04806
G1 X205.198 Y147.527 E.04807
G1 X203.676 Y147.394 E.05094
G1 X202.327 Y147.512 E.04517
G1 X200.932 Y147.877 E.04808
G1 X199.623 Y148.48 E.04807
G1 X198.438 Y149.3 E.04807
G1 X197.413 Y150.314 E.04806
G1 X196.58 Y151.49 E.04806
G1 X195.965 Y152.794 E.04807
G1 X195.584 Y154.184 E.04806
G1 X195.452 Y155.72 E.05142
G1 X195.569 Y157.055 E.0447
G1 X195.935 Y158.449 E.04806
G1 X196.537 Y159.759 E.04807
G1 X197.358 Y160.944 E.04807
G1 X198.372 Y161.968 E.04806
G1 X199.548 Y162.801 E.04807
G1 X200.851 Y163.417 E.04807
G1 X202.241 Y163.797 E.04806
G1 X203.676 Y163.931 E.04807
G1 X205.113 Y163.812 E.04806
G1 X206.507 Y163.447 E.04806
G1 X207.816 Y162.844 E.04807
G1 X209.078 Y161.958 E.05142
G1 X210.09 Y160.932 E.04806
G1 X210.909 Y159.746 E.04806
G1 X211.509 Y158.435 E.04806
G1 X211.855 Y157.14 E.0447
G1 X211.987 Y155.722 E.0475
M204 S10000
G1 X210.64 Y152.855 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5467
M204 S8000
G1 X210.755 Y153.102 E.0091
G1 X211.097 Y154.414 E.04544
G2 X209.084 Y155.662 I50.924 J84.366 E.07938
G2 X208.456 Y156.598 I.872 J1.264 E.03867
G2 X209.056 Y159.406 I5.829 J.223 E.09721
G1 X209.583 Y160.292 E.03455
G1 X209.455 Y160.475 E.00747
G3 X201.155 Y162.682 I-5.755 J-4.933 E.30594
G1 X200.969 Y162.214 E.01689
G3 X201.569 Y159.406 I5.829 J-.223 E.09721
G3 X204.319 Y156.598 I5.778 J2.909 E.13383
G2 X206.284 Y155.194 I-2.879 J-6.106 E.08136
G1 X206.471 Y154.726 E.01689
G2 X205.871 Y151.918 I-5.829 J-.222 E.09721
G2 X203.12 Y149.11 I-5.778 J2.909 E.13383
G3 X201.959 Y148.412 I5.603 J-10.631 E.04542
G2 X198.979 Y149.876 I1.922 J7.677 E.11209
G1 X198.979 Y150.046 E.00571
G3 X196.376 Y154.25 I-6.236 J-.953 E.17023
G1 X196.251 Y155.869 E.0544
; WIPE_START
G1 F18423.913
G1 X196.328 Y154.872 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z13.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z13.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 13.6
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 68/82
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X212.493 Y155.662 F60000
G1 Z13.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5198
M204 S8000
G1 X212.359 Y157.185 E.05124
G1 X211.964 Y158.663 E.05124
G1 X211.317 Y160.049 E.05125
G1 X210.44 Y161.301 E.05125
G1 X209.359 Y162.383 E.05124
G1 X208.106 Y163.26 E.05125
G1 X207.474 Y163.554 E.02336
G1 X206.72 Y163.906 E.02788
G1 X205.243 Y164.302 E.05125
G1 X203.72 Y164.435 E.05124
G1 X202.196 Y164.302 E.05124
G1 X200.719 Y163.906 E.05124
G1 X199.333 Y163.26 E.05125
G1 X198.08 Y162.383 E.05125
G1 X196.999 Y161.301 E.05124
G1 X196.122 Y160.049 E.05125
G1 X195.827 Y159.417 E.02336
G1 X195.476 Y158.663 E.02788
G1 X195.08 Y157.185 E.05125
G1 X194.947 Y155.662 E.05124
G1 X195.08 Y154.139 E.05125
G1 X195.476 Y152.662 E.05124
G1 X196.122 Y151.276 E.05125
G1 X196.999 Y150.023 E.05125
G1 X198.08 Y148.942 E.05124
G1 X199.333 Y148.064 E.05125
G1 X200.719 Y147.418 E.05125
G1 X202.196 Y147.022 E.05124
G1 X203.72 Y146.889 E.05124
G1 X204.414 Y146.95 E.02336
G1 X205.243 Y147.022 E.02788
G1 X206.72 Y147.418 E.05124
G1 X208.106 Y148.064 E.05125
G1 X209.359 Y148.942 E.05125
G1 X210.44 Y150.023 E.05124
G1 X211.317 Y151.276 E.05125
G1 X211.964 Y152.662 E.05125
G1 X212.359 Y154.139 E.05124
G1 X212.487 Y155.602 E.04923
; COOLING_NODE: 0
M204 S10000
G1 X212.886 Y155.662 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4895
M204 S5000
G1 X212.747 Y157.254 E.0496
G1 X212.333 Y158.797 E.0496
G1 X211.658 Y160.245 E.0496
G1 X210.742 Y161.554 E.0496
G1 X209.612 Y162.684 E.0496
M73 P88 R1
G1 X208.303 Y163.601 E.0496
G1 X207.64 Y163.91 E.02271
G1 X206.855 Y164.276 E.02689
G1 X205.311 Y164.689 E.0496
G1 X203.72 Y164.829 E.0496
G1 X202.128 Y164.689 E.0496
G1 X200.584 Y164.276 E.0496
G1 X199.136 Y163.601 E.0496
G1 X197.827 Y162.684 E.0496
G1 X196.698 Y161.554 E.0496
G1 X195.781 Y160.245 E.0496
G1 X195.472 Y159.582 E.02271
G1 X195.106 Y158.797 E.02689
G1 X194.692 Y157.254 E.0496
G1 X194.553 Y155.662 E.0496
G1 X194.692 Y154.07 E.0496
G1 X195.106 Y152.527 E.0496
G1 X195.781 Y151.079 E.0496
G1 X196.698 Y149.77 E.0496
G1 X197.827 Y148.64 E.0496
G1 X199.136 Y147.724 E.0496
G1 X200.584 Y147.048 E.0496
G1 X202.128 Y146.635 E.0496
G1 X203.72 Y146.495 E.0496
G1 X204.448 Y146.559 E.02271
G1 X205.311 Y146.635 E.02689
G1 X206.855 Y147.048 E.0496
G1 X208.303 Y147.724 E.0496
G1 X209.612 Y148.64 E.0496
G1 X210.742 Y149.77 E.0496
G1 X211.658 Y151.079 E.0496
G1 X212.333 Y152.527 E.0496
G1 X212.747 Y154.07 E.0496
G1 X212.881 Y155.602 E.04774
M204 S10000
G1 X212.096 Y155.697 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F5198
M204 S8000
G1 X211.972 Y154.207 E.0464
G1 X211.594 Y152.796 E.04533
G1 X210.976 Y151.472 E.04534
G1 X210.139 Y150.276 E.04534
G1 X209.106 Y149.243 E.04534
G1 X207.909 Y148.405 E.04534
G1 X206.585 Y147.788 E.04534
G1 X205.175 Y147.41 E.04533
G1 X203.72 Y147.283 E.04534
G1 X202.264 Y147.41 E.04534
G1 X200.854 Y147.788 E.04533
G1 X199.53 Y148.405 E.04534
G1 X198.333 Y149.243 E.04534
G1 X197.301 Y150.276 E.04534
G1 X196.463 Y151.472 E.04534
G1 X195.845 Y152.796 E.04534
G1 X195.467 Y154.207 E.04533
G1 X195.34 Y155.662 E.04534
G1 X195.467 Y157.117 E.04534
G1 X195.845 Y158.528 E.04534
G1 X196.463 Y159.852 E.04534
G1 X197.301 Y161.048 E.04534
G1 X198.333 Y162.081 E.04534
G1 X199.53 Y162.919 E.04534
G1 X200.854 Y163.536 E.04534
G1 X202.264 Y163.914 E.04533
G1 X203.72 Y164.042 E.04534
G1 X205.175 Y163.914 E.04534
G1 X206.585 Y163.536 E.04534
G1 X207.909 Y162.919 E.04534
G1 X209.106 Y162.081 E.04534
G1 X210.139 Y161.048 E.04534
G1 X210.976 Y159.852 E.04534
G1 X211.594 Y158.528 E.04534
G1 X211.972 Y157.117 E.04533
G1 X212.091 Y155.756 E.0424
M204 S10000
G1 X210.839 Y153.046 F60000
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X211.186 Y154.322 E.04104
G1 X211.305 Y155.639 E.04104
G1 X211.194 Y156.956 E.04104
G1 X210.844 Y158.265 E.04205
G1 X210.284 Y159.463 E.04104
G1 X209.545 Y160.52 E.04003
G1 X208.614 Y161.457 E.04103
G1 X207.525 Y162.223 E.0413
G1 X206.336 Y162.782 E.04079
G1 X205.06 Y163.128 E.04104
G1 X203.743 Y163.247 E.04104
G1 X202.425 Y163.136 E.04104
G1 X201.116 Y162.787 E.04205
G1 X199.919 Y162.226 E.04104
G1 X198.862 Y161.488 E.04003
G1 X197.924 Y160.556 E.04103
G1 X197.159 Y159.467 E.04131
G1 X196.6 Y158.278 E.04079
G1 X196.254 Y157.002 E.04104
G1 X196.134 Y155.685 E.04104
G1 X196.245 Y154.368 E.04104
G1 X196.595 Y153.059 E.04206
G1 X197.155 Y151.861 E.04104
G1 X197.894 Y150.804 E.04003
G1 X198.826 Y149.866 E.04104
G1 X199.907 Y149.105 E.04105
G1 X201.103 Y148.542 E.04104
G1 X202.379 Y148.196 E.04103
G1 X203.718 Y148.077 E.04173
G1 X205.046 Y148.194 E.04137
G1 X206.323 Y148.537 E.04104
G1 X207.52 Y149.098 E.04104
G1 X208.602 Y149.857 E.04104
G1 X209.536 Y150.793 E.04104
G1 X210.277 Y151.849 E.04003
G1 X210.814 Y152.992 E.03918
; Slow Down End
M204 S10000
G1 X211.702 Y155.662 F60000
; LINE_WIDTH: 0.455635
G1 F5198
M204 S8000
G2 X211.567 Y154.219 I-48.744 J3.833 E.04923
G1 X211.232 Y152.974 E.04381
G1 X210.651 Y151.71 E.04725
G1 X209.86 Y150.566 E.04726
G1 X208.882 Y149.578 E.04725
G1 X207.747 Y148.774 E.04725
G1 X206.489 Y148.179 E.04725
G1 X205.148 Y147.812 E.04725
G1 X203.684 Y147.683 E.04992
G1 X202.377 Y147.797 E.04458
G1 X201.032 Y148.149 E.04725
G1 X199.768 Y148.73 E.04725
G1 X198.624 Y149.522 E.04726
G1 X197.635 Y150.5 E.04725
G1 X196.831 Y151.635 E.04726
G1 X196.237 Y152.892 E.04725
G1 X195.869 Y154.234 E.04726
G1 X195.741 Y155.72 E.05069
G1 X195.873 Y157.105 E.04725
G1 X196.207 Y158.35 E.04381
G1 X196.784 Y159.606 E.04698
G1 X197.579 Y160.757 E.04753
G1 X198.557 Y161.746 E.04726
G1 X199.692 Y162.55 E.04725
G1 X200.95 Y163.145 E.04725
G1 X202.291 Y163.512 E.04725
G1 X203.676 Y163.641 E.04725
G1 X205.062 Y163.527 E.04725
G1 X206.408 Y163.175 E.04725
G1 X207.752 Y162.547 E.05041
G1 X208.893 Y161.736 E.04756
G1 X209.869 Y160.746 E.04724
G1 X210.658 Y159.601 E.04725
G1 X211.237 Y158.336 E.04725
G1 X211.57 Y157.09 E.04381
G1 X211.697 Y155.722 E.04669
M204 S10000
G1 X210.459 Y153.158 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5198
M204 S8000
G1 X210.804 Y154.413 E.04362
G1 X210.832 Y154.737 E.01092
G1 X209.518 Y155.662 E.05385
G2 X208.68 Y157.534 I1.319 J1.714 E.0716
G2 X209.436 Y159.993 I6.177 J-.553 E.08683
G1 X209.23 Y160.286 E.012
G3 X201.463 Y162.477 I-5.529 J-4.738 E.28663
G3 X201.331 Y160.342 I2.695 J-1.238 E.07333
G3 X204.078 Y156.598 I6.232 J1.693 E.15917
G1 X205.409 Y155.662 E.05451
G2 X206.247 Y153.79 I-1.319 J-1.714 E.0716
G2 X203.361 Y149.11 I-5.994 J.467 E.19135
G1 X202.589 Y148.567 E.03163
G1 X202.47 Y148.578 E.00401
G2 X198.682 Y150.564 I1.195 J6.883 E.14566
G3 X196.727 Y154.069 I-5.507 J-.774 E.13759
G1 X196.635 Y154.413 E.01192
G1 X196.527 Y155.681 E.04264
; WIPE_START
G1 F18423.913
G1 X196.612 Y154.684 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z14 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z14 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 13.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 69/82
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X212.207 Y155.662 F60000
G1 Z13.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F4883
M204 S8000
G1 X212.078 Y157.136 E.04958
G1 X211.695 Y158.565 E.04958
G1 X211.07 Y159.906 E.04958
G1 X210.221 Y161.118 E.04957
G1 X209.175 Y162.164 E.04958
G1 X208.461 Y162.664 E.02921
G1 X207.963 Y163.012 E.02037
G1 X206.622 Y163.638 E.04958
G1 X205.193 Y164.021 E.04958
G1 X203.72 Y164.149 E.04958
G1 X202.246 Y164.021 E.04958
G1 X200.817 Y163.638 E.04958
G1 X199.476 Y163.012 E.04958
G1 X198.264 Y162.164 E.04957
G1 X197.218 Y161.118 E.04958
G1 X196.718 Y160.404 E.02921
G1 X196.369 Y159.906 E.02037
G1 X195.744 Y158.565 E.04958
G1 X195.361 Y157.136 E.04958
G1 X195.232 Y155.662 E.04958
G1 X195.361 Y154.188 E.04958
G1 X195.744 Y152.759 E.04958
G1 X196.369 Y151.418 E.04958
G1 X197.218 Y150.206 E.04957
G1 X198.264 Y149.16 E.04958
G1 X199.476 Y148.312 E.04958
G1 X200.817 Y147.686 E.04958
G1 X202.246 Y147.304 E.04958
G1 X203.72 Y147.175 E.04958
G1 X204.588 Y147.251 E.02921
G1 X205.193 Y147.304 E.02037
G1 X206.622 Y147.686 E.04958
G1 X207.963 Y148.312 E.04958
G1 X209.175 Y149.16 E.04957
G1 X210.221 Y150.206 E.04958
G1 X211.07 Y151.418 E.04958
G1 X211.695 Y152.759 E.04958
G1 X211.921 Y153.601 E.02921
G1 X212.078 Y154.188 E.02037
G1 X212.202 Y155.602 E.04757
; COOLING_NODE: 0
M204 S10000
G1 X212.6 Y155.655 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4813
M204 S5000
G1 X212.601 Y155.662 E.00022
G1 X212.466 Y157.204 E.04805
G1 X212.065 Y158.699 E.04805
G1 X211.411 Y160.103 E.04805
G1 X210.523 Y161.371 E.04805
G1 X209.428 Y162.465 E.04805
G1 X208.686 Y162.985 E.02812
G1 X208.16 Y163.353 E.01993
G1 X206.757 Y164.007 E.04805
G1 X205.262 Y164.408 E.04805
G1 X203.72 Y164.543 E.04805
G1 X202.177 Y164.408 E.04805
G1 X200.682 Y164.007 E.04805
G1 X199.279 Y163.353 E.04805
G1 X198.011 Y162.465 E.04805
G1 X196.916 Y161.371 E.04805
G1 X196.397 Y160.629 E.02812
G1 X196.028 Y160.103 E.01993
G1 X195.374 Y158.699 E.04805
G1 X194.974 Y157.204 E.04805
G1 X194.839 Y155.662 E.04805
G1 X194.974 Y154.12 E.04805
G1 X195.374 Y152.625 E.04805
G1 X196.028 Y151.222 E.04805
G1 X196.916 Y149.953 E.04805
G1 X198.011 Y148.859 E.04805
G1 X199.279 Y147.971 E.04805
G1 X200.682 Y147.317 E.04805
G1 X202.177 Y146.916 E.04805
G1 X203.72 Y146.781 E.04805
G1 X204.622 Y146.86 E.02812
G1 X205.262 Y146.916 E.01993
G1 X206.757 Y147.317 E.04805
G1 X208.16 Y147.971 E.04805
G1 X209.428 Y148.859 E.04805
G1 X210.523 Y149.953 E.04805
G1 X211.411 Y151.222 E.04805
G1 X212.065 Y152.625 E.04805
G1 X212.299 Y153.5 E.02812
G1 X212.466 Y154.12 E.01993
G1 X212.595 Y155.595 E.04597
M204 S10000
G1 X211.81 Y155.703 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F4883
M204 S8000
G1 X211.69 Y154.257 E.04504
G1 X211.325 Y152.894 E.04379
G1 X210.729 Y151.615 E.0438
G1 X209.92 Y150.459 E.04379
G1 X208.922 Y149.462 E.04379
G1 X207.767 Y148.653 E.04379
G1 X206.488 Y148.056 E.0438
G1 X205.125 Y147.691 E.04379
G1 X203.72 Y147.568 E.04379
G1 X202.314 Y147.691 E.04379
G1 X200.951 Y148.056 E.04379
G1 X199.673 Y148.653 E.0438
G1 X198.517 Y149.462 E.04379
G1 X197.519 Y150.459 E.04379
G1 X196.71 Y151.615 E.04379
G1 X196.114 Y152.894 E.0438
G1 X195.749 Y154.257 E.04379
G1 X195.626 Y155.662 E.04379
G1 X195.749 Y157.068 E.04379
G1 X196.114 Y158.43 E.04379
G1 X196.71 Y159.709 E.0438
G1 X197.519 Y160.865 E.04379
G1 X198.517 Y161.862 E.04379
G1 X199.673 Y162.671 E.04379
G1 X200.951 Y163.268 E.0438
G1 X202.314 Y163.633 E.04379
G1 X203.72 Y163.756 E.04379
G1 X205.125 Y163.633 E.04379
G1 X206.488 Y163.268 E.04379
G1 X207.766 Y162.672 E.0438
G1 X208.922 Y161.862 E.04379
G1 X209.92 Y160.865 E.04379
G1 X210.729 Y159.709 E.04379
G1 X211.325 Y158.43 E.0438
G1 X211.69 Y157.068 E.04379
G1 X211.805 Y155.763 E.04066
M204 S10000
G1 X210.436 Y153.193 F60000
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X210.769 Y154.429 E.03973
G1 X210.876 Y155.639 E.0377
G1 X210.771 Y156.882 E.03872
G1 X210.452 Y158.088 E.03872
G1 X209.913 Y159.248 E.03973
G1 X209.217 Y160.244 E.03771
G1 X208.338 Y161.129 E.03872
G1 X207.318 Y161.848 E.03873
G1 X206.158 Y162.39 E.03973
G1 X204.985 Y162.706 E.03771
G1 X203.743 Y162.818 E.03872
G1 X202.468 Y162.708 E.03973
G1 X201.294 Y162.395 E.03771
G1 X200.162 Y161.871 E.03872
G1 X199.137 Y161.159 E.03872
G1 X198.232 Y160.255 E.03973
G1 X197.534 Y159.26 E.03772
G1 X197.003 Y158.131 E.03872
G1 X196.67 Y156.895 E.03973
G1 X196.563 Y155.685 E.03771
G1 X196.668 Y154.442 E.03872
G1 X196.992 Y153.219 E.03929
G3 X197.527 Y152.076 I107.409 J49.499 E.03916
G1 X198.222 Y151.08 E.03771
G1 X199.102 Y150.195 E.03872
G1 X200.149 Y149.46 E.03973
G1 X201.25 Y148.945 E.03771
G1 X202.454 Y148.618 E.03872
G1 X203.743 Y148.506 E.04017
G1 X204.971 Y148.616 E.03828
G1 X206.145 Y148.929 E.03771
G1 X207.306 Y149.469 E.03973
G1 X208.302 Y150.165 E.03771
G1 X209.187 Y151.044 E.03872
G1 X209.906 Y152.064 E.03873
G1 X210.411 Y153.138 E.03686
; Slow Down End
M204 S10000
G1 X211.344 Y155.662 F60000
; LINE_WIDTH: 0.598305
G1 F4883
M204 S8000
G2 X211.213 Y154.275 I-40.692 J3.146 E.06369
G1 X210.898 Y153.102 E.05553
G1 X210.345 Y151.894 E.06074
G1 X209.589 Y150.801 E.06075
G1 X208.656 Y149.856 E.06073
G1 X207.573 Y149.087 E.06073
G1 X206.373 Y148.517 E.06074
G1 X205.092 Y148.165 E.06074
G1 X203.784 Y148.041 E.06007
G1 X202.446 Y148.148 E.06137
G1 X201.16 Y148.483 E.06076
G1 X199.952 Y149.037 E.06074
G1 X198.859 Y149.792 E.06074
G1 X197.913 Y150.725 E.06074
G1 X197.144 Y151.809 E.06073
G1 X196.575 Y153.009 E.06074
G1 X196.223 Y154.29 E.06074
G1 X196.099 Y155.727 E.06593
G1 X196.206 Y156.937 E.05553
G1 X196.541 Y158.222 E.06073
G1 X197.095 Y159.43 E.06074
G1 X197.85 Y160.523 E.06075
G1 X198.783 Y161.468 E.06073
G1 X199.866 Y162.237 E.06073
G1 X201.066 Y162.807 E.06074
G1 X202.347 Y163.159 E.06074
G1 X203.67 Y163.283 E.06073
G1 X204.994 Y163.176 E.06073
G1 X206.279 Y162.841 E.06073
G1 X207.487 Y162.287 E.06074
G1 X208.668 Y161.458 E.06594
G1 X209.599 Y160.511 E.06073
G1 X210.351 Y159.416 E.06073
G1 X210.903 Y158.208 E.06073
G1 X211.216 Y157.034 E.05554
G1 X211.34 Y155.722 E.06026
M204 S10000
G1 X210.146 Y153.609 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4883
M204 S8000
G3 X210.444 Y155.203 I-4.373 J1.643 E.05464
G2 X209.104 Y156.598 I2.355 J3.605 E.06538
G2 X209.185 Y159.406 I3.959 J1.291 E.09601
G1 X209.24 Y159.527 E.00446
G3 X201.564 Y162.061 I-5.507 J-3.786 E.29095
G3 X201.697 Y159.406 I4.054 J-1.127 E.09065
G3 X203.869 Y156.598 I5.971 J2.376 E.12054
G2 X205.527 Y155.194 I-4.253 J-6.702 E.07302
G2 X205.988 Y152.854 I-2.384 J-1.684 E.08232
G2 X203.57 Y149.11 I-6.063 J1.263 E.15277
G1 X203.339 Y148.931 E.00981
G2 X198.339 Y151.597 I.258 J6.504 E.19646
G3 X197.311 Y153.543 I-5.384 J-1.601 E.07422
M73 P89 R1
G2 X197.001 Y155.135 I4.361 J1.675 E.05464
; WIPE_START
G1 F18423.913
G1 X197.057 Y154.487 E-.24718
G1 X197.148 Y154.15 E-.13282
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z14.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z14.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 14
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 70/82
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X211.921 Y155.662 F60000
G1 Z14
G1 E.4 F1800
; FEATURE: Inner wall
G1 F5347
M204 S8000
G1 X211.797 Y157.086 E.04791
G1 X211.427 Y158.467 E.04791
G1 X210.823 Y159.763 E.04791
G1 X210.002 Y160.934 E.04791
G1 X208.992 Y161.945 E.04791
G1 X207.82 Y162.765 E.04791
G1 X206.525 Y163.369 E.04791
G1 X205.514 Y163.64 E.03505
G1 X205.144 Y163.739 E.01286
G1 X203.72 Y163.864 E.04791
G1 X202.295 Y163.739 E.04791
G1 X200.914 Y163.369 E.04791
G1 X199.619 Y162.765 E.04791
G1 X198.448 Y161.945 E.04791
G1 X197.437 Y160.934 E.04791
G1 X196.617 Y159.763 E.04791
G1 X196.012 Y158.467 E.04791
G1 X195.742 Y157.457 E.03505
G1 X195.642 Y157.086 E.01286
G1 X195.518 Y155.662 E.04791
G1 X195.642 Y154.238 E.04791
G1 X196.012 Y152.857 E.04791
G1 X196.617 Y151.561 E.04791
G1 X197.437 Y150.39 E.04791
G1 X198.448 Y149.379 E.04791
G1 X199.619 Y148.559 E.04791
G1 X200.914 Y147.955 E.04791
G1 X202.295 Y147.585 E.04791
G1 X203.72 Y147.46 E.04791
G1 X204.762 Y147.551 E.03505
G1 X205.144 Y147.585 E.01286
G1 X206.525 Y147.955 E.04791
G1 X207.82 Y148.559 E.04791
G1 X208.992 Y149.379 E.04791
G1 X210.002 Y150.39 E.04791
G1 X210.823 Y151.561 E.04791
G1 X211.427 Y152.857 E.04791
G1 X211.697 Y153.867 E.03505
G1 X211.797 Y154.238 E.01286
G1 X211.916 Y155.602 E.0459
; COOLING_NODE: 0
M204 S10000
G1 X212.313 Y155.644 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4729
M204 S5000
G1 X212.315 Y155.662 E.00057
G1 X212.184 Y157.155 E.04651
G1 X211.797 Y158.602 E.04651
G1 X211.163 Y159.96 E.04651
G1 X210.304 Y161.187 E.04651
G1 X209.245 Y162.246 E.04651
G1 X208.017 Y163.106 E.04651
G1 X206.659 Y163.739 E.04651
G1 X205.212 Y164.127 E.04651
G1 X203.72 Y164.257 E.04651
G1 X202.227 Y164.127 E.04651
G1 X200.78 Y163.739 E.04651
G1 X199.422 Y163.106 E.04651
G1 X198.195 Y162.246 E.04651
G1 X197.135 Y161.187 E.04651
G1 X196.276 Y159.96 E.04651
G1 X195.643 Y158.602 E.04651
G1 X195.255 Y157.155 E.04651
G1 X195.124 Y155.662 E.04651
G1 X195.255 Y154.169 E.04651
G1 X195.643 Y152.722 E.04651
G1 X196.276 Y151.364 E.04651
G1 X197.135 Y150.137 E.04651
G1 X198.195 Y149.078 E.04651
G1 X199.422 Y148.218 E.04651
G1 X200.78 Y147.585 E.04651
G1 X202.227 Y147.197 E.04651
G1 X203.72 Y147.067 E.04651
G1 X204.796 Y147.161 E.03353
G1 X205.212 Y147.197 E.01298
G1 X206.659 Y147.585 E.04651
G1 X208.017 Y148.218 E.04651
G1 X209.245 Y149.078 E.04651
G1 X210.304 Y150.137 E.04651
G1 X211.163 Y151.364 E.04651
G1 X211.797 Y152.722 E.04651
G1 X212.076 Y153.766 E.03353
G1 X212.184 Y154.169 E.01298
G1 X212.308 Y155.584 E.04408
M204 S10000
G1 X211.524 Y155.709 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F5347
M204 S8000
G1 X211.409 Y154.306 E.04369
G1 X211.057 Y152.992 E.04224
G1 X210.482 Y151.758 E.04225
G1 X209.701 Y150.643 E.04225
G1 X208.739 Y149.681 E.04225
G1 X207.624 Y148.9 E.04225
G1 X206.39 Y148.325 E.04225
G1 X205.075 Y147.972 E.04224
G1 X203.72 Y147.854 E.04225
G1 X202.364 Y147.972 E.04225
G1 X201.049 Y148.325 E.04224
G1 X199.815 Y148.9 E.04225
G1 X198.701 Y149.681 E.04225
G1 X197.738 Y150.643 E.04225
G1 X196.957 Y151.758 E.04225
G1 X196.382 Y152.992 E.04225
G1 X196.03 Y154.306 E.04224
G1 X195.911 Y155.662 E.04225
G1 X196.03 Y157.018 E.04225
G1 X196.382 Y158.333 E.04224
G1 X196.957 Y159.566 E.04225
G1 X197.738 Y160.681 E.04225
G1 X198.701 Y161.643 E.04225
G1 X199.815 Y162.424 E.04225
G1 X201.049 Y162.999 E.04225
G1 X202.364 Y163.352 E.04224
G1 X203.72 Y163.47 E.04225
G1 X205.075 Y163.352 E.04225
G1 X206.39 Y162.999 E.04224
G1 X207.624 Y162.424 E.04225
G1 X208.739 Y161.643 E.04225
G1 X209.701 Y160.681 E.04225
G1 X210.482 Y159.566 E.04225
G1 X211.057 Y158.332 E.04225
G1 X211.409 Y157.018 E.04224
G1 X211.518 Y155.769 E.03892
M204 S10000
G1 X211.161 Y155.677 F60000
; LINE_WIDTH: 0.391974
G1 F5347
M204 S8000
G2 X211.028 Y154.286 I-27.424 J1.925 E.04017
G1 X210.733 Y153.185 E.03275
G1 X210.196 Y152.005 E.03726
G1 X209.462 Y150.936 E.03726
G1 X208.554 Y150.01 E.03725
G1 X207.5 Y149.257 E.03725
G1 X206.33 Y148.697 E.03726
G1 X205.081 Y148.35 E.03725
G1 X203.805 Y148.226 E.03683
G1 X203.648 Y148.225 E.00451
G1 X202.499 Y148.325 E.03315
G1 X201.243 Y148.649 E.03727
G1 X200.062 Y149.186 E.03726
G1 X198.993 Y149.919 E.03726
G1 X198.068 Y150.827 E.03725
G1 X197.968 Y150.948 E.00451
G1 X197.314 Y151.882 E.03275
G1 X196.755 Y153.052 E.03725
G1 X196.407 Y154.301 E.03726
G1 X196.282 Y155.591 E.03725
G1 X196.383 Y156.884 E.03725
G1 X196.706 Y158.139 E.03725
G1 X197.243 Y159.319 E.03725
G1 X197.977 Y160.388 E.03726
G1 X198.885 Y161.314 E.03725
G1 X199.939 Y162.068 E.03725
G1 X201.109 Y162.627 E.03726
G1 X202.358 Y162.974 E.03725
G1 X203.649 Y163.099 E.03725
G1 X203.806 Y163.098 E.00451
G1 X204.941 Y162.999 E.03275
G1 X206.197 Y162.675 E.03725
G1 X207.377 Y162.139 E.03725
G1 X208.446 Y161.405 E.03726
G1 X209.371 Y160.497 E.03725
G1 X210.125 Y159.442 E.03725
G1 X210.684 Y158.272 E.03726
G1 X211.032 Y157.023 E.03725
G1 X211.157 Y155.737 E.03713
M204 S10000
G1 X210.341 Y154.471 F60000
; Slow Down Start
; LINE_WIDTH: 0.41999
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X210.447 Y155.639 E.0364
G1 X210.349 Y156.807 E.0364
G1 X210.049 Y157.941 E.0364
G1 X209.557 Y159.006 E.0364
G1 X208.888 Y159.968 E.0364
G1 X208.062 Y160.801 E.0364
G1 X207.075 Y161.493 E.03742
G1 X206.012 Y161.987 E.0364
G1 X204.879 Y162.289 E.0364
G1 X203.71 Y162.39 E.0364
G1 X202.542 Y162.286 E.0364
G1 X201.41 Y161.981 E.0364
G1 X200.348 Y161.484 E.0364
G1 X199.388 Y160.81 E.0364
G1 X198.569 Y159.991 E.03595
G3 X197.889 Y159.018 I85.175 J-60.251 E.03685
G1 X197.395 Y157.954 E.0364
G1 X197.098 Y156.853 E.03539
G1 X196.992 Y155.685 E.0364
G1 X197.09 Y154.517 E.0364
G1 X197.39 Y153.383 E.0364
G1 X197.882 Y152.319 E.0364
G1 X198.572 Y151.331 E.03741
G1 X199.377 Y150.524 E.03539
G1 X200.336 Y149.848 E.0364
G1 X201.397 Y149.348 E.03641
G1 X202.528 Y149.041 E.0364
G1 X203.743 Y148.935 E.03784
G1 X204.897 Y149.038 E.03596
G1 X205.999 Y149.332 E.03539
G1 X207.063 Y149.824 E.0364
G1 X208.026 Y150.493 E.0364
G1 X208.879 Y151.345 E.03741
G1 X209.55 Y152.306 E.0364
G1 X210.033 Y153.339 E.0354
G1 X210.325 Y154.413 E.03453
; Slow Down End
M204 S10000
G1 X198.288 Y160.222 F60000
; LINE_WIDTH: 0.391973
G1 F5347
M204 S8000
G3 X197.56 Y159.171 I37.428 J-26.725 E.03673
G1 X197.044 Y158.048 E.03551
G1 X196.731 Y156.853 E.0355
G1 X196.63 Y155.622 E.03551
G1 X196.745 Y154.391 E.03551
G1 X197.072 Y153.199 E.03551
G1 X197.6 Y152.082 E.03551
G1 X198.315 Y151.074 E.03551
G1 X199.194 Y150.205 E.03551
G1 X200.127 Y149.55 E.03278
G1 X201.333 Y148.986 E.03825
G1 X202.529 Y148.673 E.03552
G1 X203.775 Y148.573 E.0359
G1 X204.991 Y148.687 E.03509
G1 X206.182 Y149.014 E.03551
G1 X207.299 Y149.543 E.03551
G1 X208.308 Y150.257 E.0355
G1 X209.176 Y151.136 E.03551
G1 X209.879 Y152.153 E.03551
G1 X210.395 Y153.276 E.03551
G1 X210.708 Y154.471 E.0355
G1 X210.809 Y155.703 E.03551
G1 X210.71 Y156.839 E.03277
G1 X210.368 Y158.125 E.03824
G1 X209.839 Y159.242 E.03551
G1 X209.124 Y160.25 E.0355
G1 X208.246 Y161.119 E.03551
G1 X207.229 Y161.822 E.03552
G1 X206.106 Y162.338 E.03551
G1 X204.911 Y162.651 E.0355
G1 X203.679 Y162.751 E.03551
G1 X202.449 Y162.637 E.03551
G1 X201.257 Y162.31 E.03551
G1 X200.14 Y161.781 E.03551
G1 X199.131 Y161.067 E.03551
G1 X198.329 Y160.266 E.03258
M204 S10000
G1 X202.386 Y149.485 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5347
M204 S8000
G3 X203.961 Y149.347 I1.434 J7.316 E.05309
G3 X205.879 Y152.854 I-3.473 J4.178 E.13717
G3 X205.241 Y155.194 I-3.011 J.436 E.08359
G2 X202.739 Y157.534 I228.272 J246.62 E.1148
G2 X201.651 Y161.642 I3.887 J3.227 E.14699
G2 X209.138 Y158.928 I2.081 J-5.942 E.28892
G3 X210.047 Y155.756 I2.952 J-.87 E.1167
G2 X209.848 Y154.147 I-7.985 J.172 E.05443
; WIPE_START
G1 F18423.913
G1 X209.959 Y154.562 E-.16325
G1 X210.001 Y155.131 E-.21675
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z14.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z14.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 14.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 71/82
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X211.636 Y155.662 F60000
G1 Z14.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F4984
M204 S8000
G1 X211.515 Y157.037 E.04624
G1 X211.158 Y158.369 E.04624
G1 X210.575 Y159.62 E.04624
G1 X209.784 Y160.75 E.04624
G1 X208.808 Y161.726 E.04624
G1 X207.808 Y162.426 E.04089
G1 X207.678 Y162.518 E.00535
G1 X206.427 Y163.101 E.04624
G1 X205.094 Y163.458 E.04624
G1 X203.72 Y163.578 E.04624
G1 X202.345 Y163.458 E.04624
G1 X201.012 Y163.101 E.04624
G1 X199.761 Y162.518 E.04624
G1 X198.631 Y161.726 E.04624
G1 X197.655 Y160.75 E.04624
G1 X196.956 Y159.751 E.04089
G1 X196.864 Y159.62 E.00535
G1 X196.281 Y158.369 E.04624
G1 X195.924 Y157.037 E.04624
G1 X195.803 Y155.662 E.04624
G1 X195.924 Y154.287 E.04624
G1 X196.281 Y152.955 E.04624
G1 X196.864 Y151.704 E.04624
G1 X197.655 Y150.574 E.04624
G1 X198.631 Y149.598 E.04624
G1 X199.761 Y148.806 E.04624
G1 X201.012 Y148.223 E.04624
G1 X202.345 Y147.866 E.04624
G1 X203.72 Y147.746 E.04624
G1 X204.935 Y147.852 E.04089
G1 X205.094 Y147.866 E.00535
G1 X206.427 Y148.223 E.04624
G1 X207.678 Y148.806 E.04624
G1 X208.808 Y149.598 E.04624
G1 X209.784 Y150.574 E.04624
G1 X210.575 Y151.704 E.04624
G1 X211.158 Y152.955 E.04624
G1 X211.515 Y154.287 E.04624
G1 X211.63 Y155.602 E.04423
; COOLING_NODE: 0
M204 S10000
G1 X212.027 Y155.632 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4648
M204 S5000
G1 X212.029 Y155.662 E.00095
G1 X211.903 Y157.105 E.04496
G1 X211.528 Y158.504 E.04496
G1 X210.916 Y159.817 E.04496
G1 X210.085 Y161.003 E.04496
G1 X209.061 Y162.028 E.04496
G1 X208.033 Y162.747 E.03894
G1 X207.874 Y162.858 E.00602
G1 X206.562 Y163.471 E.04496
G1 X205.163 Y163.846 E.04496
G1 X203.72 Y163.972 E.04496
G1 X202.277 Y163.846 E.04496
G1 X200.877 Y163.471 E.04496
G1 X199.565 Y162.858 E.04496
G1 X198.378 Y162.028 E.04496
G1 X197.354 Y161.003 E.04496
G1 X196.634 Y159.976 E.03894
G1 X196.523 Y159.817 E.00602
G1 X195.911 Y158.504 E.04496
G1 X195.536 Y157.105 E.04496
G1 X195.41 Y155.662 E.04496
G1 X195.536 Y154.219 E.04496
G1 X195.911 Y152.82 E.04496
G1 X196.523 Y151.507 E.04496
G1 X197.354 Y150.321 E.04496
G1 X198.378 Y149.296 E.04496
G1 X199.565 Y148.466 E.04496
G1 X200.877 Y147.853 E.04496
G1 X202.277 Y147.479 E.04496
G1 X203.72 Y147.352 E.04496
G1 X204.969 Y147.462 E.03894
G1 X205.163 Y147.479 E.00602
G1 X206.562 Y147.853 E.04496
G1 X207.874 Y148.466 E.04496
G1 X209.061 Y149.296 E.04496
G1 X210.085 Y150.321 E.04496
G1 X210.916 Y151.507 E.04496
G1 X211.528 Y152.82 E.04496
G1 X211.903 Y154.219 E.04496
G1 X212.021 Y155.572 E.04215
M204 S10000
G1 X211.238 Y155.715 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F4984
M204 S8000
G1 X211.128 Y154.356 E.04234
G1 X210.789 Y153.089 E.0407
G1 X210.234 Y151.901 E.04071
G1 X209.482 Y150.827 E.0407
G1 X208.555 Y149.899 E.0407
G1 X207.481 Y149.147 E.0407
G1 X206.292 Y148.593 E.04071
G1 X205.026 Y148.254 E.0407
G1 X203.72 Y148.139 E.0407
G1 X202.413 Y148.254 E.0407
G1 X201.147 Y148.593 E.0407
G1 X199.958 Y149.147 E.04071
G1 X198.884 Y149.899 E.0407
G1 X197.957 Y150.827 E.0407
G1 X197.205 Y151.901 E.0407
G1 X196.651 Y153.089 E.04071
G1 X196.311 Y154.356 E.0407
G1 X196.197 Y155.662 E.0407
G1 X196.311 Y156.968 E.0407
G1 X196.651 Y158.235 E.0407
G1 X197.205 Y159.423 E.04071
G1 X197.957 Y160.497 E.0407
G1 X198.884 Y161.425 E.0407
G1 X199.958 Y162.177 E.0407
G1 X201.147 Y162.731 E.04071
G1 X202.413 Y163.07 E.0407
G1 X203.72 Y163.185 E.0407
G1 X205.026 Y163.07 E.0407
G1 X206.292 Y162.731 E.0407
G1 X207.481 Y162.177 E.04071
G1 X208.555 Y161.425 E.0407
G1 X209.482 Y160.497 E.0407
G1 X210.234 Y159.423 E.0407
G1 X210.789 Y158.235 E.04071
G1 X211.128 Y156.968 E.0407
G1 X211.232 Y155.775 E.03718
M204 S10000
G1 X210.84 Y155.68 F60000
; LINE_WIDTH: 0.46334
G1 F4984
M204 S8000
G2 X210.709 Y154.333 I-22.918 J1.539 E.04687
G1 X210.433 Y153.304 E.03686
G1 X210.372 Y153.139 E.00608
G1 X209.922 Y152.174 E.03687
G1 X209.833 Y152.022 E.00608
G1 X209.221 Y151.15 E.03687
G1 X209.108 Y151.016 E.00608
G1 X208.354 Y150.263 E.03686
G1 X208.219 Y150.151 E.00608
G1 X207.346 Y149.54 E.03686
G1 X207.194 Y149.453 E.00608
G1 X206.228 Y149.003 E.03686
G1 X206.063 Y148.944 E.00608
G1 X205.034 Y148.669 E.03687
G1 X204.862 Y148.64 E.00605
G1 X203.814 Y148.548 E.03638
G1 X203.639 Y148.547 E.00608
G1 X202.564 Y148.641 E.03734
G1 X202.39 Y148.673 E.00611
G1 X201.361 Y148.949 E.03686
G1 X201.197 Y149.01 E.00608
G1 X200.231 Y149.46 E.03686
G1 X200.08 Y149.549 E.00608
G1 X199.207 Y150.16 E.03687
G1 X199.073 Y150.274 E.00608
G1 X198.321 Y151.027 E.03686
G1 X198.208 Y151.162 E.00608
G1 X197.598 Y152.035 E.03687
G1 X197.511 Y152.188 E.00608
G1 X197.061 Y153.153 E.03686
G1 X197.002 Y153.319 E.00608
G1 X196.726 Y154.348 E.03686
G1 X196.697 Y154.521 E.00608
G1 X196.604 Y155.582 E.03687
G1 X196.605 Y155.758 E.00608
G1 X196.699 Y156.819 E.03686
G1 X196.73 Y156.991 E.00608
G1 X197.006 Y158.02 E.03687
G1 X197.067 Y158.185 E.00608
G1 X197.518 Y159.15 E.03686
G1 X197.606 Y159.302 E.00608
G1 X198.218 Y160.174 E.03687
G1 X198.331 Y160.308 E.00608
G1 X199.085 Y161.061 E.03686
G1 X199.22 Y161.173 E.00608
G1 X200.093 Y161.784 E.03686
G1 X200.245 Y161.871 E.00608
G1 X201.211 Y162.321 E.03686
G1 X201.376 Y162.38 E.00608
G1 X202.405 Y162.655 E.03686
G1 X202.578 Y162.685 E.00608
G1 X203.64 Y162.777 E.03687
G1 X203.815 Y162.776 E.00608
G1 X204.876 Y162.683 E.03686
G1 X205.049 Y162.651 E.00608
G1 X206.078 Y162.376 E.03686
G1 X206.242 Y162.314 E.00608
G1 X207.208 Y161.864 E.03687
G1 X207.359 Y161.775 E.00608
G1 X208.232 Y161.164 E.03687
G1 X208.366 Y161.05 E.00608
G1 X209.119 Y160.297 E.03686
G1 X209.231 Y160.162 E.00608
G1 X209.841 Y159.289 E.03686
G1 X209.928 Y159.136 E.00608
G1 X210.378 Y158.171 E.03686
G1 X210.437 Y158.005 E.00608
G1 X210.713 Y156.976 E.03686
G1 X210.742 Y156.803 E.00608
G1 X210.835 Y155.74 E.03693
M204 S10000
G1 X209.918 Y154.545 F60000
; Slow Down Start
; LINE_WIDTH: 0.41999
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X210.018 Y155.639 E.03408
G1 X209.927 Y156.733 E.03408
G1 X209.646 Y157.794 E.03408
G1 X209.186 Y158.791 E.03408
G1 X208.56 Y159.693 E.03408
G1 X207.786 Y160.472 E.03408
G1 X206.861 Y161.121 E.03509
G1 X205.865 Y161.584 E.03408
G1 X204.804 Y161.867 E.03408
G1 X203.71 Y161.961 E.03408
G1 X202.617 Y161.863 E.03408
G1 X201.557 Y161.578 E.03408
G1 X200.562 Y161.112 E.03408
G1 X199.664 Y160.481 E.03408
G1 X198.897 Y159.715 E.03363
G3 X198.26 Y158.803 I74.74 J-52.909 E.03454
G1 X197.809 Y157.838 E.03307
M73 P90 R1
G1 X197.521 Y156.779 E.03408
G1 X197.421 Y155.685 E.03407
G1 X197.513 Y154.591 E.03408
G1 X197.793 Y153.53 E.03408
G1 X198.253 Y152.533 E.03408
G1 X198.901 Y151.606 E.03509
G1 X199.653 Y150.852 E.03307
G1 X200.55 Y150.219 E.03408
G1 X201.543 Y149.751 E.03408
G1 X202.603 Y149.463 E.03408
G1 X203.743 Y149.363 E.03552
G1 X204.822 Y149.461 E.03364
G1 X205.852 Y149.735 E.03307
G1 X206.849 Y150.196 E.03408
G1 X207.75 Y150.822 E.03408
G1 X208.55 Y151.62 E.03509
G1 X209.179 Y152.521 E.03408
G1 X209.63 Y153.486 E.03307
G1 X209.903 Y154.487 E.03221
; Slow Down End
M204 S10000
G1 X198.589 Y159.969 F60000
; LINE_WIDTH: 0.46334
G1 F4984
M204 S8000
G3 X197.899 Y158.972 I31.713 J-22.695 E.04198
G1 X197.412 Y157.911 E.04039
G1 X197.118 Y156.782 E.0404
G1 X197.024 Y155.618 E.04039
G1 X197.133 Y154.456 E.0404
G1 X197.442 Y153.331 E.04039
G1 X197.942 Y152.276 E.0404
G1 X198.618 Y151.324 E.0404
G1 X199.449 Y150.505 E.04039
G1 X200.321 Y149.892 E.03689
G1 X201.47 Y149.355 E.0439
G1 X202.6 Y149.06 E.04042
G1 X203.778 Y148.966 E.04087
G1 X204.925 Y149.075 E.03989
G1 X206.051 Y149.385 E.0404
G1 X207.105 Y149.885 E.04039
G1 X208.057 Y150.561 E.04039
G1 X208.877 Y151.391 E.0404
G1 X209.54 Y152.352 E.0404
G1 X210.027 Y153.413 E.0404
G1 X210.321 Y154.542 E.04039
G1 X210.416 Y155.706 E.04039
G1 X210.324 Y156.768 E.03689
G1 X209.997 Y157.993 E.0439
G1 X209.497 Y159.048 E.04039
G1 X208.821 Y160 E.0404
G1 X207.99 Y160.819 E.04039
G1 X207.03 Y161.483 E.0404
G1 X205.969 Y161.969 E.0404
G1 X204.839 Y162.264 E.0404
G1 X203.676 Y162.358 E.04039
G1 X202.514 Y162.249 E.0404
G1 X201.388 Y161.939 E.0404
G1 X200.334 Y161.439 E.0404
G1 X199.382 Y160.763 E.0404
G1 X198.63 Y160.013 E.03676
M204 S10000
G1 X202.971 Y149.82 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4984
M204 S8000
G3 X204.122 Y149.79 I.661 J3.248 E.03878
G1 X204.593 Y149.831 E.01585
G3 X205.656 Y151.918 I-4.455 J3.582 E.07903
G3 X205.333 Y154.726 I-3.787 J.987 E.0969
G3 X203.503 Y156.598 I-7.441 J-5.443 E.08801
G2 X201.729 Y161.221 I3.384 J3.951 E.17294
G2 X209.196 Y157.842 I1.961 J-5.606 E.3031
G3 X209.522 Y156.742 I2.631 J.182 E.03878
G2 X209.579 Y155.121 I-7.542 J-1.076 E.05444
; WIPE_START
G1 F18423.913
G1 X209.627 Y155.662 E-.20633
G1 X209.583 Y156.117 E-.17367
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z14.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z14.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 14.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 72/82
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 0
G1 X211.342 Y155.653 F60000
G1 Z14.4
G1 E.4 F1800
; FEATURE: Inner wall
G1 F4486
M204 S8000
G1 X211.343 Y155.662 E.00029
G1 X211.227 Y156.986 E.04453
G1 X210.883 Y158.269 E.04453
G1 X210.321 Y159.474 E.04453
G1 X209.559 Y160.562 E.04452
G1 X208.62 Y161.501 E.04452
G1 X207.524 Y162.267 E.04481
G1 X206.327 Y162.825 E.04425
G1 X205.043 Y163.169 E.04453
G1 X203.72 Y163.285 E.04452
G1 X202.396 Y163.169 E.04453
G1 X201.112 Y162.825 E.04453
G1 X199.908 Y162.264 E.04453
G1 X198.82 Y161.502 E.04452
G1 X197.88 Y160.562 E.04452
G1 X197.114 Y159.466 E.04481
G1 X196.556 Y158.269 E.04425
G1 X196.212 Y156.986 E.04453
G1 X196.097 Y155.662 E.04453
G1 X196.212 Y154.338 E.04453
G1 X196.556 Y153.055 E.04453
G1 X197.118 Y151.851 E.04452
G1 X197.88 Y150.762 E.04453
G1 X198.82 Y149.823 E.04453
G1 X199.908 Y149.06 E.04453
G1 X201.112 Y148.499 E.04452
G1 X202.396 Y148.155 E.04452
G1 X203.728 Y148.04 E.04481
G1 X205.043 Y148.155 E.04425
G1 X206.327 Y148.499 E.04453
G1 X207.531 Y149.06 E.04453
G1 X208.62 Y149.823 E.04453
G1 X209.559 Y150.762 E.04453
G1 X210.321 Y151.851 E.04453
G1 X210.883 Y153.055 E.04453
G1 X211.227 Y154.338 E.04453
G1 X211.337 Y155.594 E.04222
; COOLING_NODE: 0
M204 S10000
G1 X211.732 Y155.619 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4486
M204 S5000
G1 X211.736 Y155.662 E.00134
G1 X211.614 Y157.054 E.04338
G1 X211.253 Y158.404 E.04337
G1 X210.662 Y159.67 E.04338
G1 X209.861 Y160.815 E.04337
G1 X208.873 Y161.803 E.04337
G1 X207.72 Y162.608 E.04364
G1 X206.461 Y163.195 E.04311
G1 X205.112 Y163.557 E.04338
G1 X203.72 Y163.679 E.04337
G1 X202.328 Y163.557 E.04338
G1 X200.978 Y163.195 E.04337
G1 X199.711 Y162.605 E.04338
G1 X198.567 Y161.803 E.04337
G1 X197.579 Y160.815 E.04337
G1 X196.773 Y159.663 E.04364
G1 X196.187 Y158.404 E.04311
G1 X195.825 Y157.054 E.04338
G1 X195.703 Y155.662 E.04337
G1 X195.825 Y154.27 E.04338
G1 X196.187 Y152.92 E.04338
G1 X196.777 Y151.654 E.04337
G1 X197.579 Y150.509 E.04338
G1 X198.567 Y149.521 E.04337
G1 X199.711 Y148.72 E.04338
G1 X200.978 Y148.129 E.04337
G1 X202.327 Y147.767 E.04337
G1 X203.728 Y147.646 E.04363
G1 X205.112 Y147.767 E.04311
G1 X206.461 Y148.129 E.04337
G1 X207.728 Y148.72 E.04338
G1 X208.872 Y149.521 E.04338
G1 X209.861 Y150.509 E.04337
G1 X210.662 Y151.654 E.04338
G1 X211.253 Y152.92 E.04337
G1 X211.614 Y154.27 E.04338
G1 X211.727 Y155.559 E.04018
M204 S10000
G1 X210.944 Y155.721 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F4486
M204 S8000
G1 X210.85 Y154.533 E.03699
G1 X210.546 Y153.312 E.03906
G1 X210.034 Y152.162 E.03907
G1 X209.33 Y151.119 E.03906
G1 X208.456 Y150.214 E.03906
G1 X207.438 Y149.474 E.03906
G1 X206.307 Y148.922 E.03906
G1 X205.097 Y148.575 E.03906
G1 X203.861 Y148.445 E.0386
G1 X203.593 Y148.445 E.00832
G1 X202.464 Y148.543 E.03518
G1 X201.247 Y148.869 E.0391
G1 X200.105 Y149.401 E.03911
G1 X199.073 Y150.124 E.03912
G1 X198.182 Y151.015 E.03911
G1 X197.459 Y152.047 E.03912
G1 X196.926 Y153.189 E.03911
G1 X196.6 Y154.407 E.03911
G1 X196.49 Y155.662 E.03912
G1 X196.6 Y156.917 E.03912
G1 X196.926 Y158.135 E.03911
G1 X197.455 Y159.269 E.03887
G1 X198.182 Y160.309 E.03937
G1 X199.073 Y161.2 E.0391
G1 X200.105 Y161.923 E.03911
G1 X201.247 Y162.455 E.03912
G1 X202.464 Y162.782 E.03911
G1 X203.72 Y162.891 E.03912
G1 X204.975 Y162.782 E.03911
G1 X206.192 Y162.455 E.03911
G1 X207.327 Y161.926 E.03887
G1 X208.367 Y161.2 E.03937
G1 X209.258 Y160.309 E.0391
G1 X209.98 Y159.277 E.03911
G1 X210.513 Y158.135 E.03912
G1 X210.839 Y156.917 E.03911
G1 X210.939 Y155.781 E.03541
M204 S10000
G1 X210.512 Y155.683 F60000
; LINE_WIDTH: 0.531218
G1 F4486
M204 S8000
G1 X210.419 Y154.571 E.04487
G1 X210.128 Y153.424 E.04755
G1 X209.642 Y152.345 E.04757
G1 X208.976 Y151.367 E.04756
G1 X208.15 Y150.52 E.04756
G1 X207.19 Y149.828 E.04756
G1 X206.124 Y149.314 E.04756
G1 X204.986 Y148.993 E.04756
G1 X203.823 Y148.876 E.04696
G1 X203.63 Y148.876 E.00776
G1 X202.63 Y148.963 E.04036
G1 X201.482 Y149.254 E.04761
G1 X200.403 Y149.74 E.04757
G1 X199.425 Y150.406 E.04756
G1 X198.577 Y151.231 E.04756
G1 X197.886 Y152.192 E.04756
G1 X197.372 Y153.257 E.04756
G1 X197.051 Y154.396 E.04756
G1 X196.932 Y155.573 E.04756
G1 X197.02 Y156.753 E.04756
G1 X197.311 Y157.9 E.04755
G1 X197.797 Y158.979 E.04756
G1 X198.463 Y159.957 E.04756
G1 X199.289 Y160.804 E.04757
G1 X200.249 Y161.496 E.04756
G1 X201.315 Y162.01 E.04756
G1 X202.454 Y162.331 E.04756
G1 X203.631 Y162.449 E.04756
G1 X204.811 Y162.362 E.04756
G1 X205.957 Y162.07 E.04755
G1 X207.036 Y161.584 E.04756
G1 X208.014 Y160.918 E.04756
G1 X208.862 Y160.093 E.04757
G1 X209.553 Y159.133 E.04756
G1 X210.067 Y158.067 E.04756
G1 X210.388 Y156.928 E.04756
G2 X210.507 Y155.743 I-25.07 J-3.119 E.04787
M204 S10000
G1 X209.589 Y155.638 F60000
; Slow Down Start
; LINE_WIDTH: 0.41999
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X209.504 Y156.658 E.03176
G1 X209.243 Y157.647 E.03176
G1 X208.815 Y158.576 E.03176
G1 X208.231 Y159.417 E.03176
G1 X207.511 Y160.143 E.03176
G1 X206.675 Y160.734 E.03177
G1 X205.749 Y161.17 E.03176
G1 X204.762 Y161.438 E.03175
G1 X203.743 Y161.532 E.03176
G1 X202.724 Y161.447 E.03176
G1 X201.734 Y161.186 E.03176
G1 X200.805 Y160.757 E.03176
G1 X199.939 Y160.153 E.03278
G1 X199.238 Y159.453 E.03075
G1 X198.648 Y158.617 E.03176
G1 X198.212 Y157.692 E.03176
G1 X197.943 Y156.704 E.03175
G1 X197.85 Y155.686 E.03175
G1 X197.935 Y154.666 E.03176
G1 X198.196 Y153.677 E.03176
G1 X198.624 Y152.748 E.03176
G1 X199.208 Y151.907 E.03176
G1 X199.928 Y151.181 E.03176
G1 X200.764 Y150.591 E.03176
G1 X201.69 Y150.154 E.03176
G1 X202.677 Y149.886 E.03176
G1 X203.71 Y149.792 E.0322
G1 X204.716 Y149.877 E.03132
G1 X205.705 Y150.138 E.03175
G1 X206.634 Y150.567 E.03176
G1 X207.474 Y151.15 E.03176
G1 X208.201 Y151.871 E.03176
G1 X208.791 Y152.707 E.03176
G1 X209.227 Y153.633 E.03176
G1 X209.496 Y154.62 E.03175
G1 X209.584 Y155.579 E.02989
; Slow Down End
M204 S10000
G1 X199.634 Y160.459 F60000
; LINE_WIDTH: 0.530607
G1 F4486
M204 S8000
G1 X198.932 Y159.759 E.03979
G1 X198.294 Y158.865 E.04407
G1 X197.82 Y157.875 E.04409
G1 X197.526 Y156.817 E.04409
G1 X197.419 Y155.724 E.04408
G1 X197.504 Y154.629 E.04409
G1 X197.778 Y153.565 E.04409
G1 X198.232 Y152.565 E.04409
G1 X198.853 Y151.66 E.04409
G1 X199.622 Y150.875 E.04409
G1 X200.516 Y150.237 E.0441
G1 X201.507 Y149.763 E.0441
G1 X202.672 Y149.449 E.04845
G1 X203.673 Y149.362 E.04034
G1 X204.753 Y149.447 E.04351
G1 X205.816 Y149.721 E.04406
G1 X206.816 Y150.175 E.04409
G1 X207.722 Y150.796 E.04409
G1 X208.506 Y151.565 E.04409
G1 X209.145 Y152.458 E.0441
G1 X209.619 Y153.449 E.0441
G1 X209.913 Y154.507 E.04409
G1 X210.02 Y155.6 E.04408
G1 X209.935 Y156.695 E.04409
G1 X209.661 Y157.759 E.04409
G1 X209.207 Y158.759 E.04409
G1 X208.586 Y159.664 E.04409
G1 X207.817 Y160.449 E.04409
G1 X206.923 Y161.087 E.0441
G1 X205.932 Y161.561 E.0441
G1 X204.874 Y161.856 E.04409
G1 X203.781 Y161.962 E.04409
G1 X202.686 Y161.877 E.04409
G1 X201.623 Y161.604 E.04409
G1 X200.623 Y161.149 E.04409
G1 X199.68 Y160.497 E.04602
M204 S10000
G1 X203.401 Y161.112 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4486
M204 S8000
G3 X201.811 Y160.794 I.615 J-7.192 E.05445
G3 X203.333 Y156.598 I4.925 J-.588 E.15513
G2 X205.122 Y154.726 I-8.017 J-9.455 E.08694
G2 X205.051 Y150.369 I-3.63 J-2.12 E.15352
G2 X204.283 Y150.233 I-.769 J2.109 E.02625
G2 X203.441 Y150.208 I-.492 J2.377 E.0284
; WIPE_START
G1 F18423.913
G1 X204.283 Y150.233 E-.32037
G1 X204.283 Y150.233 E0
G1 X204.438 Y150.261 E-.05963
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z14.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z14.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 14.6
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 73/82
; update layer progress
M73 L73
M991 S0 P72 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 1
G1 X210.913 Y155.652 F60000
G1 Z14.6
G1 E.4 F1800
; FEATURE: Inner wall
G1 F4161
M204 S8000
G1 X210.914 Y155.662 E.00033
G1 X210.804 Y156.911 E.04202
G1 X210.48 Y158.123 E.04202
G1 X209.95 Y159.259 E.04202
G1 X209.231 Y160.286 E.04202
G1 X208.344 Y161.173 E.04202
G1 X207.317 Y161.892 E.04202
G1 X206.18 Y162.422 E.04202
G1 X206.066 Y162.453 E.00394
G1 X204.969 Y162.747 E.03808
G1 X203.72 Y162.856 E.04202
G1 X202.47 Y162.747 E.04202
G1 X201.259 Y162.422 E.04202
G1 X200.123 Y161.892 E.04202
G1 X199.095 Y161.173 E.04202
G1 X198.209 Y160.286 E.04202
G1 X197.489 Y159.259 E.04202
G1 X196.959 Y158.122 E.04202
G1 X196.929 Y158.009 E.00394
G1 X196.635 Y156.911 E.03808
G1 X196.526 Y155.662 E.04202
G1 X196.635 Y154.413 E.04202
G1 X196.959 Y153.202 E.04202
G1 X197.489 Y152.065 E.04202
G1 X198.209 Y151.038 E.04202
G1 X199.095 Y150.151 E.04202
G1 X200.123 Y149.432 E.04202
G1 X201.259 Y148.902 E.04202
G1 X202.47 Y148.577 E.04202
G1 X203.72 Y148.468 E.04202
G1 X203.837 Y148.478 E.00394
G1 X204.969 Y148.577 E.03808
G1 X206.18 Y148.902 E.04202
G1 X207.317 Y149.432 E.04202
G1 X208.344 Y150.151 E.04202
G1 X209.231 Y151.038 E.04202
G1 X209.95 Y152.065 E.04202
G1 X210.48 Y153.202 E.04202
G1 X210.804 Y154.413 E.04202
G1 X210.908 Y155.592 E.03968
; COOLING_NODE: 1
M204 S10000
G1 X211.303 Y155.618 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4161
M204 S5000
G1 X211.307 Y155.662 E.00137
G1 X211.192 Y156.98 E.04105
G1 X210.85 Y158.257 E.04105
G1 X210.291 Y159.456 E.04106
G1 X209.532 Y160.539 E.04105
G1 X208.597 Y161.474 E.04105
G1 X207.513 Y162.233 E.04106
G1 X206.315 Y162.792 E.04105
G1 X206.168 Y162.831 E.00472
G1 X205.037 Y163.134 E.03633
G1 X203.72 Y163.25 E.04105
G1 X202.402 Y163.134 E.04105
G1 X201.124 Y162.792 E.04105
G1 X199.926 Y162.233 E.04106
G1 X198.842 Y161.475 E.04105
G1 X197.907 Y160.539 E.04105
G1 X197.148 Y159.456 E.04106
G1 X196.59 Y158.257 E.04105
G1 X196.55 Y158.11 E.00472
G1 X196.247 Y156.98 E.03633
G1 X196.132 Y155.662 E.04105
G1 X196.247 Y154.344 E.04105
G1 X196.59 Y153.067 E.04105
G1 X197.149 Y151.868 E.04106
G1 X197.907 Y150.785 E.04105
G1 X198.842 Y149.85 E.04105
G1 X199.926 Y149.091 E.04106
G1 X201.124 Y148.532 E.04105
G1 X202.402 Y148.19 E.04105
G1 X203.72 Y148.074 E.04106
G1 X203.871 Y148.088 E.00472
G1 X205.037 Y148.19 E.03634
G1 X206.315 Y148.532 E.04105
G1 X207.513 Y149.091 E.04106
G1 X208.597 Y149.85 E.04105
G1 X209.532 Y150.785 E.04106
G1 X210.291 Y151.868 E.04105
G1 X210.85 Y153.067 E.04106
G1 X211.192 Y154.344 E.04105
G1 X211.298 Y155.558 E.03782
M204 S10000
G1 X210.515 Y155.721 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F4161
M204 S8000
G1 X210.428 Y154.608 E.03467
G1 X210.143 Y153.459 E.03673
G1 X209.663 Y152.377 E.03675
G1 X209.002 Y151.395 E.03675
G1 X208.18 Y150.542 E.03674
G1 X207.224 Y149.845 E.03674
G1 X206.16 Y149.325 E.03674
G1 X205.023 Y148.998 E.03675
G1 X203.861 Y148.874 E.03627
G1 X202.666 Y148.954 E.03716
G1 X201.516 Y149.239 E.03677
G1 X200.434 Y149.719 E.03674
G1 X199.452 Y150.38 E.03674
G1 X198.6 Y151.201 E.03674
G1 X197.903 Y152.158 E.03674
G1 X197.383 Y153.221 E.03675
G1 X197.055 Y154.359 E.03674
G1 X196.93 Y155.536 E.03674
G1 X197.011 Y156.716 E.03674
G1 X197.296 Y157.865 E.03674
G1 X197.777 Y158.947 E.03674
G1 X198.437 Y159.929 E.03675
G1 X199.259 Y160.782 E.03674
G1 X200.215 Y161.479 E.03673
G1 X201.279 Y161.999 E.03675
G1 X202.416 Y162.326 E.03674
M73 P91 R1
G1 X203.593 Y162.451 E.03674
G1 X204.774 Y162.37 E.03674
G1 X205.923 Y162.085 E.03674
G1 X207.005 Y161.605 E.03674
G1 X207.987 Y160.944 E.03675
G1 X208.839 Y160.123 E.03674
G1 X209.536 Y159.166 E.03674
G1 X210.056 Y158.103 E.03675
G1 X210.384 Y156.965 E.03674
G2 X210.51 Y155.781 I-31.138 J-3.905 E.03697
M204 S10000
G1 X210.083 Y155.683 F60000
; LINE_WIDTH: 0.53128
G1 F4161
M204 S8000
G1 X209.997 Y154.645 E.04188
G1 X209.725 Y153.571 E.04455
G1 X209.27 Y152.56 E.04457
G1 X208.647 Y151.643 E.04457
G1 X207.875 Y150.848 E.04456
G1 X206.975 Y150.2 E.04456
G1 X205.978 Y149.718 E.04456
G1 X204.911 Y149.416 E.04457
G1 X203.823 Y149.305 E.04395
G1 X202.704 Y149.385 E.04511
G1 X201.628 Y149.657 E.0446
G1 X200.617 Y150.111 E.04456
G1 X199.7 Y150.734 E.04456
G1 X198.906 Y151.507 E.04456
G1 X198.257 Y152.406 E.04455
G1 X197.775 Y153.404 E.04457
G1 X197.473 Y154.471 E.04456
G1 X197.361 Y155.573 E.04456
G1 X197.442 Y156.679 E.04456
G1 X197.714 Y157.753 E.04456
G1 X198.169 Y158.764 E.04456
G1 X198.792 Y159.681 E.04457
G1 X199.565 Y160.476 E.04456
G1 X200.464 Y161.124 E.04455
G1 X201.462 Y161.607 E.04457
G1 X202.528 Y161.908 E.04456
G1 X203.631 Y162.02 E.04456
G1 X204.736 Y161.939 E.04456
G1 X205.811 Y161.667 E.04456
G1 X206.822 Y161.213 E.04456
G1 X207.739 Y160.59 E.04457
G1 X208.533 Y159.817 E.04456
G1 X209.182 Y158.918 E.04456
G1 X209.664 Y157.92 E.04457
G1 X209.966 Y156.853 E.04456
G2 X210.078 Y155.743 I-22.081 J-2.8 E.04486
M204 S10000
G1 X203.71 Y150.221 F60000
; Slow Down Start
; LINE_WIDTH: 0.41999
G1 F3000;_EXTRUDE_SET_SPEED
M204 S8000
G1 X204.641 Y150.3 E.02901
G1 X205.558 Y150.541 E.02943
G1 X206.419 Y150.938 E.02943
G1 X207.199 Y151.479 E.02944
G1 X207.872 Y152.147 E.02943
G1 X208.42 Y152.921 E.02944
G1 X208.824 Y153.779 E.02944
G1 X209.073 Y154.694 E.02943
G1 X209.16 Y155.638 E.02943
G1 X209.082 Y156.584 E.02944
G1 X208.84 Y157.501 E.02944
G1 X208.443 Y158.362 E.02944
G1 X207.903 Y159.141 E.02943
G1 X207.235 Y159.815 E.02944
G1 X206.46 Y160.362 E.02944
G1 X205.602 Y160.767 E.02944
G1 X204.687 Y161.016 E.02944
G1 X203.743 Y161.103 E.02943
G1 X202.798 Y161.024 E.02944
G1 X201.881 Y160.783 E.02944
G1 X201.02 Y160.386 E.02944
G1 X200.241 Y159.845 E.02943
G3 X199.555 Y159.164 I6.284 J-7.013 E.03002
G1 X199.02 Y158.403 E.02888
G1 X198.615 Y157.545 E.02944
G1 X198.366 Y156.63 E.02944
G1 X198.279 Y155.686 E.02943
G1 X198.357 Y154.741 E.02944
G1 X198.599 Y153.823 E.02944
G1 X198.996 Y152.962 E.02944
G1 X199.537 Y152.183 E.02943
G1 X200.204 Y151.509 E.02944
G1 X200.979 Y150.962 E.02944
G1 X201.837 Y150.558 E.02944
G1 X202.752 Y150.308 E.02944
G1 X203.65 Y150.227 E.02801
; Slow Down End
M204 S10000
G1 X199.221 Y159.44 F60000
; LINE_WIDTH: 0.530721
G1 F4161
M204 S8000
G1 X198.666 Y158.651 E.03872
G1 X198.223 Y157.728 E.0411
G1 X197.948 Y156.742 E.0411
G1 X197.848 Y155.724 E.04109
G1 X197.927 Y154.703 E.0411
G1 X198.181 Y153.712 E.0411
G1 X198.604 Y152.78 E.0411
G1 X199.182 Y151.935 E.04109
G1 X199.898 Y151.204 E.0411
G1 X200.73 Y150.608 E.0411
G1 X201.653 Y150.166 E.0411
G1 X202.639 Y149.891 E.0411
G1 X203.672 Y149.79 E.04168
G1 X204.679 Y149.869 E.04054
G1 X205.67 Y150.124 E.04107
G1 X206.602 Y150.546 E.0411
G1 X207.446 Y151.125 E.0411
G1 X208.177 Y151.841 E.04109
G1 X208.773 Y152.673 E.04111
G1 X209.216 Y153.596 E.04111
G1 X209.491 Y154.582 E.04109
G1 X209.591 Y155.6 E.04109
G1 X209.512 Y156.621 E.0411
G1 X209.258 Y157.612 E.0411
G1 X208.835 Y158.544 E.0411
G1 X208.257 Y159.389 E.04109
G1 X207.541 Y160.12 E.0411
G1 X206.709 Y160.716 E.0411
G1 X205.786 Y161.158 E.0411
G1 X204.8 Y161.434 E.0411
G1 X203.781 Y161.533 E.04109
G1 X202.761 Y161.455 E.0411
G1 X201.77 Y161.2 E.0411
G1 X200.837 Y160.778 E.0411
G1 X199.993 Y160.2 E.04109
G1 X199.262 Y159.484 E.0411
M204 S10000
G1 X203.4 Y160.683 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4161
M204 S8000
G3 X201.822 Y160.327 I.389 J-5.4 E.05443
G3 X203.165 Y156.598 I4.794 J-.379 E.1369
G2 X204.928 Y154.726 I-14.685 J-15.589 E.0862
G2 X205.367 Y150.896 I-3.454 J-2.337 E.13429
G2 X204.445 Y150.676 I-1.085 J2.509 E.03195
G1 X203.769 Y150.617 E.02271
; WIPE_START
G1 F18423.913
G1 X204.445 Y150.676 E-.25758
G1 X204.758 Y150.751 E-.12242
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z15 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z15 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

M106 S255
; CHANGE_LAYER
; Z_HEIGHT: 14.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 74/82
; update layer progress
M73 L74
M991 S0 P73 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 2
G1 X210.484 Y155.651 F60000
G1 Z14.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F18000
M204 S8000
G1 X210.485 Y155.662 E.00038
G1 X210.382 Y156.837 E.03952
G1 X210.077 Y157.976 E.03952
G1 X209.578 Y159.045 E.03952
G1 X208.902 Y160.011 E.03951
G1 X208.068 Y160.844 E.03952
G1 X207.102 Y161.521 E.03952
G1 X206.033 Y162.019 E.03952
G1 X204.894 Y162.324 E.03952
G1 X203.72 Y162.427 E.03952
G1 X202.545 Y162.324 E.03952
G1 X201.406 Y162.019 E.03952
G1 X200.337 Y161.521 E.03952
G1 X199.371 Y160.844 E.03951
G1 X198.537 Y160.011 E.03952
G1 X197.861 Y159.045 E.03952
G1 X197.362 Y157.976 E.03952
G1 X197.057 Y156.837 E.03952
G1 X196.954 Y155.662 E.03952
G1 X197.057 Y154.487 E.03952
G1 X197.362 Y153.348 E.03952
G1 X197.861 Y152.279 E.03952
G1 X198.537 Y151.314 E.03952
G1 X199.371 Y150.48 E.03952
G1 X200.337 Y149.803 E.03951
G1 X201.406 Y149.305 E.03952
G1 X202.545 Y149 E.03952
G1 X203.72 Y148.897 E.03952
G1 X203.998 Y148.921 E.00937
G1 X204.894 Y149 E.03015
G1 X206.033 Y149.305 E.03952
G1 X207.102 Y149.803 E.03952
G1 X208.068 Y150.48 E.03951
G1 X208.902 Y151.313 E.03952
G1 X209.578 Y152.279 E.03952
G1 X210.077 Y153.348 E.03952
G1 X210.382 Y154.487 E.03952
G1 X210.479 Y155.591 E.03713
; COOLING_NODE: 2
M204 S10000
G1 X210.874 Y155.617 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F12000
M204 S5000
G1 X210.878 Y155.662 E.00141
G1 X210.77 Y156.905 E.03873
G1 X210.447 Y158.11 E.03873
G1 X209.919 Y159.241 E.03873
G1 X209.203 Y160.264 E.03873
G1 X208.321 Y161.146 E.03873
G1 X207.299 Y161.862 E.03874
G1 X207.014 Y161.994 E.00974
G1 X206.168 Y162.389 E.02899
G1 X204.963 Y162.712 E.03873
G1 X203.72 Y162.821 E.03873
G1 X202.476 Y162.712 E.03873
G1 X201.271 Y162.389 E.03873
G1 X200.14 Y161.862 E.03873
G1 X199.118 Y161.146 E.03873
G1 X198.236 Y160.264 E.03873
G1 X197.52 Y159.241 E.03874
G1 X197.387 Y158.957 E.00974
G1 X196.993 Y158.11 E.02899
G1 X196.67 Y156.905 E.03873
G1 X196.561 Y155.662 E.03873
G1 X196.67 Y154.419 E.03873
G1 X196.993 Y153.214 E.03873
G1 X197.125 Y152.929 E.00974
G1 X197.52 Y152.083 E.02899
G1 X198.236 Y151.061 E.03873
G1 X199.118 Y150.178 E.03873
G1 X200.14 Y149.462 E.03873
G1 X201.271 Y148.935 E.03873
G1 X202.476 Y148.612 E.03873
G1 X203.72 Y148.503 E.03874
G1 X204.032 Y148.531 E.00974
G1 X204.963 Y148.612 E.02899
G1 X206.168 Y148.935 E.03873
G1 X207.299 Y149.462 E.03873
G1 X208.321 Y150.178 E.03873
G1 X209.203 Y151.06 E.03873
G1 X209.919 Y152.083 E.03874
G1 X210.447 Y153.214 E.03873
G1 X210.77 Y154.419 E.03873
G1 X210.869 Y155.557 E.03546
M204 S10000
G1 X210.12 Y155.676 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.357833
G1 F12000
M204 S8000
G1 X210.032 Y154.627 E.02728
G2 X209.728 Y153.46 I-20.013 J4.593 E.03127
; LINE_WIDTH: 0.376573
G1 X209.492 Y152.987 E.01454
; LINE_WIDTH: 0.418404
G1 X209.255 Y152.513 E.01636
G1 X208.732 Y151.754 E.02852
G1 X208.499 Y151.465 E.01146
G1 X207.815 Y150.781 E.02989
G1 X206.905 Y150.144 E.03433
G1 X205.899 Y149.675 E.03433
G1 X204.826 Y149.387 E.03432
G1 X203.72 Y149.29 E.03433
G1 X202.613 Y149.387 E.03433
G1 X202.113 Y149.508 E.0159
; LINE_WIDTH: 0.359778
G1 X201.543 Y149.643 E.01526
G2 X200.507 Y150.126 I4.585 J11.184 E.02983
G2 X199.595 Y150.768 I6.657 J10.432 E.02911
G2 X198.807 Y151.558 I8.367 J9.118 E.02911
G2 X198.17 Y152.474 I9.836 J7.536 E.02911
G2 X197.7 Y153.486 I10.984 J5.708 E.02911
G2 X197.414 Y154.564 I11.803 J3.712 E.02911
G2 X197.319 Y155.676 I12.243 J1.605 E.02911
G2 X197.419 Y156.787 I12.349 J-.547 E.02911
G1 X197.682 Y157.777 E.02672
G1 X197.946 Y158.342 E.01628
; LINE_WIDTH: 0.418183
G2 X198.219 Y158.873 I5.048 J-2.261 E.01843
G1 X198.839 Y159.758 E.03337
G1 X199.624 Y160.543 E.03431
G1 X200.534 Y161.18 E.03431
G1 X201.54 Y161.649 E.03431
G1 X202.613 Y161.937 E.0343
G1 X203.72 Y162.034 E.03431
G1 X204.826 Y161.937 E.03431
G1 X205.332 Y161.814 E.01607
; LINE_WIDTH: 0.359415
G1 X205.896 Y161.681 E.0151
G2 X206.932 Y161.198 I-4.583 J-11.181 E.0298
G2 X207.844 Y160.556 I-6.649 J-10.422 E.02908
G2 X208.632 Y159.766 I-8.349 J-9.101 E.02908
G2 X209.27 Y158.85 I-9.817 J-7.522 E.02908
G2 X209.739 Y157.838 I-10.97 J-5.701 E.02908
G2 X210.025 Y156.76 I-11.801 J-3.712 E.02907
G1 X210.116 Y155.736 E.02679
M204 S10000
G1 X208.181 Y152.91 F60000
; LINE_WIDTH: 0.417295
G1 F12000
M204 S8000
G3 X209.386 Y153.533 I-17.671 J35.62 E.0418
G1 X209.459 Y153.648 E.00419
; LINE_WIDTH: 0.358708
G1 X209.714 Y154.617 E.02607
G1 X209.805 Y155.675 E.02759
G1 X209.71 Y156.731 E.02757
G1 X209.433 Y157.755 E.02757
G1 X208.983 Y158.716 E.02758
G1 X208.347 Y159.612 E.02856
G1 X207.621 Y160.332 E.02658
G1 X206.751 Y160.938 E.02757
G1 X205.848 Y161.362 E.02594
G1 X205.367 Y161.474 E.01284
G1 X204.924 Y161.265 E.01271
; LINE_WIDTH: 0.41999
G1 X204.155 Y160.878 E.02674
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
G1 X203.735 Y160.666 E.01459
G1 X202.874 Y160.594 E.02683
G1 X202.03 Y160.372 E.02708
G1 X201.238 Y160.007 E.02708
G1 X200.521 Y159.511 E.02707
G1 X200.16 Y159.154 E.01576
G1 X199.986 Y159.029 E.00666
G1 X199.526 Y158.797 E.01598
; Slow Down End
; LINE_WIDTH: 0.411657
G1 F12000
G3 X198.191 Y158.105 I9.728 J-20.386 E.04564
G1 X197.985 Y157.695 E.01393
; LINE_WIDTH: 0.358692
G1 X197.725 Y156.706 E.02658
G1 X197.635 Y155.649 E.02757
G1 X197.729 Y154.593 E.02757
G1 X198.006 Y153.569 E.02757
G1 X198.456 Y152.608 E.02757
G1 X199.091 Y151.712 E.02855
G1 X199.818 Y150.992 E.02659
G1 X200.688 Y150.386 E.02757
G1 X201.592 Y149.962 E.02595
G1 X202.078 Y149.849 E.01298
G1 X202.515 Y150.055 E.01257
; LINE_WIDTH: 0.41999
G1 X203.291 Y150.446 E.02696
; Slow Down Start
G1 F3000;_EXTRUDE_SET_SPEED
G1 X203.712 Y150.658 E.01463
G1 X204.565 Y150.73 E.02658
G1 X205.409 Y150.952 E.02708
G1 X206.201 Y151.317 E.02708
G1 X206.918 Y151.814 E.02707
G1 X207.538 Y152.427 E.02708
G1 X207.716 Y152.675 E.00948
; Slow Down End
G1 F12000
G1 X208.128 Y152.883 E.01431
M204 S10000
G1 X198.771 Y158.903 F60000
; LINE_WIDTH: 0.534881
G1 F12000
M204 S8000
G1 X199.173 Y159.477 E.02838
G1 X199.842 Y160.146 E.0383
G1 X200.679 Y160.751 E.04182
G1 X201.609 Y161.202 E.04185
G1 X202.603 Y161.484 E.04185
G2 X203.738 Y161.596 I2.298 J-17.534 E.04621
G1 X204.485 Y161.53 E.03036
G1 X203.62 Y161.095 E.03923
G1 X202.836 Y161.027 E.03187
G1 X201.918 Y160.792 E.03835
G1 X201.055 Y160.401 E.03838
G1 X200.273 Y159.867 E.03837
G1 X199.853 Y159.462 E.0236
G2 X198.824 Y158.93 I-12.1 J22.138 E.04691
M204 S10000
G1 X208.903 Y152.787 F60000
; LINE_WIDTH: 0.534883
G1 F12000
M204 S8000
G1 X208.376 Y152.003 E.03825
G1 X208.192 Y151.772 E.01195
G1 X207.598 Y151.179 E.034
G1 X206.761 Y150.573 E.04184
G1 X205.831 Y150.123 E.04185
G1 X204.836 Y149.84 E.04185
G2 X203.701 Y149.728 I-2.338 J17.93 E.04621
G1 X202.961 Y149.793 E.03008
G1 X203.829 Y150.23 E.03936
G1 X204.603 Y150.297 E.03147
G1 X205.521 Y150.532 E.03835
G1 X206.384 Y150.923 E.03838
G1 X207.167 Y151.457 E.03837
G3 X208.063 Y152.364 I-6.504 J7.332 E.05167
G1 X208.849 Y152.76 E.03563
M204 S10000
G1 X209.361 Y153.974 F60000
; FEATURE: Bridge
; LINE_WIDTH: 0.41185
; LAYER_HEIGHT: 0.4
G1 F3000
M204 S8000
G1 X201.966 Y150.248 E.45407
G2 X201.392 Y150.476 I.432 J1.92 E.03398
G1 X209.279 Y154.449 E.48423
G3 X209.368 Y155.012 I-2.376 J.665 E.03128
G1 X200.862 Y150.726 E.52223
G2 X200.431 Y151.026 I1.516 J2.64 E.02884
G1 X209.415 Y155.553 E.55162
G3 X209.39 Y156.057 I-1.708 J.168 E.0278
G1 X200.012 Y151.332 E.57584
G1 X199.668 Y151.676 E.02667
G1 X209.347 Y156.552 E.59429
G3 X209.241 Y157.016 I-1.638 J-.131 E.02617
G1 X199.329 Y152.023 E.60855
G1 X199.062 Y152.405 E.02559
G1 X209.119 Y157.472 E.61748
G3 X208.946 Y157.902 I-1.495 J-.35 E.02551
G1 X198.794 Y152.787 E.62333
G2 X198.595 Y153.204 I2.406 J1.408 E.02536
G1 X208.751 Y158.321 E.62358
G3 X208.517 Y158.72 I-1.398 J-.551 E.02548
G1 X198.399 Y153.623 E.6212
G2 X198.262 Y154.071 I1.469 J.696 E.02578
G1 X208.249 Y159.102 E.6132
G3 X207.951 Y159.469 I-1.328 J-.776 E.02603
G1 X198.14 Y154.526 E.60237
G2 X198.071 Y155.009 I1.54 J.464 E.02683
M73 P92 R1
G1 X207.607 Y159.813 E.58545
G3 X207.232 Y160.141 I-1.24 J-1.038 E.02743
G1 X198.028 Y155.504 E.5651
G2 X198.046 Y156.031 I1.708 J.204 E.029
G1 X206.802 Y160.442 E.5376
G3 X206.325 Y160.718 I-1.108 J-1.363 E.03039
G1 X198.094 Y156.572 E.50537
G2 X198.155 Y156.855 I1.075 J-.084 E.01595
G1 X198.237 Y157.161 E.01736
G1 X205.792 Y160.967 E.46384
G3 X205.47 Y161.077 I-.535 J-1.038 E.01869
G1 X202.187 Y159.423 E.20156
G1 X202.089 Y159.619 E.01201
G1 X198.155 Y157.637 E.24154
M106 S201.45
; WIPE_START
G1 X199.048 Y158.087 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z15.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z15.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 15
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 75/82
; update layer progress
M73 L75
M991 S0 P74 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 3
G1 X210.055 Y155.65 F60000
G1 Z15
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4884
M204 S8000
G1 X210.056 Y155.662 E.00041
G1 X209.96 Y156.762 E.03701
G1 X209.674 Y157.829 E.03701
G1 X209.207 Y158.83 E.03701
G1 X208.573 Y159.735 E.03701
G1 X207.792 Y160.516 E.03701
G1 X206.888 Y161.149 E.03701
G1 X205.887 Y161.616 E.03701
G1 X205.46 Y161.73 E.01479
G1 X204.82 Y161.902 E.02222
G1 X203.72 Y161.998 E.03701
G1 X202.619 Y161.902 E.03701
G1 X201.552 Y161.616 E.03701
G1 X200.551 Y161.149 E.03701
G1 X199.647 Y160.516 E.03701
G1 X198.866 Y159.735 E.03701
G1 X198.232 Y158.83 E.03701
G1 X197.765 Y157.829 E.03701
G1 X197.651 Y157.403 E.01479
G1 X197.48 Y156.762 E.02222
G1 X197.383 Y155.662 E.03701
G1 X197.48 Y154.562 E.03701
G1 X197.765 Y153.495 E.03701
G1 X198.232 Y152.494 E.03701
G1 X198.866 Y151.589 E.03701
G1 X199.647 Y150.808 E.03701
G1 X200.551 Y150.175 E.03701
G1 X201.552 Y149.708 E.03701
G1 X202.619 Y149.422 E.03701
G1 X203.72 Y149.326 E.03701
G1 X204.159 Y149.364 E.01479
G1 X204.82 Y149.422 E.02222
G1 X205.887 Y149.708 E.03701
G1 X206.888 Y150.175 E.03701
G1 X207.792 Y150.808 E.03701
G1 X208.573 Y151.589 E.03701
G1 X209.207 Y152.494 E.03701
G1 X209.674 Y153.495 E.03701
G1 X209.96 Y154.562 E.03701
G1 X210.05 Y155.59 E.03459
; COOLING_NODE: 3
M204 S10000
G1 X210.445 Y155.616 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4884
M204 S5000
G1 X210.449 Y155.662 E.00144
G1 X210.347 Y156.831 E.03641
G1 X210.044 Y157.964 E.03641
G1 X209.548 Y159.027 E.03641
G1 X208.875 Y159.988 E.03642
G1 X208.045 Y160.817 E.03641
G1 X207.084 Y161.49 E.03642
G1 X206.021 Y161.986 E.03641
G1 X205.562 Y162.109 E.01477
G1 X204.888 Y162.29 E.02165
G1 X203.72 Y162.392 E.03641
G1 X202.551 Y162.29 E.03641
G1 X201.418 Y161.986 E.03641
G1 X200.355 Y161.49 E.03641
G1 X199.394 Y160.817 E.03641
G1 X198.564 Y159.988 E.03641
G1 X197.891 Y159.027 E.03642
G1 X197.396 Y157.964 E.03641
G1 X197.272 Y157.504 E.01477
G1 X197.092 Y156.831 E.02165
G1 X196.99 Y155.662 E.03641
G1 X197.092 Y154.493 E.03641
G1 X197.396 Y153.36 E.03641
G1 X197.891 Y152.297 E.03641
G1 X198.564 Y151.336 E.03642
G1 X199.394 Y150.507 E.03641
G1 X200.355 Y149.834 E.03642
G1 X201.418 Y149.338 E.03641
G1 X202.551 Y149.034 E.03641
G1 X203.72 Y148.932 E.03641
G1 X204.194 Y148.974 E.01477
G1 X204.888 Y149.034 E.02164
G1 X206.021 Y149.338 E.03641
G1 X207.084 Y149.834 E.03641
G1 X208.045 Y150.507 E.03641
G1 X208.875 Y151.336 E.03641
G1 X209.548 Y152.297 E.03642
G1 X210.044 Y153.36 E.03641
G1 X210.347 Y154.493 E.03641
G1 X210.44 Y155.556 E.03311
M204 S10000
G1 X209.651 Y155.788 F60000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.41999
G1 F4884
M204 S8000
G1 X209.594 Y154.887 E.02802
G2 X209.304 Y153.63 I-7.576 J1.088 E.0401
G1 X208.866 Y152.691 E.03216
G1 X208.272 Y151.842 E.03215
G1 X207.539 Y151.11 E.03215
G1 X206.691 Y150.516 E.03215
G1 X205.752 Y150.078 E.03216
G1 X204.752 Y149.81 E.03215
G1 X203.72 Y149.719 E.03215
G1 X202.688 Y149.81 E.03215
G1 X201.687 Y150.078 E.03215
G1 X200.748 Y150.516 E.03216
G1 X199.9 Y151.11 E.03215
G1 X199.167 Y151.842 E.03215
G1 X198.573 Y152.691 E.03215
G1 X198.135 Y153.63 E.03216
G1 X197.867 Y154.63 E.03215
G1 X197.777 Y155.662 E.03216
G1 X197.867 Y156.694 E.03215
G1 X198.135 Y157.694 E.03215
G1 X198.573 Y158.633 E.03216
G1 X199.167 Y159.482 E.03215
G1 X199.9 Y160.214 E.03215
G1 X200.748 Y160.809 E.03215
G1 X201.687 Y161.246 E.03216
G1 X202.688 Y161.514 E.03215
G1 X203.72 Y161.605 E.03215
G1 X204.752 Y161.514 E.03215
G1 X205.752 Y161.246 E.03215
G1 X206.691 Y160.809 E.03216
G1 X207.539 Y160.214 E.03215
G1 X208.272 Y159.482 E.03215
G1 X208.866 Y158.633 E.03215
G1 X209.304 Y157.694 E.03216
G1 X209.572 Y156.694 E.03215
G1 X209.646 Y155.848 E.02637
M204 S10000
G1 X209.276 Y155.755 F60000
G1 F4884
M204 S8000
G1 X209.219 Y154.92 E.02599
G2 X208.948 Y153.759 I-7.089 J1.041 E.03703
G1 X208.538 Y152.88 E.03011
G1 X207.982 Y152.085 E.03011
G1 X207.296 Y151.4 E.03011
G1 X206.502 Y150.843 E.0301
G1 X205.623 Y150.433 E.03011
G1 X204.686 Y150.182 E.0301
G1 X203.72 Y150.098 E.03011
G1 X202.753 Y150.182 E.03011
G1 X201.817 Y150.433 E.0301
G1 X200.937 Y150.843 E.03011
G1 X200.143 Y151.4 E.03011
G1 X199.457 Y152.085 E.03011
G1 X198.901 Y152.88 E.03011
G1 X198.491 Y153.759 E.03011
G1 X198.24 Y154.696 E.0301
G1 X198.155 Y155.662 E.03011
G1 X198.24 Y156.628 E.03011
G1 X198.491 Y157.565 E.0301
G1 X198.901 Y158.444 E.03011
G1 X199.457 Y159.239 E.03011
G1 X200.143 Y159.924 E.03011
G1 X200.937 Y160.481 E.0301
G1 X201.817 Y160.891 E.03011
G1 X202.753 Y161.142 E.0301
G1 X203.72 Y161.226 E.03011
G1 X204.686 Y161.142 E.03011
G1 X205.623 Y160.891 E.0301
G1 X206.502 Y160.481 E.03011
G1 X207.296 Y159.924 E.0301
G1 X207.982 Y159.239 E.03011
G1 X208.538 Y158.444 E.03011
G1 X208.948 Y157.565 E.03011
G1 X209.199 Y156.628 E.0301
G1 X209.27 Y155.815 E.02535
M204 S10000
G1 X208.9 Y155.722 F60000
G1 F4884
M204 S8000
G1 X208.843 Y154.953 E.02395
G2 X208.593 Y153.889 I-6.548 J.981 E.03397
G1 X208.21 Y153.069 E.02806
G1 X207.692 Y152.329 E.02806
G1 X207.053 Y151.69 E.02806
G1 X206.312 Y151.171 E.02805
G1 X205.493 Y150.789 E.02806
G1 X204.62 Y150.555 E.02805
G1 X203.72 Y150.476 E.02806
G1 X202.819 Y150.555 E.02806
G1 X201.946 Y150.789 E.02805
G1 X201.127 Y151.171 E.02806
G1 X200.386 Y151.69 E.02806
G1 X199.747 Y152.329 E.02806
G1 X199.229 Y153.069 E.02806
G1 X198.847 Y153.889 E.02806
G1 X198.613 Y154.762 E.02805
G1 X198.534 Y155.662 E.02806
G1 X198.613 Y156.563 E.02806
G1 X198.847 Y157.436 E.02806
G1 X199.229 Y158.255 E.02806
G1 X199.747 Y158.995 E.02806
G1 X200.386 Y159.635 E.02806
G1 X201.127 Y160.153 E.02805
G1 X201.946 Y160.535 E.02806
G1 X202.819 Y160.769 E.02805
G1 X203.72 Y160.848 E.02806
G1 X204.62 Y160.769 E.02806
G1 X205.493 Y160.535 E.02806
G1 X206.312 Y160.153 E.02806
G1 X207.053 Y159.634 E.02806
G1 X207.692 Y158.995 E.02806
G1 X208.21 Y158.255 E.02806
G1 X208.593 Y157.436 E.02806
G1 X208.826 Y156.563 E.02805
G1 X208.895 Y155.782 E.02432
M204 S10000
G1 X207.895 Y153.428 F60000
; LINE_WIDTH: 0.541257
G1 F4884
M204 S8000
G1 X208.219 Y154.187 E.03386
G1 X208.407 Y154.991 E.03386
G1 X208.463 Y155.684 E.02853
G3 X208.354 Y156.634 I-11.108 J-.787 E.03926
G1 X208.115 Y157.424 E.03386
G1 X207.742 Y158.161 E.03387
M73 P92 R0
G1 X207.247 Y158.822 E.03386
G1 X206.645 Y159.386 E.03386
G1 X205.954 Y159.837 E.03387
G1 X205.195 Y160.162 E.03386
G1 X204.391 Y160.35 E.03386
G1 X203.611 Y160.393 E.03202
; Slow Down Start
; LINE_WIDTH: 0.541033
G1 F3000;_EXTRUDE_SET_SPEED
G1 X202.747 Y160.297 E.03565
G1 X201.957 Y160.057 E.03385
G1 X201.221 Y159.684 E.03385
G1 X200.56 Y159.19 E.03384
G1 X200.414 Y159.034 E.00876
; Slow Down End
; LINE_WIDTH: 0.540987
G1 F4884
G1 X199.996 Y158.587 E.02508
G1 X199.544 Y157.896 E.03386
G1 X199.22 Y157.137 E.03384
G1 X199.032 Y156.333 E.03385
G1 X198.987 Y155.509 E.03384
G1 X199.085 Y154.69 E.03384
G1 X199.324 Y153.9 E.03385
G1 X199.697 Y153.163 E.03385
G1 X200.192 Y152.503 E.03384
G1 X200.794 Y151.938 E.03384
G1 X201.486 Y151.487 E.03386
G1 X202.244 Y151.162 E.03384
G1 X203.052 Y150.974 E.03401
G1 X203.839 Y150.933 E.03229
; Slow Down Start
; LINE_WIDTH: 0.54096
G1 F3000;_EXTRUDE_SET_SPEED
G1 X204.692 Y151.027 E.03519
G1 X205.482 Y151.267 E.03384
G1 X206.219 Y151.64 E.03385
G1 X206.879 Y152.135 E.03384
G1 X207.455 Y152.755 E.03472
; Slow Down End
; LINE_WIDTH: 0.541015
G1 F4884
G1 X207.862 Y153.378 E.0305
M204 S10000
G1 X201.083 Y154.13 F60000
; LINE_WIDTH: 0.41999
G1 F4884
M204 S8000
G3 X203.167 Y152.663 I2.712 J1.64 E.08138
G1 X203.71 Y152.613 E.01693
G3 X201.056 Y154.183 I.01 J3.046 E.49366
M204 S10000
G1 X200.774 Y153.914 F60000
G1 F4884
M204 S8000
G1 X201.06 Y153.504 E.01552
G1 X201.474 Y153.076 E.01849
G1 X201.957 Y152.725 E.01854
G1 X202.494 Y152.463 E.01853
G1 X203.068 Y152.299 E.01854
G1 X203.677 Y152.237 E.019
G1 X204.259 Y152.279 E.0181
G1 X204.837 Y152.424 E.01849
G1 X205.382 Y152.667 E.01853
G1 X205.877 Y153.002 E.01854
G1 X206.306 Y153.417 E.01853
G1 X206.657 Y153.9 E.01853
G1 X206.918 Y154.437 E.01853
G1 X207.082 Y155.011 E.01854
G1 X207.144 Y155.604 E.01852
G1 X207.102 Y156.2 E.01853
G1 X206.957 Y156.779 E.01854
G1 X206.714 Y157.325 E.01853
G1 X206.38 Y157.819 E.01854
G1 X205.965 Y158.249 E.01853
G1 X205.482 Y158.599 E.01854
G1 X204.945 Y158.861 E.01853
G1 X204.371 Y159.025 E.01854
G1 X203.777 Y159.087 E.01852
G1 X203.182 Y159.045 E.01853
G1 X202.602 Y158.9 E.01854
G1 X202.057 Y158.657 E.01853
G1 X201.562 Y158.323 E.01854
G1 X201.133 Y157.908 E.01853
G1 X200.782 Y157.424 E.01854
G1 X200.521 Y156.887 E.01853
G1 X200.357 Y156.313 E.01854
G1 X200.295 Y155.72 E.01852
G1 X200.337 Y155.124 E.01853
G1 X200.482 Y154.545 E.01854
G1 X200.744 Y153.966 E.01972
M204 S10000
G1 X200.465 Y153.698 F60000
G1 F4884
M204 S8000
G1 X200.751 Y153.287 E.01555
G1 X201.207 Y152.81 E.0205
G1 X201.74 Y152.416 E.02057
G1 X202.334 Y152.122 E.02057
G1 X202.97 Y151.935 E.02057
G1 X203.644 Y151.861 E.02106
G1 X204.292 Y151.904 E.02014
G1 X204.934 Y152.06 E.0205
G1 X205.541 Y152.325 E.02057
G1 X206.092 Y152.692 E.02057
G1 X206.572 Y153.149 E.02056
G1 X206.965 Y153.683 E.02057
G1 X207.26 Y154.277 E.02057
G1 X207.446 Y154.912 E.02057
G1 X207.52 Y155.571 E.02056
G1 X207.478 Y156.232 E.02057
G1 X207.322 Y156.876 E.02057
G1 X207.056 Y157.483 E.02056
G1 X206.689 Y158.035 E.02057
G1 X206.232 Y158.515 E.02056
G1 X205.699 Y158.908 E.02057
G1 X205.105 Y159.202 E.02057
G1 X204.469 Y159.389 E.02057
G1 X203.811 Y159.462 E.02056
G1 X203.15 Y159.421 E.02057
G1 X202.506 Y159.264 E.02057
G1 X201.899 Y158.999 E.02056
G1 X201.347 Y158.632 E.02057
G1 X200.867 Y158.175 E.02056
G1 X200.474 Y157.641 E.02057
G1 X200.18 Y157.048 E.02057
G1 X199.993 Y156.412 E.02057
G1 X199.919 Y155.753 E.02056
G1 X199.961 Y155.092 E.02057
G1 X200.117 Y154.448 E.02057
G1 X200.435 Y153.75 E.02379
M204 S10000
G1 X200.105 Y153.448 F60000
; LINE_WIDTH: 0.540451
G1 F4884
M204 S8000
G1 X200.393 Y153.036 E.02056
G1 X200.897 Y152.501 E.03012
G1 X201.489 Y152.059 E.03026
G1 X202.148 Y151.726 E.03026
G1 X202.856 Y151.513 E.03026
G1 X203.606 Y151.426 E.03094
G1 X204.33 Y151.468 E.02969
G1 X205.046 Y151.637 E.03012
G1 X205.724 Y151.928 E.03025
G1 X206.342 Y152.333 E.03026
G1 X206.881 Y152.839 E.03025
G1 X207.323 Y153.431 E.03026
G1 X207.655 Y154.091 E.03026
G1 X207.868 Y154.798 E.03026
G1 X207.955 Y155.531 E.03024
G1 X207.914 Y156.269 E.03026
G1 X207.745 Y156.988 E.03026
G1 X207.453 Y157.667 E.03025
G1 X207.048 Y158.285 E.03026
G1 X206.542 Y158.823 E.03025
G1 X205.95 Y159.265 E.03026
G1 X205.291 Y159.598 E.03026
G1 X204.583 Y159.811 E.03026
G1 X203.85 Y159.898 E.03024
G1 X203.113 Y159.856 E.03026
G1 X202.393 Y159.687 E.03026
G1 X201.715 Y159.396 E.03025
G1 X201.097 Y158.991 E.03026
G1 X200.559 Y158.485 E.03025
G1 X200.116 Y157.893 E.03026
G1 X199.784 Y157.233 E.03026
G1 X199.571 Y156.526 E.03026
G1 X199.484 Y155.793 E.03024
G1 X199.525 Y155.055 E.03026
G1 X199.695 Y154.336 E.03026
G1 X199.986 Y153.657 E.03025
G1 X200.076 Y153.5 E.0074
M204 S10000
G1 X201.205 Y156.508 F60000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4884
M204 S8000
G2 X202.153 Y157.797 I2.564 J-.892 E.05443
G3 X203.695 Y155.662 I5.719 J2.505 E.08892
G2 X205.172 Y153.79 I-4.428 J-5.014 E.08034
G1 X205.266 Y153.513 E.00981
G3 X206.228 Y154.793 I-1.609 J2.209 E.05444
; WIPE_START
G1 F18423.913
G1 X206.021 Y154.333 E-.19153
G1 X205.755 Y153.954 E-.17605
G1 X205.731 Y153.932 E-.01242
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z15.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z15.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

M106 S255
; CHANGE_LAYER
; Z_HEIGHT: 15.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 76/82
; update layer progress
M73 L76
M991 S0 P75 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 4
G1 X209.626 Y155.649 F60000
G1 Z15.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F6630
M204 S8000
G1 X209.627 Y155.662 E.00042
G1 X209.537 Y156.688 E.03451
G1 X209.271 Y157.682 E.03451
G1 X208.835 Y158.616 E.03451
G1 X208.245 Y159.459 E.0345
G1 X207.517 Y160.187 E.03451
G1 X207.023 Y160.533 E.02022
G1 X206.673 Y160.778 E.01429
G1 X205.74 Y161.213 E.03451
G1 X204.745 Y161.48 E.03451
G1 X203.72 Y161.569 E.03451
G1 X202.694 Y161.48 E.03451
G1 X201.699 Y161.213 E.03451
G1 X200.766 Y160.778 E.03451
G1 X199.922 Y160.187 E.0345
G1 X199.194 Y159.459 E.03451
G1 X198.848 Y158.965 E.02022
G1 X198.604 Y158.616 E.01429
G1 X198.168 Y157.682 E.03451
G1 X197.902 Y156.688 E.03451
G1 X197.812 Y155.662 E.03451
G1 X197.902 Y154.636 E.03451
G1 X198.168 Y153.642 E.03451
G1 X198.604 Y152.708 E.03451
G1 X199.194 Y151.865 E.0345
G1 X199.922 Y151.137 E.03451
G1 X200.766 Y150.546 E.03451
G1 X201.699 Y150.111 E.03451
G1 X202.694 Y149.844 E.0345
G1 X203.72 Y149.755 E.03451
G1 X204.321 Y149.807 E.02022
G1 X204.745 Y149.844 E.01429
G1 X205.74 Y150.111 E.0345
G1 X206.673 Y150.546 E.03451
G1 X207.517 Y151.137 E.0345
G1 X208.245 Y151.865 E.03451
G1 X208.835 Y152.708 E.03451
G1 X209.271 Y153.642 E.03451
G1 X209.537 Y154.636 E.03451
G1 X209.621 Y155.59 E.03207
; COOLING_NODE: 4
M204 S10000
G1 X210.016 Y155.615 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6630
M204 S5000
G1 X210.02 Y155.662 E.00146
G1 X209.925 Y156.756 E.03409
G1 X209.64 Y157.817 E.03409
G1 X209.176 Y158.812 E.03409
G1 X208.546 Y159.712 E.03409
G1 X207.77 Y160.489 E.03409
G1 X207.247 Y160.855 E.01979
G1 X206.87 Y161.119 E.0143
G1 X205.875 Y161.583 E.03409
G1 X204.814 Y161.867 E.03409
G1 X203.72 Y161.963 E.03409
G1 X202.625 Y161.867 E.03409
G1 X201.565 Y161.583 E.03409
G1 X200.569 Y161.119 E.03409
G1 X199.669 Y160.489 E.03409
G1 X198.893 Y159.712 E.03409
G1 X198.527 Y159.19 E.01979
G1 X198.263 Y158.812 E.0143
G1 X197.799 Y157.817 E.03409
G1 X197.514 Y156.756 E.03409
G1 X197.419 Y155.662 E.03409
G1 X197.514 Y154.568 E.03409
G1 X197.799 Y153.507 E.03409
G1 X198.263 Y152.512 E.03409
G1 X198.893 Y151.612 E.03409
G1 X199.669 Y150.835 E.03409
G1 X200.569 Y150.205 E.03409
G1 X201.565 Y149.741 E.03409
G1 X202.625 Y149.457 E.03409
G1 X203.72 Y149.361 E.03409
G1 X204.355 Y149.417 E.01979
G1 X204.814 Y149.457 E.0143
G1 X205.875 Y149.741 E.03409
G1 X206.87 Y150.205 E.03409
G1 X207.77 Y150.835 E.03409
G1 X208.546 Y151.612 E.03409
G1 X209.176 Y152.512 E.03409
G1 X209.64 Y153.507 E.03409
G1 X209.925 Y154.568 E.03409
G1 X210.011 Y155.556 E.03077
; WIPE_START
G1 F12000
M204 S8000
G1 X210.02 Y155.662 E-.04063
G1 X209.943 Y156.552 E-.33937
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z15.6 I-.424 J-1.141 P1  F60000
G1 X203.052 Y159.111 Z15.6
G1 Z15.2
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41608
; LAYER_HEIGHT: 0.4
G1 F3000
M204 S8000
G1 X206.116 Y157.935 E.18367
G2 X206.273 Y157.77 I-.861 J-.984 E.01275
G2 X206.601 Y157.295 I-2.528 J-2.091 E.03238
G1 X206.627 Y157.239 E.00341
G1 X202.608 Y158.782 E.2409
G3 X202.025 Y158.506 I5.44 J-12.255 E.03607
G1 X206.874 Y156.645 E.29064
G2 X206.995 Y156.099 I-1.718 J-.668 E.03141
G1 X201.57 Y158.182 E.3252
G1 X201.209 Y157.821 E.02855
G1 X207.027 Y155.588 E.34874
G2 X206.984 Y155.105 I-2.786 J.004 E.02716
M73 P93 R0
G1 X200.927 Y157.43 E.36308
G3 X200.708 Y157.015 I1.258 J-.931 E.02637
G1 X206.866 Y154.651 E.36918
G2 X206.69 Y154.22 I-1.521 J.372 E.02619
G1 X200.547 Y156.577 E.36822
G3 X200.445 Y156.117 I1.485 J-.569 E.02647
G1 X206.454 Y153.811 E.36017
G2 X206.153 Y153.427 I-1.403 J.788 E.02739
G1 X200.408 Y155.632 E.3444
G1 X200.453 Y155.116 E.02902
G1 X205.777 Y153.072 E.31912
G2 X205.352 Y152.781 I-1.862 J2.257 E.02888
G1 X205.3 Y152.756 E.00322
G1 X200.598 Y154.554 E.28169
G3 X200.888 Y153.95 I8.751 J3.821 E.03749
G1 X204.67 Y152.499 E.2267
G2 X203.909 Y152.365 I-.789 J2.251 E.04341
G1 X203.754 Y152.351 E.00872
G1 X201.035 Y153.395 E.16302
M106 S201.45
M204 S10000
G1 X201.803 Y152.648 F60000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
; LAYER_HEIGHT: 0.2
G1 F6630
M204 S8000
G1 X203.636 Y151.945 E.06094
G1 X204.388 Y151.998 E.02339
G1 X205.014 Y152.17 E.02016
G1 X205.601 Y152.447 E.02014
G1 X206.131 Y152.823 E.02017
G1 X206.587 Y153.285 E.02014
G1 X206.956 Y153.819 E.02016
G1 X207.227 Y154.409 E.02015
G1 X207.391 Y155.037 E.02015
G1 X207.444 Y155.684 E.02015
G1 X207.384 Y156.33 E.02015
G1 X207.212 Y156.957 E.02016
G1 X206.934 Y157.543 E.02014
G1 X206.607 Y158.016 E.01786
G1 X206.295 Y158.318 E.01347
G1 X203.579 Y159.36 E.09028
G1 X203.051 Y159.326 E.01644
G3 X202.417 Y159.152 I2.993 J-12.132 E.02039
G1 X201.839 Y158.877 E.01989
G1 X201.309 Y158.501 E.02017
G1 X200.852 Y158.04 E.02015
G1 X200.483 Y157.505 E.02016
G1 X200.212 Y156.916 E.02015
G1 X200.048 Y156.287 E.02016
G1 X199.995 Y155.64 E.02015
G1 X200.055 Y154.994 E.02015
G1 X200.227 Y154.368 E.02016
G1 X200.505 Y153.781 E.02014
G1 X200.833 Y153.308 E.01786
G1 X201.248 Y152.88 E.01854
G1 X201.748 Y152.671 E.01679
M204 S10000
G1 X209.169 Y154.923 F60000
G1 F6630
M204 S8000
G1 X209.117 Y154.584 E.01066
G1 X208.901 Y153.776 E.02595
G1 X208.495 Y152.905 E.02984
G1 X207.943 Y152.118 E.02983
G1 X207.264 Y151.438 E.02983
G1 X206.476 Y150.887 E.02983
G1 X205.605 Y150.481 E.02984
G1 X204.677 Y150.232 E.02983
G1 X203.72 Y150.148 E.02983
G1 X202.762 Y150.232 E.02983
G1 X201.834 Y150.481 E.02983
G1 X200.963 Y150.887 E.02984
G1 X200.175 Y151.438 E.02983
G1 X199.496 Y152.118 E.02983
G1 X198.945 Y152.905 E.02983
G1 X198.538 Y153.776 E.02984
G1 X198.29 Y154.705 E.02983
G1 X198.206 Y155.662 E.02983
G1 X198.29 Y156.62 E.02983
G1 X198.538 Y157.548 E.02983
G1 X198.945 Y158.419 E.02984
G1 X199.496 Y159.206 E.02983
G1 X200.175 Y159.886 E.02983
G1 X200.963 Y160.437 E.02983
G1 X201.834 Y160.843 E.02984
G1 X202.762 Y161.092 E.02983
G1 X203.72 Y161.176 E.02983
G1 X204.677 Y161.092 E.02983
G1 X205.605 Y160.843 E.02983
G1 X206.476 Y160.437 E.02984
G1 X207.264 Y159.886 E.02983
G1 X207.943 Y159.206 E.02983
G1 X208.495 Y158.419 E.02983
G1 X208.901 Y157.548 E.02984
G1 X209.15 Y156.62 E.02983
G1 X209.227 Y155.74 E.02741
G1 X209.173 Y154.983 E.02355
M204 S10000
G1 X208.793 Y154.956 F60000
G1 F6630
M204 S8000
G1 X208.753 Y154.681 E.00862
G1 X208.545 Y153.906 E.02492
G1 X208.167 Y153.094 E.02779
G1 X207.653 Y152.361 E.02778
G1 X207.02 Y151.728 E.02779
G1 X206.287 Y151.215 E.02778
G1 X205.476 Y150.836 E.02779
G1 X204.611 Y150.605 E.02778
G1 X203.72 Y150.527 E.02779
G1 X202.828 Y150.605 E.02779
G1 X201.963 Y150.836 E.02778
G1 X201.152 Y151.215 E.02779
G1 X200.419 Y151.728 E.02778
G1 X199.786 Y152.361 E.02779
G1 X199.272 Y153.094 E.02778
G1 X198.894 Y153.906 E.02779
G1 X198.662 Y154.77 E.02778
G1 X198.584 Y155.662 E.02779
G1 X198.662 Y156.554 E.02779
G1 X198.894 Y157.418 E.02778
G1 X199.272 Y158.23 E.02779
G1 X199.786 Y158.963 E.02779
G1 X200.419 Y159.596 E.02779
G1 X201.152 Y160.109 E.02778
G1 X201.963 Y160.488 E.02779
G1 X202.828 Y160.719 E.02778
G1 X203.72 Y160.797 E.02779
G1 X204.611 Y160.719 E.02779
G1 X205.476 Y160.488 E.02778
G1 X206.287 Y160.109 E.02779
G1 X207.02 Y159.596 E.02779
G1 X207.653 Y158.963 E.02779
G1 X208.167 Y158.23 E.02778
G1 X208.545 Y157.418 E.02779
G1 X208.777 Y156.554 E.02778
G1 X208.851 Y155.707 E.02639
G1 X208.798 Y155.016 E.02151
M204 S10000
G1 X205.729 Y158.939 F60000
G1 F6630
M204 S8000
G1 X203.714 Y159.712 E.06697
G1 X203.454 Y159.746 E.00814
G1 X202.923 Y159.685 E.01659
G3 X202.3 Y159.511 I3.679 J-14.348 E.02009
G1 X201.676 Y159.217 E.02142
G1 X201.089 Y158.808 E.0222
G1 X200.583 Y158.303 E.02218
G1 X200.172 Y157.719 E.02219
G1 X199.869 Y157.071 E.02218
G1 X199.683 Y156.381 E.02219
G1 X199.619 Y155.669 E.02219
G1 X199.68 Y154.957 E.02218
G1 X199.864 Y154.266 E.02219
G1 X200.165 Y153.618 E.02217
G1 X200.524 Y153.092 E.01978
G1 X200.979 Y152.616 E.02045
G1 X201.181 Y152.483 E.00749
G1 X203.501 Y151.593 E.07715
G1 X203.758 Y151.558 E.00806
G1 X204.424 Y151.622 E.02076
G1 X205.115 Y151.806 E.02221
G1 X205.763 Y152.107 E.02217
G1 X206.35 Y152.516 E.0222
G1 X206.856 Y153.021 E.02218
G1 X207.267 Y153.606 E.02219
G1 X207.57 Y154.253 E.02219
G1 X207.757 Y154.943 E.02218
G1 X207.82 Y155.655 E.02219
G1 X207.759 Y156.367 E.02218
G1 X207.575 Y157.058 E.0222
G1 X207.275 Y157.706 E.02217
G1 X206.915 Y158.232 E.01978
G1 X206.552 Y158.605 E.01616
G1 X205.784 Y158.916 E.02572
M204 S10000
G1 X205.156 Y159.622 F60000
; LINE_WIDTH: 0.51045
G1 F6630
M204 S8000
G1 X204.42 Y159.882 E.03004
; LINE_WIDTH: 0.469005
G1 X204.134 Y159.97 E.01051
; LINE_WIDTH: 0.426995
G1 X203.847 Y160.057 E.00948
; LINE_WIDTH: 0.369847
G1 X203.432 Y160.096 E.01122
G3 X202.229 Y159.857 I.199 J-4.137 E.03313
G1 X201.524 Y159.534 E.02087
G1 X200.884 Y159.094 E.0209
G1 X200.332 Y158.55 E.02087
G1 X199.882 Y157.917 E.02089
G1 X199.548 Y157.217 E.02088
G1 X199.342 Y156.469 E.02089
G1 X199.268 Y155.696 E.02088
G1 X199.33 Y154.923 E.02088
G1 X199.525 Y154.172 E.02089
G1 X199.847 Y153.466 E.02087
G1 X200.237 Y152.891 E.0187
G1 X200.728 Y152.371 E.01926
G1 X201.051 Y152.145 E.01059
; LINE_WIDTH: 0.406138
G1 X201.289 Y152.037 E.00782
; LINE_WIDTH: 0.438193
G1 X201.527 Y151.928 E.00851
; LINE_WIDTH: 0.464526
G3 X203.001 Y151.37 I7.132 J16.604 E.05474
; LINE_WIDTH: 0.42152
G1 X203.312 Y151.289 E.01002
; LINE_WIDTH: 0.370118
G1 X203.624 Y151.209 E.00866
G1 X204.458 Y151.272 E.02253
G1 X205.21 Y151.468 E.02093
G1 X205.915 Y151.79 E.02089
G1 X206.555 Y152.23 E.02091
G1 X207.107 Y152.775 E.02089
G1 X207.557 Y153.407 E.0209
G1 X207.891 Y154.108 E.0209
G1 X208.097 Y154.855 E.02089
G1 X208.171 Y155.628 E.0209
G1 X208.109 Y156.401 E.0209
G1 X207.914 Y157.153 E.02091
G1 X207.592 Y157.858 E.02088
G1 X207.202 Y158.433 E.01871
G1 X206.755 Y158.895 E.01731
G1 X206.563 Y159.018 E.00614
; LINE_WIDTH: 0.434495
G1 X206.221 Y159.174 E.01213
; LINE_WIDTH: 0.480605
G1 X205.879 Y159.33 E.01355
; LINE_WIDTH: 0.517275
G1 X205.212 Y159.599 E.02809
M204 S10000
G1 X205.307 Y160.085 F60000
G1 F6630
M204 S8000
G1 X206.059 Y159.754 E.03209
; LINE_WIDTH: 0.480605
G1 X206.397 Y159.547 E.01428
; LINE_WIDTH: 0.434495
G1 X206.735 Y159.341 E.01277
; LINE_WIDTH: 0.367803
G2 X207.779 Y158.172 I-3.117 J-3.837 E.04209
G1 X208.149 Y157.44 E.02195
G1 X208.39 Y156.643 E.02225
G2 X208.5 Y155.676 I-10.341 J-1.664 E.02603
G1 X208.444 Y154.987 E.0185
G1 X208.255 Y154.177 E.02225
G1 X207.928 Y153.412 E.02224
G1 X207.474 Y152.715 E.02226
G1 X206.905 Y152.108 E.02224
G1 X206.239 Y151.609 E.02226
G1 X205.497 Y151.233 E.02224
G1 X204.701 Y150.991 E.02225
G1 X203.822 Y150.887 E.02367
G1 X203.295 Y150.925 E.01411
; LINE_WIDTH: 0.399678
G1 X203.087 Y150.959 E.0062
; LINE_WIDTH: 0.426833
G1 X202.879 Y150.992 E.00667
; LINE_WIDTH: 0.464607
G1 X202.122 Y151.216 E.02739
G1 X201.366 Y151.55 E.02868
; LINE_WIDTH: 0.438193
G1 X201.128 Y151.695 E.00909
; LINE_WIDTH: 0.406138
G1 X200.889 Y151.841 E.00835
; LINE_WIDTH: 0.367264
G2 X199.66 Y153.152 I2.708 J3.771 E.04829
G1 X199.29 Y153.885 E.02191
G1 X199.049 Y154.681 E.02221
G1 X198.949 Y155.507 E.02221
G1 X198.995 Y156.337 E.02221
G1 X199.184 Y157.148 E.02222
G1 X199.511 Y157.912 E.0222
G1 X199.966 Y158.609 E.02222
G1 X200.534 Y159.216 E.02221
G1 X201.2 Y159.716 E.02222
G1 X201.942 Y160.091 E.02221
G1 X202.738 Y160.333 E.02221
G2 X203.735 Y160.434 I1.136 J-6.232 E.02676
; LINE_WIDTH: 0.404394
G1 X203.996 Y160.394 E.00788
; LINE_WIDTH: 0.43864
G1 X204.258 Y160.354 E.00863
; LINE_WIDTH: 0.472887
G1 X204.52 Y160.314 E.00938
; LINE_WIDTH: 0.51045
G1 X205.249 Y160.102 E.02922
; WIPE_START
G1 F15000
G1 X204.52 Y160.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z15.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z15.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 15.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 77/82
; update layer progress
M73 L77
M991 S0 P76 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 5
G1 X209.197 Y155.65 F60000
G1 Z15.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4676
M204 S8000
G1 X209.198 Y155.662 E.0004
G1 X209.115 Y156.613 E.032
G1 X208.868 Y157.536 E.032
G1 X208.464 Y158.401 E.032
G1 X207.916 Y159.183 E.032
G1 X207.241 Y159.859 E.032
G1 X206.459 Y160.407 E.032
G1 X205.593 Y160.81 E.032
G1 X204.854 Y161.008 E.02564
G1 X204.671 Y161.057 E.00636
G1 X203.72 Y161.14 E.032
G1 X202.768 Y161.057 E.032
G1 X201.846 Y160.81 E.032
G1 X200.98 Y160.406 E.032
G1 X200.198 Y159.859 E.032
G1 X199.523 Y159.184 E.032
G1 X198.975 Y158.401 E.032
G1 X198.572 Y157.536 E.032
G1 X198.373 Y156.797 E.02564
G1 X198.324 Y156.613 E.00636
G1 X198.241 Y155.662 E.032
G1 X198.324 Y154.711 E.032
G1 X198.572 Y153.788 E.032
G1 X198.975 Y152.923 E.032
G1 X199.523 Y152.141 E.032
G1 X200.198 Y151.465 E.032
G1 X200.98 Y150.918 E.032
G1 X201.846 Y150.514 E.032
G1 X202.768 Y150.267 E.032
G1 X203.72 Y150.184 E.032
G1 X204.482 Y150.25 E.02564
G1 X204.671 Y150.267 E.00636
G1 X205.593 Y150.514 E.032
G1 X206.459 Y150.918 E.032
G1 X207.241 Y151.465 E.032
G1 X207.916 Y152.141 E.032
G1 X208.464 Y152.923 E.032
G1 X208.868 Y153.788 E.032
G1 X209.066 Y154.527 E.02564
G1 X209.115 Y154.711 E.00636
G1 X209.192 Y155.59 E.02959
; COOLING_NODE: 5
M204 S10000
G1 X209.588 Y155.616 F60000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4676
M204 S5000
G1 X209.592 Y155.662 E.00144
G1 X209.502 Y156.682 E.03177
G1 X209.237 Y157.67 E.03177
G1 X208.805 Y158.598 E.03177
G1 X208.218 Y159.436 E.03177
G1 X207.494 Y160.16 E.03177
G1 X206.656 Y160.747 E.03177
G1 X205.728 Y161.18 E.03177
G1 X204.956 Y161.387 E.02482
G1 X204.739 Y161.445 E.00696
G1 X203.72 Y161.534 E.03177
G1 X202.7 Y161.445 E.03177
G1 X201.711 Y161.18 E.03177
G1 X200.784 Y160.747 E.03177
G1 X199.945 Y160.16 E.03177
G1 X199.221 Y159.437 E.03177
G1 X198.634 Y158.598 E.03177
G1 X198.202 Y157.67 E.03177
G1 X197.995 Y156.898 E.02482
G1 X197.937 Y156.682 E.00696
G1 X197.848 Y155.662 E.03177
G1 X197.937 Y154.642 E.03177
G1 X198.202 Y153.654 E.03177
G1 X198.634 Y152.726 E.03177
G1 X199.221 Y151.888 E.03177
G1 X199.945 Y151.164 E.03177
G1 X200.784 Y150.577 E.03177
G1 X201.711 Y150.144 E.03177
G1 X202.7 Y149.879 E.03177
G1 X203.72 Y149.79 E.03177
G1 X204.516 Y149.86 E.02482
G1 X204.739 Y149.879 E.00696
G1 X205.728 Y150.144 E.03177
G1 X206.656 Y150.577 E.03177
G1 X207.494 Y151.164 E.03177
G1 X208.218 Y151.888 E.03177
G1 X208.805 Y152.726 E.03177
G1 X209.237 Y153.654 E.03177
G1 X209.444 Y154.426 E.02482
G1 X209.502 Y154.642 E.00696
G1 X209.582 Y155.556 E.02847
; WIPE_START
G1 F12000
M204 S8000
G1 X209.592 Y155.662 E-.04041
G1 X209.514 Y156.552 E-.33959
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z15.8 I1.154 J-.387 P1  F60000
G1 X208.334 Y153.032 Z15.8
G1 Z15.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.4224
G1 F4676
M204 S8000
G1 X207.02 Y151.717 E.05806
G1 X206.292 Y151.207 E.02778
G1 X205.695 Y150.929 E.02055
G1 X208.452 Y153.686 E.1218
G1 X208.553 Y153.903 E.00746
G1 X208.707 Y154.478 E.01861
G1 X204.903 Y150.674 E.16805
G2 X204.258 Y150.565 I-.715 J2.272 E.02052
G1 X208.816 Y155.124 E.20138
G1 X208.86 Y155.704 E.01817
G1 X203.678 Y150.522 E.22893
G1 X203.184 Y150.565 E.01547
G1 X208.817 Y156.197 E.24882
G3 X208.754 Y156.672 I-1.376 J.06 E.01502
G1 X202.71 Y150.627 E.26701
G1 X202.287 Y150.741 E.01369
G1 X208.641 Y157.095 E.2807
G3 X208.514 Y157.505 I-1.227 J-.154 E.01348
G1 X201.877 Y150.867 E.29323
G1 X201.511 Y151.038 E.01262
G1 X208.344 Y157.871 E.30186
G1 X208.173 Y158.237 E.01261
G1 X201.145 Y151.209 E.31046
G1 X200.829 Y151.43 E.01204
G1 X207.952 Y158.552 E.31464
G1 X207.731 Y158.868 E.01204
G1 X200.514 Y151.651 E.31882
G2 X200.23 Y151.904 I.576 J.93 E.01193
G1 X207.477 Y159.151 E.32015
G1 X207.209 Y159.42 E.01185
G1 X199.962 Y152.173 E.32015
G2 X199.709 Y152.456 I.677 J.86 E.01193
G1 X206.926 Y159.673 E.31882
G1 X206.61 Y159.894 E.01204
G1 X199.488 Y152.772 E.31464
G1 X199.267 Y153.087 E.01204
G1 X206.294 Y160.115 E.31046
G1 X205.929 Y160.286 E.01261
G1 X199.096 Y153.453 E.30187
G1 X198.925 Y153.819 E.01262
G1 X205.563 Y160.457 E.29324
G3 X205.153 Y160.583 I-.564 J-1.1 E.01348
G1 X198.798 Y154.229 E.28071
G1 X198.685 Y154.652 E.01369
G1 X204.729 Y160.697 E.26702
G3 X204.255 Y160.759 I-.414 J-1.314 E.01502
G1 X198.623 Y155.127 E.24883
G1 X198.579 Y155.62 E.01547
G1 X203.762 Y160.802 E.22894
M73 P94 R0
G1 X203.182 Y160.759 E.01817
G1 X198.623 Y156.2 E.2014
G2 X198.732 Y156.846 I2.304 J-.057 E.02052
G1 X202.536 Y160.65 E.16807
G1 X201.96 Y160.496 E.01862
G1 X201.744 Y160.395 E.00744
G1 X198.987 Y157.637 E.12183
G1 X199.265 Y158.234 E.02057
G1 X199.774 Y158.962 E.02775
G1 X201.09 Y160.277 E.05811
; WIPE_START
G1 F15000
G1 X200.383 Y159.57 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z15.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z15.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 15.6
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 78/82
; update layer progress
M73 L78
M991 S0 P77 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 6
G1 X207.553 Y155.662 F60000
G1 Z15.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F4959
M204 S8000
G1 X207.495 Y156.328 E.02239
G1 X207.322 Y156.973 E.02239
G1 X207.039 Y157.579 E.02239
G1 X206.656 Y158.126 E.02239
G1 X206.184 Y158.599 E.02239
G1 X205.636 Y158.982 E.02239
G1 X204.995 Y159.274 E.02361
G1 X204.385 Y159.437 E.02116
G1 X203.72 Y159.495 E.02239
G1 X203.054 Y159.437 E.02239
G1 X202.408 Y159.264 E.02239
G1 X201.803 Y158.982 E.02239
G1 X201.256 Y158.599 E.02239
G1 X200.783 Y158.126 E.02239
G1 X200.4 Y157.579 E.02239
G1 X200.108 Y156.938 E.02361
G1 X199.944 Y156.328 E.02116
G1 X199.886 Y155.662 E.02239
G1 X199.954 Y154.961 E.0236
G1 X200.117 Y154.351 E.02117
G1 X200.4 Y153.745 E.02239
G1 X200.783 Y153.198 E.02239
G1 X201.255 Y152.725 E.02239
G1 X201.803 Y152.342 E.02239
G1 X202.408 Y152.06 E.02239
G1 X203.054 Y151.887 E.0224
G1 X203.756 Y151.832 E.0236
G1 X204.385 Y151.887 E.02117
G1 X205.031 Y152.06 E.02239
G1 X205.636 Y152.342 E.02239
G1 X206.184 Y152.725 E.02239
G1 X206.656 Y153.198 E.02239
G1 X207.039 Y153.745 E.02239
G1 X207.322 Y154.351 E.02239
G1 X207.495 Y154.996 E.0224
G1 X207.548 Y155.602 E.02038
; COOLING_NODE: 6
; WIPE_START
G1 F18000
G1 X207.495 Y156.328 E-.27638
G1 X207.424 Y156.591 E-.10362
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I.595 J1.061 P1  F60000
G1 X209.159 Y155.618 Z16
G1 Z15.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F4959
M204 S5000
G1 X209.163 Y155.662 E.00138
G1 X209.08 Y156.607 E.02945
G1 X208.834 Y157.524 E.02945
G1 X208.433 Y158.384 E.02945
G1 X207.889 Y159.161 E.02945
G1 X207.218 Y159.832 E.02945
G1 X206.441 Y160.376 E.02945
G1 X205.581 Y160.777 E.02945
G1 X204.665 Y161.022 E.02945
G1 X203.72 Y161.105 E.02945
G1 X202.774 Y161.022 E.02945
G1 X201.858 Y160.777 E.02945
G1 X200.998 Y160.376 E.02945
G1 X200.221 Y159.832 E.02945
G1 X199.55 Y159.161 E.02945
G1 X199.009 Y158.388 E.02928
G1 X198.605 Y157.524 E.02963
G1 X198.359 Y156.607 E.02945
G1 X198.276 Y155.662 E.02945
G1 X198.359 Y154.717 E.02945
G1 X198.605 Y153.8 E.02945
G1 X199.006 Y152.941 E.02945
G1 X199.55 Y152.163 E.02945
G1 X200.221 Y151.492 E.02945
G1 X200.998 Y150.948 E.02945
G1 X201.858 Y150.547 E.02945
G1 X202.774 Y150.302 E.02945
G1 X203.72 Y150.219 E.02945
G1 X204.659 Y150.301 E.02927
G1 X205.581 Y150.547 E.02963
G1 X206.441 Y150.948 E.02945
G1 X207.218 Y151.492 E.02945
G1 X207.889 Y152.163 E.02945
G1 X208.433 Y152.941 E.02945
G1 X208.834 Y153.8 E.02945
G1 X209.08 Y154.717 E.02945
G1 X209.154 Y155.558 E.02621
; WIPE_START
G1 F12000
M204 S8000
G1 X209.163 Y155.662 E-.03968
G1 X209.085 Y156.554 E-.34032
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I-.655 J-1.026 P1  F60000
G1 X205.39 Y158.915 Z16
G1 Z15.6
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42966
G1 F4959
M204 S8000
G1 X206.416 Y157.888 E.04622
G1 X206.75 Y157.412 E.01852
G1 X207.007 Y156.859 E.01942
G1 X207.047 Y156.71 E.00491
G1 X204.767 Y158.99 E.10266
G1 X204.327 Y159.108 E.01451
G1 X204.081 Y159.129 E.00787
G1 X207.187 Y156.023 E.13984
G2 X207.201 Y155.462 I-1.584 J-.321 E.01796
G1 X203.52 Y159.143 E.16574
G1 X203.112 Y159.108 E.01303
G1 X203.03 Y159.086 E.00269
G1 X207.143 Y154.973 E.18518
G1 X207.028 Y154.542 E.01422
G1 X202.599 Y158.97 E.1994
G1 X202.216 Y158.807 E.01327
G1 X206.864 Y154.158 E.20929
G2 X206.673 Y153.803 I-1.103 J.365 E.01292
G1 X201.86 Y158.615 E.21667
G1 X201.539 Y158.39 E.0125
G1 X206.448 Y153.481 E.22102
G2 X206.184 Y153.197 I-.936 J.605 E.01238
G1 X201.255 Y158.127 E.22193
G3 X200.992 Y157.843 I.673 J-.888 E.01238
G1 X205.901 Y152.934 E.22102
G1 X205.579 Y152.709 E.0125
G1 X200.766 Y157.521 E.21667
G3 X200.577 Y157.164 I.868 J-.689 E.01295
G1 X205.223 Y152.517 E.2092
G1 X204.84 Y152.354 E.01327
G1 X200.411 Y156.783 E.1994
G1 X200.296 Y156.351 E.01422
G1 X204.409 Y152.238 E.18518
G1 X204.327 Y152.216 E.00269
G1 X203.919 Y152.181 E.01303
G1 X200.238 Y155.862 E.16574
G3 X200.256 Y155.297 I1.531 J-.234 E.0181
G1 X203.356 Y152.197 E.13954
G1 X203.111 Y152.217 E.00783
G1 X202.672 Y152.334 E.01446
G1 X200.392 Y154.614 E.10266
G1 X200.432 Y154.465 E.00491
G1 X200.689 Y153.913 E.01942
G1 X201.023 Y153.436 E.0185
G1 X202.053 Y152.406 E.0464
; WIPE_START
G1 F15000
G1 X201.346 Y153.113 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I-1.067 J.585 P1  F60000
G1 X205.45 Y160.597 Z16
G1 Z15.6
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F4959
M204 S2000
G1 X208.655 Y157.392 E.14069
G1 X208.85 Y156.664
G1 X204.721 Y160.793 E.18124
; WIPE_START
G1 F12000
M204 S8000
G1 X205.429 Y160.085 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I1.093 J.535 P1  F60000
G1 X205.94 Y159.041 Z16
G1 Z15.6
G1 E.4 F1800
G1 F4959
M204 S2000
G1 X204.119 Y160.862 E.07994
G1 X203.564 Y160.883
G1 X204.924 Y159.523 E.05971
G1 X204.241 Y159.673
G1 X203.074 Y160.84 E.05124
G1 X202.616 Y160.765
G1 X203.667 Y159.714 E.04614
G1 X203.176 Y159.671
G1 X202.195 Y160.653 E.04308
G1 X201.795 Y160.519
G1 X202.733 Y159.582 E.04115
G1 X202.315 Y159.466
G1 X201.432 Y160.349 E.03877
G1 X201.073 Y160.175
G1 X201.951 Y159.297 E.03856
G1 X201.602 Y159.113
G1 X200.759 Y159.956 E.03699
G1 X200.446 Y159.736
G1 X201.288 Y158.893 E.03699
G1 X200.995 Y158.653
G1 X200.165 Y159.483 E.03643
G1 X199.899 Y159.216
G1 X200.729 Y158.386 E.03643
G1 X200.488 Y158.093
G1 X199.646 Y158.936 E.03699
G1 X199.426 Y158.622
G1 X200.269 Y157.78 E.03699
G1 X200.085 Y157.43
G1 X199.206 Y158.309 E.03857
G1 X199.033 Y157.949
G1 X199.915 Y157.066 E.03875
G1 X199.8 Y156.649
G1 X198.863 Y157.586 E.04114
G1 X198.729 Y157.186
G1 X199.71 Y156.205 E.04308
G1 X199.667 Y155.715
G1 X198.616 Y156.766 E.04614
G1 X198.541 Y156.308
G1 X199.708 Y155.14 E.05124
G1 X199.859 Y154.457
G1 X198.498 Y155.817 E.05972
G1 X198.52 Y155.263
G1 X200.341 Y153.442 E.07995
; WIPE_START
G1 F12000
M204 S8000
G1 X199.634 Y154.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I-.544 J1.088 P1  F60000
G1 X207.099 Y157.882 Z16
G1 Z15.6
G1 E.4 F1800
G1 F4959
M204 S2000
G1 X208.92 Y156.061 E.07994
G1 X208.941 Y155.507
G1 X207.581 Y156.867 E.05971
G1 X207.731 Y156.184
G1 X208.898 Y155.016 E.05124
G1 X208.823 Y154.558
G1 X207.772 Y155.609 E.04614
G1 X207.729 Y155.119
G1 X208.71 Y154.138 E.04308
G1 X208.576 Y153.738
G1 X207.639 Y154.675 E.04115
G1 X207.524 Y154.257
G1 X208.407 Y153.374 E.03877
G1 X208.233 Y153.015
G1 X207.354 Y153.894 E.03856
G1 X207.17 Y153.544
G1 X208.013 Y152.702 E.03699
G1 X207.793 Y152.388
G1 X206.951 Y153.231 E.03699
G1 X206.71 Y152.938
G1 X207.54 Y152.108 E.03643
G1 X207.274 Y151.841
G1 X206.444 Y152.671 E.03643
G1 X206.151 Y152.431
G1 X206.994 Y151.588 E.03699
G1 X206.68 Y151.369
G1 X205.837 Y152.211 E.03699
G1 X205.488 Y152.027
G1 X206.366 Y151.149 E.03857
G1 X206.007 Y150.975
G1 X205.124 Y151.858 E.03877
G1 X204.706 Y151.743
G1 X205.644 Y150.805 E.04115
G1 X205.244 Y150.672
G1 X204.263 Y151.653 E.04307
G1 X203.772 Y151.61
G1 X204.823 Y150.559 E.04611
G1 X204.365 Y150.484
G1 X203.198 Y151.651 E.05124
G1 X202.515 Y151.801
G1 X203.875 Y150.441 E.05972
G1 X203.32 Y150.462
G1 X201.499 Y152.283 E.07995
; WIPE_START
G1 F12000
M204 S8000
G1 X202.206 Y151.576 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I1.093 J.535 P1  F60000
G1 X202.718 Y150.532 Z16
G1 Z15.6
G1 E.4 F1800
G1 F4959
M204 S2000
G1 X198.589 Y154.66 E.18123
G1 X198.784 Y153.932
G1 X201.989 Y150.727 E.14068
; WIPE_START
G1 F12000
M204 S8000
G1 X201.282 Y151.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I-.675 J1.013 P1  F60000
G1 X207.844 Y155.804 Z16
G1 Z15.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0986332
G1 F4959
M204 S8000
G1 X207.757 Y155.595 E.00104
; WIPE_START
G1 F15000
G1 X207.844 Y155.804 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I-1.174 J.321 P1  F60000
G1 X208.421 Y157.919 Z16
M73 P95 R0
G1 Z15.6
G1 E.4 F1800
; LINE_WIDTH: 0.109885
G1 F4959
M204 S8000
G1 X208.345 Y158.028 E.00073
; LINE_WIDTH: 0.153301
G1 X208.269 Y158.136 E.0012
; LINE_WIDTH: 0.196716
G1 X208.193 Y158.245 E.00168
; LINE_WIDTH: 0.237957
G1 X208.049 Y158.417 E.0036
; LINE_WIDTH: 0.277049
G1 X207.905 Y158.588 E.00432
; LINE_WIDTH: 0.316141
G1 X207.761 Y158.76 E.00504
; LINE_WIDTH: 0.37084
G1 X207.617 Y158.932 E.00605
G1 X206.99 Y159.559 E.02394
; LINE_WIDTH: 0.355248
G1 X206.818 Y159.703 E.00577
; LINE_WIDTH: 0.316155
G1 X206.646 Y159.847 E.00504
; LINE_WIDTH: 0.277063
G1 X206.474 Y159.992 E.00432
; LINE_WIDTH: 0.23797
G1 X206.302 Y160.136 E.0036
; LINE_WIDTH: 0.196703
G1 X206.194 Y160.212 E.00168
; LINE_WIDTH: 0.153286
G1 X206.085 Y160.288 E.0012
; LINE_WIDTH: 0.109869
G1 X205.977 Y160.364 E.00073
; WIPE_START
G1 F15000
G1 X206.085 Y160.288 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I1.103 J.515 P1  F60000
G1 X207.65 Y156.936 Z16
G1 Z15.6
G1 E.4 F1800
; LINE_WIDTH: 0.159647
G1 F4959
M204 S8000
G1 X207.566 Y157.067 E.0015
; LINE_WIDTH: 0.14009
G1 X207.502 Y157.158 E.00089
; LINE_WIDTH: 0.105481
G1 X207.438 Y157.249 E.00057
M204 S10000
G1 X207.159 Y157.943 F60000
; LINE_WIDTH: 0.216499
G1 F4959
M204 S8000
G1 X207.012 Y158.118 E.00327
; LINE_WIDTH: 0.172097
G3 X206.351 Y158.807 I-10.125 J-9.048 E.01015
; LINE_WIDTH: 0.184851
G1 X206.176 Y158.954 E.00268
; LINE_WIDTH: 0.216501
G1 X206 Y159.101 E.00327
M204 S10000
G1 X205.307 Y159.381 F60000
; LINE_WIDTH: 0.105479
G1 F4959
M204 S8000
G1 X205.216 Y159.445 E.00057
; LINE_WIDTH: 0.15155
G3 X204.993 Y159.592 I-1.797 J-2.469 E.00239
M204 S10000
G1 X203.861 Y159.786 F60000
; LINE_WIDTH: 0.0986636
G1 F4959
M204 S8000
G1 X203.653 Y159.7 E.00104
; WIPE_START
G1 F15000
G1 X203.861 Y159.786 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I.861 J-.861 P1  F60000
G1 X199.595 Y155.52 Z16
G1 Z15.6
G1 E.4 F1800
; LINE_WIDTH: 0.0985657
G1 F4959
M204 S8000
G1 X199.682 Y155.729 E.00103
M204 S10000
G1 X200.001 Y154.075 F60000
; LINE_WIDTH: 0.105505
G1 F4959
M204 S8000
G1 X199.937 Y154.166 E.00057
; LINE_WIDTH: 0.151598
G2 X199.79 Y154.388 I2.438 J1.775 E.00239
M204 S10000
G1 X201.439 Y152.223 F60000
; LINE_WIDTH: 0.216523
G1 F4959
M204 S8000
G1 X201.263 Y152.37 E.00327
; LINE_WIDTH: 0.17218
G2 X200.575 Y153.03 I9.046 J10.121 E.01015
; LINE_WIDTH: 0.184913
G1 X200.428 Y153.206 E.00268
; LINE_WIDTH: 0.216531
G1 X200.28 Y153.381 E.00327
M204 S10000
G1 X202.446 Y151.732 F60000
; LINE_WIDTH: 0.159763
G1 F4959
M204 S8000
G1 X202.314 Y151.816 E.0015
; LINE_WIDTH: 0.140161
G1 X202.223 Y151.88 E.00089
; LINE_WIDTH: 0.105495
G1 X202.132 Y151.943 E.00057
; WIPE_START
G1 F15000
G1 X202.223 Y151.88 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I.937 J-.776 P1  F60000
G1 X201.462 Y150.96 Z16
G1 Z15.6
G1 E.4 F1800
; LINE_WIDTH: 0.109857
G1 F4959
M204 S8000
G1 X201.354 Y151.036 E.00073
; LINE_WIDTH: 0.15325
G1 X201.245 Y151.112 E.0012
; LINE_WIDTH: 0.196643
G1 X201.137 Y151.188 E.00168
; LINE_WIDTH: 0.237897
G1 X200.965 Y151.332 E.0036
; LINE_WIDTH: 0.276986
G1 X200.793 Y151.477 E.00432
; LINE_WIDTH: 0.316076
G1 X200.621 Y151.621 E.00504
; LINE_WIDTH: 0.370762
G1 X200.449 Y151.765 E.00605
G1 X199.822 Y152.392 E.02393
; LINE_WIDTH: 0.355155
G1 X199.678 Y152.564 E.00576
; LINE_WIDTH: 0.316065
G1 X199.534 Y152.736 E.00504
; LINE_WIDTH: 0.276974
G1 X199.39 Y152.907 E.00432
; LINE_WIDTH: 0.237884
G1 X199.246 Y153.079 E.0036
; LINE_WIDTH: 0.196635
G1 X199.17 Y153.188 E.00168
; LINE_WIDTH: 0.153252
G1 X199.094 Y153.296 E.0012
; LINE_WIDTH: 0.109868
G1 X199.018 Y153.405 E.00073
; WIPE_START
G1 F15000
G1 X199.094 Y153.296 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I.408 J1.146 P1  F60000
G1 X203.787 Y151.624 Z16
G1 Z15.6
G1 E.4 F1800
; LINE_WIDTH: 0.0985784
G1 F4959
M204 S8000
G1 X203.578 Y151.538 E.00104
; WIPE_START
G1 F15000
G1 X203.787 Y151.624 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z16 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 15.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 79/82
; update layer progress
M73 L79
M991 S0 P78 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 7
G1 X206.805 Y155.662 F60000
G1 Z15.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3937
M204 S8000
G3 X203.72 Y152.575 I-3.086 J-.001 E.48722
G1 X203.89 Y152.59 E.00572
G1 X204.256 Y152.622 E.01231
G3 X206.805 Y155.602 I-.536 J3.039 E.14241
; COOLING_NODE: 7
; WIPE_START
G1 F18000
G1 X206.76 Y156.198 E-.22708
G1 X206.656 Y156.587 E-.15292
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I.571 J1.075 P1  F60000
G1 X208.423 Y155.648 Z16.2
G1 Z15.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3937
M204 S5000
G1 X208.424 Y155.662 E.00044
G1 X208.353 Y156.479 E.02546
G1 X208.14 Y157.271 E.02545
G1 X207.794 Y158.014 E.02546
G1 X207.323 Y158.686 E.02545
G1 X206.744 Y159.266 E.02545
G1 X206.072 Y159.736 E.02546
G1 X205.329 Y160.083 E.02545
G1 X204.537 Y160.295 E.02546
G1 X203.72 Y160.367 E.02546
G1 X202.903 Y160.295 E.02545
G1 X202.111 Y160.083 E.02545
G1 X201.367 Y159.736 E.02546
G1 X200.696 Y159.266 E.02545
G1 X200.116 Y158.686 E.02545
G1 X199.645 Y158.014 E.02546
G1 X199.299 Y157.271 E.02545
G1 X199.087 Y156.479 E.02546
G1 X199.015 Y155.662 E.02546
G1 X199.087 Y154.845 E.02546
G1 X199.116 Y154.736 E.00349
G1 X199.299 Y154.053 E.02196
G1 X199.645 Y153.31 E.02546
G1 X200.116 Y152.638 E.02545
G1 X200.696 Y152.058 E.02545
G1 X201.367 Y151.588 E.02546
G1 X202.111 Y151.241 E.02545
G1 X202.903 Y151.029 E.02546
G1 X203.72 Y150.958 E.02545
G1 X203.832 Y150.967 E.00349
G1 X204.537 Y151.029 E.02196
G1 X205.329 Y151.241 E.02545
G1 X206.072 Y151.588 E.02546
G1 X206.744 Y152.058 E.02545
G1 X207.323 Y152.638 E.02545
G1 X207.794 Y153.31 E.02546
G1 X208.14 Y154.053 E.02545
G1 X208.353 Y154.845 E.02546
G1 X208.418 Y155.588 E.02316
; WIPE_START
G1 F12000
M204 S8000
G1 X208.424 Y155.662 E-.02815
G1 X208.353 Y156.479 E-.31162
G1 X208.325 Y156.581 E-.04023
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I1.205 J-.173 P1  F60000
G1 X208.005 Y154.348 Z16.2
G1 Z15.8
G1 E.4 F1800
; FEATURE: Top surface
G1 F3937
M204 S2000
G1 X205.034 Y151.377 E.13043
G1 X204.344 Y151.22
G1 X208.161 Y155.038 E.16758
; WIPE_START
G1 F12000
M204 S8000
G1 X207.454 Y154.331 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I.454 J-1.129 P1  F60000
G1 X206.562 Y153.972 Z16.2
G1 Z15.8
G1 E.4 F1800
G1 F3937
M204 S2000
G1 X208.212 Y155.622 E.07246
G1 X208.176 Y156.119
G1 X206.919 Y154.863 E.05516
G1 X207.015 Y155.491
G1 X208.109 Y156.586 E.04804
G1 X207.997 Y157.006
G1 X207 Y156.009 E.04377
G1 X206.919 Y156.462
G1 X207.853 Y157.396 E.041
G1 X207.684 Y157.76
G1 X206.795 Y156.871 E.03903
G1 X206.625 Y157.234
G1 X207.485 Y158.094 E.03774
G1 X207.265 Y158.408
G1 X206.417 Y157.559 E.03724
G1 X206.185 Y157.861
G1 X207.02 Y158.696 E.03667
G1 X206.754 Y158.963
G1 X205.918 Y158.127 E.03667
G1 X205.617 Y158.359
G1 X206.465 Y159.208 E.03724
G1 X206.152 Y159.427
G1 X205.292 Y158.568 E.03774
G1 X204.928 Y158.737
G1 X205.817 Y159.626 E.03903
G1 X205.454 Y159.796
G1 X204.52 Y158.862 E.041
G1 X204.067 Y158.942
G1 X205.064 Y159.939 E.04377
G1 X204.643 Y160.052
G1 X203.549 Y158.957 E.04804
G1 X202.92 Y158.862
G1 X204.176 Y160.118 E.05516
G1 X203.68 Y160.155
G1 X202.029 Y158.504 E.07248
; WIPE_START
G1 F12000
M204 S8000
G1 X202.736 Y159.211 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I1.123 J.47 P1  F60000
G1 X205.41 Y152.82 Z16.2
G1 Z15.8
G1 E.4 F1800
G1 F3937
M204 S2000
G1 X203.759 Y151.169 E.07246
G1 X203.263 Y151.206
G1 X204.519 Y152.462 E.05516
G1 X203.89 Y152.367
G1 X202.796 Y151.272 E.04804
G1 X202.375 Y151.385
G1 X203.372 Y152.382 E.04377
G1 X202.919 Y152.462
G1 X201.985 Y151.528 E.041
G1 X201.622 Y151.698
G1 X202.511 Y152.587 E.03903
G1 X202.147 Y152.757
G1 X201.287 Y151.897 E.03774
G1 X200.974 Y152.116
G1 X201.822 Y152.965 E.03724
G1 X201.521 Y153.197
G1 X200.686 Y152.361 E.03667
G1 X200.419 Y152.628
G1 X201.254 Y153.464 E.03667
G1 X201.022 Y153.765
G1 X200.174 Y152.916 E.03724
G1 X199.954 Y153.23
G1 X200.814 Y154.09 E.03774
G1 X200.644 Y154.453
G1 X199.755 Y153.564 E.03903
G1 X199.586 Y153.928
G1 X200.52 Y154.862 E.041
G1 X200.44 Y155.315
G1 X199.442 Y154.318 E.04377
G1 X199.33 Y154.739
G1 X200.424 Y155.833 E.04804
G1 X200.52 Y156.462
G1 X199.263 Y155.205 E.05516
G1 X199.227 Y155.702
G1 X200.878 Y157.353 E.07248
; WIPE_START
G1 F12000
M204 S8000
G1 X200.171 Y156.646 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I.455 J-1.129 P1  F60000
G1 X199.278 Y156.286 Z16.2
G1 Z15.8
G1 E.4 F1800
G1 F3937
M204 S2000
G1 X203.095 Y160.104 E.16758
G1 X202.405 Y159.947
G1 X199.434 Y156.976 E.13042
; WIPE_START
G1 F12000
M204 S8000
G1 X200.142 Y157.683 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I-.529 J1.096 P1  F60000
G1 X201.968 Y158.564 Z16.2
G1 Z15.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.213868
G1 F3937
M204 S8000
G1 X201.769 Y158.398 E.00365
; LINE_WIDTH: 0.163466
G3 X201.151 Y157.811 I6.637 J-7.618 E.00846
; LINE_WIDTH: 0.176916
G1 X200.984 Y157.612 E.00286
; LINE_WIDTH: 0.213853
G1 X200.817 Y157.413 E.00365
; WIPE_START
G1 F15000
G1 X200.984 Y157.612 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I.185 J1.203 P1  F60000
G1 X206.894 Y156.704 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.0909
G1 F3937
M204 S8000
G3 X206.817 Y156.822 I-1.39 J-.82 E.00056
; WIPE_START
G1 F15000
G1 X206.894 Y156.704 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I-.869 J-.852 P1  F60000
G1 X204.879 Y158.76 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.0908764
G1 F3937
M204 S8000
G3 X204.761 Y158.836 I-.934 J-1.31 E.00056
; WIPE_START
G1 F15000
G1 X204.879 Y158.76 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I-.397 J-1.15 P1  F60000
G1 X201.939 Y159.774 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.109612
G1 F3937
M204 S8000
G1 X201.834 Y159.7 E.00071
; LINE_WIDTH: 0.152484
G1 X201.728 Y159.626 E.00116
; LINE_WIDTH: 0.195355
G1 X201.622 Y159.552 E.00162
; LINE_WIDTH: 0.238227
G1 X201.516 Y159.478 E.00208
; LINE_WIDTH: 0.281916
G1 X201.321 Y159.314 E.00502
; LINE_WIDTH: 0.326376
G1 X201.126 Y159.15 E.00595
; LINE_WIDTH: 0.387455
G1 X200.93 Y158.986 E.00723
G1 X200.395 Y158.451 E.02145
; LINE_WIDTH: 0.37082
G1 X200.231 Y158.256 E.00689
; LINE_WIDTH: 0.326357
G1 X200.067 Y158.061 E.00595
; LINE_WIDTH: 0.281894
G1 X199.903 Y157.865 E.00502
; LINE_WIDTH: 0.238221
G1 X199.829 Y157.759 E.00208
; LINE_WIDTH: 0.195347
G1 X199.755 Y157.654 E.00162
; LINE_WIDTH: 0.152473
G1 X199.681 Y157.548 E.00116
; LINE_WIDTH: 0.109598
G1 X199.607 Y157.442 E.00071
; WIPE_START
G1 F15000
G1 X199.681 Y157.548 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I-.368 J1.16 P1  F60000
G1 X206.004 Y159.554 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.10448
G1 F3937
M204 S8000
G1 X205.95 Y159.545 E.00027
G1 X205.866 Y159.603 E.00052
; WIPE_START
G1 F15000
G1 X205.95 Y159.545 E-.2491
G1 X206.004 Y159.554 E-.1309
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I.882 J.838 P1  F60000
G1 X207.661 Y157.809 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.104501
G1 F3937
M204 S8000
G1 X207.602 Y157.893 E.00052
G1 X207.611 Y157.946 E.00027
; WIPE_START
G1 F15000
G1 X207.602 Y157.893 E-.13091
G1 X207.661 Y157.809 E-.24909
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I1.176 J-.313 P1  F60000
G1 X206.622 Y153.911 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.213842
G1 F3937
M204 S8000
G1 X206.455 Y153.712 E.00365
; LINE_WIDTH: 0.163382
G2 X205.868 Y153.093 I-7.616 J6.634 E.00846
; LINE_WIDTH: 0.176859
G1 X205.669 Y152.926 E.00286
; LINE_WIDTH: 0.213855
G1 X205.47 Y152.759 E.00365
; WIPE_START
G1 F15000
G1 X205.669 Y152.926 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I-.492 J1.113 P1  F60000
G1 X207.832 Y153.882 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.109611
G1 F3937
M204 S8000
G1 X207.758 Y153.776 E.00071
; LINE_WIDTH: 0.152509
G1 X207.684 Y153.671 E.00117
; LINE_WIDTH: 0.195408
G1 X207.61 Y153.565 E.00162
; LINE_WIDTH: 0.238307
G1 X207.536 Y153.459 E.00208
; LINE_WIDTH: 0.281982
G1 X207.372 Y153.264 E.00502
; LINE_WIDTH: 0.32645
G1 X207.208 Y153.068 E.00595
; LINE_WIDTH: 0.387543
G1 X207.044 Y152.873 E.00724
G1 X206.509 Y152.338 E.02146
; LINE_WIDTH: 0.370921
G1 X206.314 Y152.174 E.00689
; LINE_WIDTH: 0.326463
G1 X206.118 Y152.01 E.00595
; LINE_WIDTH: 0.282004
G1 X205.923 Y151.846 E.00502
; LINE_WIDTH: 0.238314
G1 X205.817 Y151.772 E.00208
; LINE_WIDTH: 0.195417
G1 X205.711 Y151.698 E.00162
; LINE_WIDTH: 0.152521
G1 X205.605 Y151.624 E.00117
; LINE_WIDTH: 0.109625
G1 X205.499 Y151.55 E.00071
; WIPE_START
G1 F15000
G1 X205.605 Y151.624 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I-.345 J-1.167 P1  F60000
G1 X202.678 Y152.488 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.0909008
G1 F3937
M204 S8000
G2 X202.56 Y152.564 I.767 J1.313 E.00056
; WIPE_START
G1 F15000
G1 X202.678 Y152.488 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I-.852 J-.869 P1  F60000
G1 X200.622 Y154.503 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.0908756
G1 F3937
M204 S8000
G2 X200.545 Y154.621 I1.275 J.911 E.00056
; WIPE_START
G1 F15000
G1 X200.622 Y154.503 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I.994 J-.702 P1  F60000
G1 X199.828 Y153.378 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.104458
G1 F3937
M204 S8000
G1 X199.837 Y153.431 E.00027
M73 P96 R0
G1 X199.778 Y153.515 E.00052
; WIPE_START
G1 F15000
G1 X199.837 Y153.431 E-.24906
G1 X199.828 Y153.378 E-.13094
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I.838 J.882 P1  F60000
G1 X201.573 Y151.721 Z16.2
G1 Z15.8
G1 E.4 F1800
; LINE_WIDTH: 0.104509
G1 F3937
M204 S8000
G1 X201.489 Y151.78 E.00052
G1 X201.436 Y151.77 E.00027
; WIPE_START
G1 F15000
G1 X201.489 Y151.78 E-.13082
G1 X201.573 Y151.721 E-.24918
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I-.688 J1.004 P1  F60000
G1 X206.311 Y154.968 Z16.2
G1 Z15.8
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F3937
M204 S8000
G2 X206.393 Y155.428 I-2.587 J.694 E.50777
G1 X206.322 Y155.027 E.01265
M204 S10000
G1 X205.81 Y154.688 F60000
G1 F3937
M204 S8000
G1 X205.493 Y154.174 E.01873
G1 X205.042 Y153.773 E.01872
G1 X204.511 Y153.487 E.01873
G1 X203.921 Y153.365 E.01872
G1 X203.318 Y153.382 E.01873
G1 X202.745 Y153.572 E.01872
G1 X202.232 Y153.889 E.01873
G1 X201.831 Y154.339 E.01872
G1 X201.544 Y154.87 E.01873
G1 X201.422 Y155.461 E.01872
G1 X201.44 Y156.064 E.01873
G1 X201.63 Y156.637 E.01872
G1 X201.946 Y157.15 E.01872
G1 X202.397 Y157.551 E.01872
G1 X202.928 Y157.837 E.01873
G1 X203.518 Y157.959 E.01872
G1 X204.122 Y157.942 E.01873
G1 X204.694 Y157.752 E.01872
G1 X205.208 Y157.435 E.01873
G1 X205.609 Y156.985 E.01872
G1 X205.895 Y156.454 E.01873
G1 X206.017 Y155.863 E.01872
G1 X205.999 Y155.26 E.01873
G1 X205.829 Y154.745 E.01686
M204 S10000
G1 X205.468 Y154.847 F60000
G1 F3937
M204 S8000
G1 X205.203 Y154.417 E.01567
G1 X204.826 Y154.082 E.01566
G1 X204.382 Y153.842 E.01567
G1 X203.888 Y153.74 E.01566
G1 X203.383 Y153.755 E.01566
G1 X202.904 Y153.914 E.01566
G1 X202.475 Y154.179 E.01566
G1 X202.139 Y154.556 E.01566
G1 X201.9 Y155 E.01567
G1 X201.798 Y155.494 E.01566
G1 X201.813 Y155.998 E.01567
G1 X201.971 Y156.477 E.01566
G1 X202.236 Y156.907 E.01566
G1 X202.613 Y157.242 E.01566
G1 X203.057 Y157.482 E.01567
G1 X203.551 Y157.584 E.01566
G1 X204.056 Y157.569 E.01566
G1 X204.535 Y157.41 E.01566
G1 X204.964 Y157.145 E.01566
G1 X205.3 Y156.769 E.01566
G1 X205.539 Y156.324 E.01567
G1 X205.641 Y155.83 E.01566
G1 X205.627 Y155.326 E.01566
G1 X205.487 Y154.904 E.0138
M204 S10000
G1 X205.266 Y155.797 F60000
G1 F3937
M204 S8000
G1 X205.254 Y155.392 E.0126
G1 X205.069 Y154.883 E.0168
G1 X204.721 Y154.469 E.01679
G1 X204.252 Y154.198 E.0168
G1 X203.72 Y154.104 E.01679
G1 X203.187 Y154.198 E.01679
G1 X202.718 Y154.469 E.01679
G1 X202.37 Y154.883 E.01679
G1 X202.185 Y155.391 E.01679
G1 X202.185 Y155.933 E.01679
G1 X202.37 Y156.441 E.0168
G1 X202.718 Y156.855 E.01679
G1 X203.187 Y157.126 E.0168
G1 X203.72 Y157.22 E.01679
G1 X204.252 Y157.126 E.01679
G1 X204.721 Y156.855 E.0168
G1 X205.069 Y156.441 E.01679
G1 X205.254 Y155.933 E.0168
G1 X205.26 Y155.857 E.00235
M204 S10000
G1 X204.89 Y155.764 F60000
G1 F3937
M204 S8000
G1 X204.881 Y155.457 E.00954
G1 X204.741 Y155.072 E.01272
G1 X204.478 Y154.759 E.01271
G1 X204.123 Y154.554 E.01272
G1 X203.72 Y154.483 E.01271
G1 X203.316 Y154.554 E.01271
G1 X202.961 Y154.759 E.01271
G1 X202.698 Y155.072 E.01271
G1 X202.558 Y155.457 E.01271
G1 X202.558 Y155.867 E.01271
G1 X202.698 Y156.252 E.01272
G1 X202.961 Y156.565 E.01271
G1 X203.316 Y156.77 E.01272
G1 X203.72 Y156.841 E.01271
G1 X204.123 Y156.77 E.01271
G1 X204.478 Y156.566 E.01272
G1 X204.741 Y156.252 E.01271
G1 X204.885 Y155.824 E.014
M204 S10000
G1 X203.749 Y155.612 F60000
; LINE_WIDTH: 0.50728
G1 F3937
M204 S8000
G2 X203.747 Y155.712 I-.029 J.05 E.00915
M204 S10000
G1 X203.338 Y155.84 F60000
; LINE_WIDTH: 0.41999
G1 F3937
M204 S8000
G1 X203.478 Y156.007 E.00675
G1 X203.683 Y156.081 E.00676
G1 X203.898 Y156.043 E.00676
G1 X204.064 Y155.903 E.00675
G1 X204.139 Y155.699 E.00676
G1 X204.101 Y155.484 E.00677
G1 X203.961 Y155.317 E.00675
G1 X203.756 Y155.243 E.00676
G1 X203.542 Y155.281 E.00677
G1 X203.375 Y155.421 E.00675
G1 X203.3 Y155.625 E.00676
G1 X203.328 Y155.781 E.00491
M204 S10000
G1 X203.382 Y156.385 F60000
G1 F3937
M204 S8000
G1 X203.72 Y156.463 E.01074
G1 X204.057 Y156.385 E.01075
G1 X204.333 Y156.177 E.01074
G1 X204.49 Y155.868 E.01075
G1 X204.514 Y155.732 E.00431
G1 X204.472 Y155.388 E.01074
G1 X204.284 Y155.098 E.01074
G1 X203.993 Y154.91 E.01074
G1 X203.65 Y154.867 E.01074
G1 X203.319 Y154.969 E.01074
G1 X203.066 Y155.204 E.01074
G1 X202.931 Y155.523 E.01074
G1 X202.949 Y155.869 E.01074
G1 X203.106 Y156.177 E.01074
G1 X203.335 Y156.349 E.00888
; WIPE_START
G1 F15000
G1 X203.106 Y156.177 E-.10871
G1 X202.949 Y155.869 E-.13149
G1 X202.931 Y155.523 E-.1315
G1 X202.939 Y155.503 E-.00829
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.2 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z16.2 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 16
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 80/82
; update layer progress
M73 L80
M991 S0 P79 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 8
G1 X206.056 Y155.662 F60000
G1 Z16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2731
M204 S8000
G3 X203.72 Y153.321 I-2.336 J-.004 E.36876
G1 X204.023 Y153.348 E.01022
G1 X204.126 Y153.357 E.00345
G3 X206.055 Y155.602 I-.406 J2.301 E.10743
; COOLING_NODE: 8
; WIPE_START
G1 F18000
G1 X206.025 Y156.068 E-.17757
G1 X205.919 Y156.463 E-.15508
G1 X205.866 Y156.576 E-.04735
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I.548 J1.087 P1  F60000
G1 X207.678 Y155.662 Z16.4
G1 Z16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2731
M204 S5000
G1 X207.618 Y156.349 E.02142
G1 X207.439 Y157.016 E.02142
G1 X207.147 Y157.641 E.02142
G1 X206.752 Y158.206 E.02142
G1 X206.264 Y158.694 E.02142
G1 X205.699 Y159.09 E.02142
G1 X205.475 Y159.194 E.00766
G1 X205.073 Y159.381 E.01376
G1 X204.407 Y159.56 E.02142
G1 X203.72 Y159.62 E.02142
G1 X203.032 Y159.56 E.02142
G1 X202.366 Y159.381 E.02142
G1 X201.741 Y159.09 E.02142
G1 X201.175 Y158.694 E.02142
G1 X200.687 Y158.206 E.02142
G1 X200.292 Y157.641 E.02142
G1 X200.187 Y157.418 E.00766
G1 X200 Y157.016 E.01376
G1 X199.822 Y156.349 E.02142
G1 X199.761 Y155.662 E.02142
G1 X199.822 Y154.975 E.02142
G1 X199.885 Y154.736 E.00766
G1 X200 Y154.308 E.01376
G1 X200.292 Y153.683 E.02142
G1 X200.687 Y153.118 E.02142
G1 X201.175 Y152.63 E.02142
G1 X201.741 Y152.234 E.02142
G1 X202.366 Y151.943 E.02142
G1 X203.032 Y151.764 E.02142
G1 X203.72 Y151.704 E.02142
G1 X203.965 Y151.725 E.00766
G1 X204.407 Y151.764 E.01376
G1 X205.073 Y151.943 E.02142
G1 X205.699 Y152.234 E.02142
G1 X206.264 Y152.63 E.02142
G1 X206.752 Y153.118 E.02142
G1 X207.147 Y153.683 E.02142
G1 X207.439 Y154.308 E.02142
G1 X207.618 Y154.975 E.02142
G1 X207.672 Y155.602 E.01955
; WIPE_START
G1 F12000
M204 S8000
G1 X207.618 Y156.349 E-.28466
G1 X207.553 Y156.592 E-.09534
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I-.323 J-1.173 P1  F60000
G1 X204.539 Y157.42 Z16.4
G1 Z16
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F2731
M204 S8000
G1 X204.971 Y157.154 E.01575
G1 X205.308 Y156.775 E.01575
G1 X205.549 Y156.328 E.01575
G1 X205.652 Y155.831 E.01574
G1 X205.637 Y155.324 E.01575
G1 X205.478 Y154.843 E.01574
G1 X205.211 Y154.41 E.01576
G1 X204.832 Y154.073 E.01575
G1 X204.385 Y153.832 E.01575
G1 X203.889 Y153.73 E.01574
G1 X203.381 Y153.745 E.01575
G1 X202.9 Y153.904 E.01574
G1 X202.468 Y154.171 E.01575
G1 X202.131 Y154.549 E.01575
G1 X201.89 Y154.996 E.01575
G1 X201.787 Y155.493 E.01574
G1 X201.802 Y156 E.01575
G1 X201.962 Y156.482 E.01574
G1 X202.228 Y156.914 E.01575
G1 X202.607 Y157.251 E.01575
G1 X203.054 Y157.492 E.01575
G1 X203.55 Y157.594 E.01574
G1 X204.058 Y157.579 E.01575
G1 X204.482 Y157.439 E.01388
M204 S10000
G1 X205.276 Y155.798 F60000
G1 F2731
M204 S8000
G1 X205.264 Y155.39 E.01269
G1 X205.078 Y154.878 E.01691
G1 X204.728 Y154.46 E.01691
G1 X204.256 Y154.188 E.01691
G1 X203.72 Y154.094 E.01691
G1 X203.183 Y154.188 E.01691
G1 X202.711 Y154.46 E.01691
G1 X202.361 Y154.878 E.01691
G1 X202.175 Y155.39 E.01691
G1 X202.175 Y155.934 E.01691
G1 X202.361 Y156.446 E.01691
G1 X202.711 Y156.864 E.01691
G1 X203.183 Y157.136 E.01691
G1 X203.72 Y157.231 E.01691
G1 X204.256 Y157.136 E.01691
G1 X204.728 Y156.864 E.01691
G1 X205.078 Y156.446 E.01691
G1 X205.264 Y155.934 E.01691
G1 X205.271 Y155.858 E.00238
M204 S10000
G1 X204.901 Y155.765 F60000
G1 F2731
M204 S8000
G1 X204.891 Y155.455 E.00963
G1 X204.75 Y155.067 E.01283
G1 X204.485 Y154.75 E.01283
G1 X204.127 Y154.544 E.01283
G1 X203.72 Y154.472 E.01283
G1 X203.313 Y154.544 E.01283
G1 X202.955 Y154.75 E.01283
G1 X202.689 Y155.067 E.01283
G1 X202.548 Y155.455 E.01283
G1 X202.548 Y155.869 E.01282
G1 X202.689 Y156.257 E.01283
G1 X202.955 Y156.574 E.01283
G1 X203.313 Y156.78 E.01283
G1 X203.72 Y156.852 E.01283
G1 X204.127 Y156.78 E.01283
G1 X204.485 Y156.574 E.01283
G1 X204.75 Y156.257 E.01283
G1 X204.895 Y155.825 E.01415
M204 S10000
G1 X204.5 Y155.871 F60000
G1 F2731
M204 S8000
G1 X204.525 Y155.732 E.00437
G1 X204.482 Y155.385 E.01088
G1 X204.291 Y155.09 E.01089
G1 X203.997 Y154.899 E.01088
G1 X203.649 Y154.857 E.01088
G1 X203.314 Y154.959 E.01089
G1 X203.057 Y155.198 E.01088
G1 X202.92 Y155.521 E.01089
G1 X202.939 Y155.871 E.01088
G1 X203.098 Y156.184 E.01088
G1 X203.378 Y156.395 E.01088
G1 X203.72 Y156.474 E.01088
G1 X204.061 Y156.395 E.01089
G1 X204.341 Y156.184 E.01088
G1 X204.473 Y155.925 E.00903
M204 S10000
G1 X203.75 Y155.609 F60000
; LINE_WIDTH: 0.5285
G1 F2731
M204 S8000
G2 X203.75 Y155.714 I-.025 J.052 E.0093
M204 S10000
G1 X203.329 Y155.844 F60000
; LINE_WIDTH: 0.41999
G1 F2731
M204 S8000
G1 X203.472 Y156.015 E.00692
G1 X203.682 Y156.092 E.00693
G1 X203.902 Y156.053 E.00693
G1 X204.073 Y155.91 E.00692
G1 X204.149 Y155.7 E.00693
G1 X204.11 Y155.48 E.00693
G1 X203.967 Y155.309 E.00693
G1 X203.757 Y155.232 E.00693
G1 X203.537 Y155.271 E.00693
G1 X203.366 Y155.415 E.00692
G1 X203.29 Y155.624 E.00693
G1 X203.318 Y155.785 E.00507
; WIPE_START
G1 F15000
G1 X203.29 Y155.624 E-.06209
G1 X203.366 Y155.415 E-.08488
G1 X203.537 Y155.271 E-.08478
G1 X203.757 Y155.232 E-.08488
G1 X203.914 Y155.289 E-.06337
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I-1.198 J.214 P1  F60000
G1 X204.628 Y159.286 Z16.4
G1 Z16
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F2731
M204 S2000
G1 X207.344 Y156.571 E.1192
G1 X207.446 Y155.935
G1 X203.993 Y159.388 E.15157
; WIPE_START
G1 F12000
M204 S8000
G1 X204.7 Y158.681 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I1.164 J.355 P1  F60000
G1 X204.934 Y157.914 Z16.4
G1 Z16
G1 E.4 F1800
G1 F2731
M204 S2000
G1 X203.459 Y159.389 E.06475
G1 X202.982 Y159.332
G1 X204.124 Y158.191 E.0501
G1 X203.568 Y158.213
G1 X202.562 Y159.219 E.04418
G1 X202.181 Y159.067
G1 X203.106 Y158.142 E.04059
G1 X202.707 Y158.008
G1 X201.821 Y158.893 E.03886
G1 X201.508 Y158.674
G1 X202.356 Y157.825 E.03724
G1 X202.047 Y157.601
G1 X201.211 Y158.437 E.03667
G1 X200.945 Y158.17
G1 X201.78 Y157.335 E.03667
G1 X201.556 Y157.025
G1 X200.708 Y157.874 E.03724
G1 X200.488 Y157.56
G1 X201.374 Y156.675 E.03887
G1 X201.24 Y156.275
G1 X200.315 Y157.2 E.04059
G1 X200.162 Y156.82
G1 X201.169 Y155.813 E.04418
G1 X201.191 Y155.258
G1 X200.05 Y156.399 E.05011
G1 X199.992 Y155.923
G1 X201.468 Y154.448 E.06475
; WIPE_START
G1 F12000
M204 S8000
G1 X200.76 Y155.155 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I-.382 J1.156 P1  F60000
G1 X205.972 Y156.876 Z16.4
G1 Z16
G1 E.4 F1800
G1 F2731
M204 S2000
G1 X207.447 Y155.401 E.06475
G1 X207.389 Y154.925
G1 X206.248 Y156.066 E.0501
G1 X206.27 Y155.511
G1 X207.277 Y154.504 E.04418
G1 X207.124 Y154.124
G1 X206.199 Y155.048 E.04059
G1 X206.065 Y154.649
G1 X206.951 Y153.764 E.03886
G1 X206.731 Y153.45
G1 X205.883 Y154.299 E.03724
G1 X205.659 Y153.989
G1 X206.494 Y153.154 E.03667
G1 X206.228 Y152.887
G1 X205.392 Y153.723 E.03667
G1 X205.083 Y153.499
G1 X205.931 Y152.65 E.03724
G1 X205.618 Y152.431
G1 X204.732 Y153.316 E.03887
G1 X204.333 Y153.182
G1 X205.258 Y152.257 E.04059
G1 X204.877 Y152.105
G1 X203.871 Y153.111 E.04418
G1 X203.315 Y153.133
G1 X204.457 Y151.992 E.05011
G1 X203.98 Y151.935
G1 X202.505 Y153.41 E.06475
; WIPE_START
G1 F12000
M204 S8000
G1 X203.212 Y152.703 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I1.164 J.355 P1  F60000
G1 X203.446 Y151.936 Z16.4
G1 Z16
G1 E.4 F1800
G1 F2731
M204 S2000
G1 X199.994 Y155.389 E.15156
G1 X200.096 Y154.753
G1 X202.811 Y152.038 E.11919
; WIPE_START
G1 F12000
M204 S8000
G1 X202.104 Y152.745 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I-.379 J1.156 P1  F60000
G1 X203.328 Y153.147 Z16.4
G1 Z16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.096738
G1 F2731
M204 S8000
G1 X203.106 Y153.077 E.00104
M204 S10000
G1 X202.515 Y153.419 F60000
; LINE_WIDTH: 0.162994
G1 F2731
M204 S8000
G1 X202.41 Y153.406 E.00104
; LINE_WIDTH: 0.185031
G1 X202.372 Y153.402 E.00045
G1 X202.054 Y153.669 E.00487
; LINE_WIDTH: 0.147022
G2 X201.727 Y153.996 I48.307 J48.634 E.00396
; LINE_WIDTH: 0.165929
G1 X201.593 Y154.155 E.00211
; LINE_WIDTH: 0.201159
G1 X201.46 Y154.315 E.00271
G1 X201.463 Y154.353 E.0005
; LINE_WIDTH: 0.163007
G1 X201.477 Y154.457 E.00104
; WIPE_START
G1 F15000
G1 X201.463 Y154.353 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I1.119 J.478 P1  F60000
G1 X202.401 Y152.155 Z16.4
G1 Z16
G1 E.4 F1800
; LINE_WIDTH: 0.108681
G1 F2731
M204 S8000
G1 X202.3 Y152.225 E.00066
; LINE_WIDTH: 0.149722
G1 X202.2 Y152.296 E.00108
; LINE_WIDTH: 0.190763
G1 X202.099 Y152.366 E.00149
; LINE_WIDTH: 0.231804
G1 X201.999 Y152.437 E.00191
; LINE_WIDTH: 0.272844
G1 X201.898 Y152.507 E.00232
; LINE_WIDTH: 0.31173
G1 X201.736 Y152.643 E.00467
; LINE_WIDTH: 0.34849
G1 X201.575 Y152.778 E.0053
; LINE_WIDTH: 0.399006
G2 X200.971 Y153.356 I2.999 J3.738 E.02453
; LINE_WIDTH: 0.385248
G1 X200.836 Y153.517 E.00594
; LINE_WIDTH: 0.348483
G1 X200.7 Y153.679 E.00531
; LINE_WIDTH: 0.311719
G1 X200.564 Y153.841 E.00467
; LINE_WIDTH: 0.272832
G1 X200.494 Y153.941 E.00232
; LINE_WIDTH: 0.231798
G1 X200.424 Y154.042 E.00191
; LINE_WIDTH: 0.190763
G1 X200.353 Y154.142 E.00149
; LINE_WIDTH: 0.149729
G1 X200.283 Y154.243 E.00108
; LINE_WIDTH: 0.108694
G1 X200.213 Y154.343 E.00066
; WIPE_START
G1 F15000
G1 X200.283 Y154.243 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I-.446 J1.132 P1  F60000
G1 X207.227 Y156.981 Z16.4
G1 Z16
G1 E.4 F1800
; LINE_WIDTH: 0.108701
G1 F2731
M204 S8000
G1 X207.156 Y157.081 E.00066
; LINE_WIDTH: 0.14975
G1 X207.086 Y157.182 E.00108
; LINE_WIDTH: 0.190798
G1 X207.015 Y157.282 E.00149
; LINE_WIDTH: 0.231847
G1 X206.945 Y157.383 E.00191
; LINE_WIDTH: 0.272896
G1 X206.875 Y157.484 E.00232
; LINE_WIDTH: 0.311819
G1 X206.739 Y157.645 E.00467
; LINE_WIDTH: 0.348583
G1 X206.604 Y157.807 E.00531
; LINE_WIDTH: 0.399087
G3 X206.026 Y158.41 I-3.738 J-2.999 E.02453
; LINE_WIDTH: 0.385337
G1 X205.864 Y158.546 E.00594
; LINE_WIDTH: 0.348581
G1 X205.703 Y158.682 E.00531
; LINE_WIDTH: 0.311826
G1 X205.541 Y158.817 E.00467
; LINE_WIDTH: 0.272908
G1 X205.441 Y158.887 E.00232
; LINE_WIDTH: 0.231853
G1 X205.34 Y158.958 E.00191
; LINE_WIDTH: 0.190798
G1 X205.239 Y159.028 E.00149
; LINE_WIDTH: 0.149743
G1 X205.139 Y159.099 E.00108
; LINE_WIDTH: 0.108689
M73 P97 R0
G1 X205.038 Y159.169 E.00066
; WIPE_START
G1 F15000
G1 X205.139 Y159.099 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I1.142 J.421 P1  F60000
G1 X205.963 Y156.867 Z16.4
G1 Z16
G1 E.4 F1800
; LINE_WIDTH: 0.163399
G1 F2731
M204 S8000
G1 X205.976 Y156.971 E.00105
; LINE_WIDTH: 0.184971
G1 X205.98 Y157.009 E.00044
G1 X205.712 Y157.328 E.00487
; LINE_WIDTH: 0.14693
G3 X205.386 Y157.655 I-47.765 J-47.439 E.00395
; LINE_WIDTH: 0.16585
G1 X205.226 Y157.788 E.00211
; LINE_WIDTH: 0.201156
G1 X205.067 Y157.922 E.00271
G1 X205.029 Y157.919 E.00049
; LINE_WIDTH: 0.163401
G1 X204.924 Y157.905 E.00105
M204 S10000
G1 X206.305 Y156.276 F60000
; LINE_WIDTH: 0.0969149
G1 F2731
M204 S8000
G1 X206.235 Y156.053 E.00104
; WIPE_START
G1 F15000
G1 X206.305 Y156.276 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I-.861 J-.861 P1  F60000
G1 X204.333 Y158.248 Z16.4
G1 Z16
G1 E.4 F1800
; LINE_WIDTH: 0.0969032
G1 F2731
M204 S8000
G1 X204.11 Y158.177 E.00104
; WIPE_START
G1 F15000
G1 X204.333 Y158.248 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I.861 J-.86 P1  F60000
G1 X201.134 Y155.048 Z16.4
G1 Z16
G1 E.4 F1800
; LINE_WIDTH: 0.0967424
G1 F2731
M204 S8000
G1 X201.204 Y155.271 E.00104
; WIPE_START
G1 F15000
G1 X201.134 Y155.048 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.4 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z16.4 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 16.2
; LAYER_HEIGHT: 0.200001
; layer num/total_layer_count: 81/82
; update layer progress
M73 L81
M991 S0 P80 ;notify layer change
; OBJECT_ID: 202
; COOLING_NODE: 9
G1 X204.922 Y155.662 F60000
G1 Z16.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1869
M204 S8000
G3 X203.72 Y154.458 I-1.202 J-.002 E.18971
G1 X203.929 Y154.476 E.00703
G3 X204.92 Y155.602 I-.209 J1.184 E.05429
; COOLING_NODE: 9
; WIPE_START
G1 F18000
G1 X204.905 Y155.871 E-.10237
G1 X204.851 Y156.074 E-.0798
G1 X204.762 Y156.264 E-.07977
G1 X204.642 Y156.436 E-.07973
G1 X204.571 Y156.507 E-.03833
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I.41 J1.146 P1  F60000
G1 X206.931 Y155.662 Z16.6
G1 Z16.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1869
M204 S5000
G1 X206.882 Y156.22 E.01738
G1 X206.738 Y156.761 E.01738
G1 X206.501 Y157.268 E.01738
G1 X206.18 Y157.727 E.01738
G1 X205.784 Y158.122 E.01738
G1 X205.325 Y158.443 E.01738
G1 X204.818 Y158.68 E.01738
G1 X204.277 Y158.825 E.01738
G1 X203.72 Y158.874 E.01738
G1 X203.162 Y158.825 E.01738
G1 X202.621 Y158.68 E.01738
G1 X202.114 Y158.443 E.01738
G1 X201.655 Y158.122 E.01738
G1 X201.259 Y157.727 E.01738
G1 X200.938 Y157.268 E.01738
G1 X200.702 Y156.761 E.01738
G1 X200.557 Y156.22 E.01738
G1 X200.508 Y155.662 E.01738
G1 X200.557 Y155.104 E.01738
G1 X200.702 Y154.564 E.01738
G1 X200.938 Y154.056 E.01738
G1 X201.259 Y153.598 E.01738
G1 X201.655 Y153.202 E.01738
G1 X202.114 Y152.881 E.01738
G1 X202.621 Y152.644 E.01738
G1 X203.162 Y152.499 E.01738
G1 X203.72 Y152.45 E.01738
G1 X204.099 Y152.484 E.01182
G1 X204.277 Y152.499 E.00555
G1 X204.818 Y152.644 E.01738
G1 X205.325 Y152.881 E.01738
G1 X205.784 Y153.202 E.01738
G1 X206.18 Y153.598 E.01738
G1 X206.501 Y154.056 E.01738
G1 X206.738 Y154.564 E.01738
G1 X206.836 Y154.931 E.01182
G1 X206.882 Y155.104 E.00555
G1 X206.926 Y155.602 E.01552
M204 S10000
G1 X206.679 Y155.155 F60000
; FEATURE: Top surface
G1 F1869
M204 S2000
G1 X204.227 Y152.703 E.10765
G1 X203.655 Y152.664
G1 X206.717 Y155.727 E.13445
G1 X206.67 Y156.213
G1 X203.169 Y152.712 E.15367
G1 X202.748 Y152.825
G1 X204.277 Y154.353 E.06708
G1 X203.633 Y154.242
G1 X202.377 Y152.987 E.05512
G1 X202.042 Y153.184
G1 X203.195 Y154.338 E.05063
G1 X202.855 Y154.531
G1 X201.737 Y153.413 E.04909
G1 X201.47 Y153.68
G1 X202.589 Y154.798 E.04909
G1 X202.395 Y155.138
G1 X201.242 Y153.984 E.05063
G1 X201.044 Y154.32
G1 X202.3 Y155.575 E.05512
G1 X202.41 Y156.219
G1 X200.882 Y154.691 E.06709
; WIPE_START
G1 F12000
M204 S8000
G1 X201.589 Y155.398 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I.103 J1.213 P1  F60000
G1 X205.029 Y155.105 Z16.6
G1 Z16.2
G1 E.4 F1800
G1 F1869
M204 S2000
G1 X206.557 Y156.633 E.06708
G1 X206.395 Y157.004
G1 X205.139 Y155.749 E.05512
G1 X205.044 Y156.187
G1 X206.197 Y157.34 E.05063
G1 X205.969 Y157.644
G1 X204.85 Y156.526 E.04909
G1 X204.584 Y156.793
G1 X205.702 Y157.911 E.04909
G1 X205.397 Y158.14
G1 X204.244 Y156.987 E.05063
G1 X203.806 Y157.082
G1 X205.062 Y158.338 E.05512
G1 X204.691 Y158.5
G1 X203.162 Y156.971 E.06709
; WIPE_START
G1 F12000
M204 S8000
G1 X203.869 Y157.678 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I-1.118 J.48 P1  F60000
G1 X204.27 Y158.612 Z16.6
G1 Z16.2
G1 E.4 F1800
G1 F1869
M204 S2000
G1 X200.769 Y155.112 E.15367
G1 X200.722 Y155.597
G1 X203.784 Y158.66 E.13445
G1 X203.212 Y158.621
G1 X200.76 Y156.169 E.10764
; WIPE_START
G1 F12000
M204 S8000
G1 X201.468 Y156.876 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I1.192 J-.246 P1  F60000
G1 X200.981 Y154.524 Z16.6
G1 Z16.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.104942
G1 F1869
M204 S8000
G2 X200.888 Y154.662 I.735 J.599 E.00085
; WIPE_START
G1 F15000
G1 X200.981 Y154.524 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I.849 J.872 P1  F60000
G1 X202.719 Y152.83 Z16.6
G1 Z16.2
G1 E.4 F1800
; LINE_WIDTH: 0.104904
G1 F1869
M204 S8000
G2 X202.581 Y152.924 I.464 J.832 E.00085
; WIPE_START
G1 F15000
G1 X202.719 Y152.83 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I-.543 J1.089 P1  F60000
G1 X206.589 Y154.759 Z16.6
G1 Z16.2
G1 E.4 F1800
; LINE_WIDTH: 0.169817
G1 F1869
M204 S8000
G1 X206.495 Y154.625 E.00171
; LINE_WIDTH: 0.214759
G1 X206.401 Y154.491 E.00232
; LINE_WIDTH: 0.259701
G1 X206.308 Y154.356 E.00292
; LINE_WIDTH: 0.304643
G1 X206.214 Y154.222 E.00353
; LINE_WIDTH: 0.348914
G1 X206.053 Y154.031 E.0063
; LINE_WIDTH: 0.406972
G2 X205.543 Y153.49 I-3.347 J2.645 E.02232
; LINE_WIDTH: 0.392494
G1 X205.351 Y153.329 E.0072
; LINE_WIDTH: 0.348897
G1 X205.159 Y153.168 E.0063
; LINE_WIDTH: 0.304639
G1 X205.025 Y153.074 E.00353
; LINE_WIDTH: 0.259703
G1 X204.891 Y152.98 E.00292
; LINE_WIDTH: 0.214768
G1 X204.757 Y152.886 E.00232
; LINE_WIDTH: 0.169833
G1 X204.623 Y152.792 E.00171
; WIPE_START
G1 F15000
G1 X204.757 Y152.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I-1.13 J-.451 P1  F60000
G1 X203.1 Y157.033 Z16.6
G1 Z16.2
G1 E.4 F1800
; LINE_WIDTH: 0.203936
G1 F1869
M204 S8000
G1 X202.973 Y156.943 E.00207
; LINE_WIDTH: 0.162993
G3 X202.431 Y156.399 I2.04 J-2.573 E.00761
; LINE_WIDTH: 0.204905
G1 X202.349 Y156.281 E.00191
; WIPE_START
G1 F15000
G1 X202.431 Y156.399 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I-.531 J1.095 P1  F60000
G1 X203.817 Y157.071 Z16.6
G1 Z16.2
G1 E.4 F1800
; LINE_WIDTH: 0.124373
G1 F1869
M204 S8000
G1 X203.613 Y157.155 E.00148
; WIPE_START
G1 F15000
G1 X203.817 Y157.071 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I.895 J.824 P1  F60000
G1 X205.213 Y155.556 Z16.6
G1 Z16.2
G1 E.4 F1800
; LINE_WIDTH: 0.124466
G1 F1869
M204 S8000
G1 X205.128 Y155.76 E.00149
M204 S10000
G1 X205.091 Y155.043 F60000
; LINE_WIDTH: 0.20388
G1 F1869
M204 S8000
G1 X205 Y154.915 E.00208
; LINE_WIDTH: 0.162894
G1 X204.842 Y154.726 E.00243
G2 X204.456 Y154.373 I-2.161 J1.974 E.00517
; LINE_WIDTH: 0.204857
G1 X204.338 Y154.291 E.00191
; WIPE_START
G1 F15000
G1 X204.456 Y154.373 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I-1.132 J-.446 P1  F60000
G1 X202.816 Y158.532 Z16.6
G1 Z16.2
G1 E.4 F1800
; LINE_WIDTH: 0.169728
G1 F1869
M204 S8000
G1 X202.682 Y158.438 E.00171
; LINE_WIDTH: 0.214669
G1 X202.548 Y158.344 E.00231
; LINE_WIDTH: 0.25961
G1 X202.414 Y158.25 E.00292
; LINE_WIDTH: 0.304551
G1 X202.28 Y158.156 E.00353
; LINE_WIDTH: 0.348801
G1 X202.088 Y157.995 E.0063
; LINE_WIDTH: 0.406878
G3 X201.547 Y157.485 I2.646 J-3.348 E.02231
; LINE_WIDTH: 0.392401
G1 X201.386 Y157.293 E.0072
; LINE_WIDTH: 0.348815
G1 X201.225 Y157.102 E.0063
; LINE_WIDTH: 0.304533
G1 X201.132 Y156.968 E.00353
; LINE_WIDTH: 0.259603
G1 X201.038 Y156.834 E.00292
; LINE_WIDTH: 0.214672
G1 X200.944 Y156.7 E.00231
; LINE_WIDTH: 0.169741
G1 X200.85 Y156.565 E.00171
; WIPE_START
G1 F15000
G1 X200.944 Y156.7 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I.424 J1.141 P1  F60000
G1 X204.468 Y155.39 Z16.6
G1 Z16.2
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F1869
M204 S8000
G1 X204.329 Y155.15 E.00858
G1 X204.117 Y154.973 E.00858
G1 X203.858 Y154.878 E.00858
G1 X203.581 Y154.878 E.00858
G1 X203.322 Y154.973 E.00858
G1 X203.11 Y155.15 E.00858
G1 X202.971 Y155.39 E.00859
G1 X202.923 Y155.662 E.00858
G1 X202.972 Y155.934 E.00859
G1 X203.11 Y156.174 E.00858
G1 X203.322 Y156.352 E.00859
G1 X203.581 Y156.446 E.00858
G1 X203.858 Y156.446 E.00858
G1 X204.118 Y156.351 E.00858
G1 X204.329 Y156.174 E.00858
G1 X204.468 Y155.934 E.00859
G1 X204.516 Y155.662 E.00858
G1 X204.478 Y155.449 E.00672
M204 S10000
G1 X203.748 Y155.612 F60000
; LINE_WIDTH: 0.50382
G1 F1869
M204 S8000
M73 P98 R0
G2 X203.746 Y155.712 I-.029 J.049 E.00899
M204 S10000
G1 X203.929 Y156.025 F60000
; LINE_WIDTH: 0.41999
G1 F1869
M204 S8000
G1 X204.088 Y155.875 E.00678
G1 X204.139 Y155.662 E.00679
G1 X204.088 Y155.449 E.00679
G1 X203.929 Y155.299 E.00679
G1 X203.72 Y155.237 E.00678
G1 X203.51 Y155.299 E.00679
G1 X203.351 Y155.449 E.00678
G1 X203.301 Y155.662 E.00679
G1 X203.351 Y155.875 E.00679
G1 X203.51 Y156.025 E.00679
G1 X203.72 Y156.088 E.00678
G1 X203.872 Y156.042 E.00493
; WIPE_START
G1 F15000
G1 X203.72 Y156.088 E-.06031
G1 X203.51 Y156.025 E-.08306
G1 X203.351 Y155.875 E-.0831
G1 X203.301 Y155.662 E-.08313
G1 X203.343 Y155.482 E-.07041
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.6 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z16.6 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; CHANGE_LAYER
; Z_HEIGHT: 16.4
; LAYER_HEIGHT: 0.199999
; layer num/total_layer_count: 82/82
; update layer progress
M73 L82
M991 S0 P81 ;notify layer change
M106 S204
; OBJECT_ID: 202
; COOLING_NODE: 10
G1 X205.787 Y155.662 F60000
G1 Z16.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1200
M204 S5000
G3 X204.429 Y157.612 I-2.078 J.001 E.07851
G3 X204.08 Y153.618 I-.704 J-1.951 E.23554
G3 X205.786 Y155.602 I-.371 J2.045 E.08785
M204 S10000
G1 X205.587 Y155.661 F60000
; FEATURE: Top surface
G1 F1200
M204 S2000
G1 X203.719 Y157.529 E.08199
G1 X203.252 Y157.462
G1 X205.52 Y155.195 E.09954
G1 X205.374 Y154.808
G1 X202.865 Y157.316 E.1101
G1 X202.541 Y157.107
G1 X205.165 Y154.483 E.11519
G1 X204.898 Y154.217
G1 X202.274 Y156.841 E.11519
G1 X202.066 Y156.516
G1 X204.574 Y154.008 E.1101
G1 X204.187 Y153.862
G1 X201.919 Y156.129 E.09954
G1 X201.853 Y155.663
G1 X203.72 Y153.795 E.08198
; WIPE_START
G1 F12000
M204 S8000
G1 X203.013 Y154.502 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.8 I-.621 J1.047 P1  F60000
G1 X205.569 Y156.019 Z16.8
G1 Z16.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.271297
G1 F1200
M204 S8000
G1 X205.451 Y156.188 E.00387
; LINE_WIDTH: 0.30722
G1 X205.333 Y156.356 E.00448
; LINE_WIDTH: 0.343143
G1 X205.215 Y156.525 E.00509
; LINE_WIDTH: 0.37418
G1 X205.118 Y156.64 E.00409
; LINE_WIDTH: 0.408986
G3 X204.812 Y156.964 I-2.006 J-1.586 E.01345
; LINE_WIDTH: 0.400308
G1 X204.697 Y157.061 E.00441
; LINE_WIDTH: 0.374172
G1 X204.583 Y157.157 E.00409
; LINE_WIDTH: 0.343154
G1 X204.414 Y157.275 E.00509
; LINE_WIDTH: 0.307235
G1 X204.245 Y157.393 E.00448
; LINE_WIDTH: 0.271315
G1 X204.077 Y157.511 E.00387
; WIPE_START
G1 F15000
G1 X204.245 Y157.393 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.8 I1.122 J.471 P1  F60000
G1 X205.351 Y154.759 Z16.8
G1 Z16.4
G1 E.4 F1800
; LINE_WIDTH: 0.096363
G1 F1200
M204 S8000
G2 X205.264 Y154.651 I-.653 J.436 E.00061
M204 S10000
G1 X204.731 Y154.118 F60000
; LINE_WIDTH: 0.0963678
G1 F1200
M204 S8000
G2 X204.623 Y154.031 I-.549 J.572 E.00061
; WIPE_START
G1 F15000
G1 X204.731 Y154.118 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.8 I.265 J-1.188 P1  F60000
G1 X203.363 Y153.813 Z16.8
G1 Z16.4
G1 E.4 F1800
; LINE_WIDTH: 0.271216
G1 F1200
M204 S8000
G1 X203.194 Y153.931 E.00387
; LINE_WIDTH: 0.307136
G1 X203.025 Y154.049 E.00448
; LINE_WIDTH: 0.343056
G1 X202.856 Y154.167 E.00509
; LINE_WIDTH: 0.374097
G1 X202.742 Y154.263 E.00409
; LINE_WIDTH: 0.408901
G2 X202.417 Y154.569 I1.586 J2.006 E.01345
; LINE_WIDTH: 0.40022
G1 X202.321 Y154.684 E.00441
; LINE_WIDTH: 0.374084
G1 X202.225 Y154.799 E.00409
; LINE_WIDTH: 0.34307
G1 X202.106 Y154.968 E.00509
; LINE_WIDTH: 0.307144
G1 X201.988 Y155.136 E.00448
; LINE_WIDTH: 0.271217
G1 X201.87 Y155.305 E.00387
; WIPE_START
G1 F15000
G1 X201.988 Y155.136 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z16.8 I1.217 J0 P1  F60000
;===== machine: H2C timelapse =====
;======== date: 20251110 ========

; SKIPPABLE_START
; SKIPTYPE: timelapse

M1002 judge_flag timelapse_record_flag
M622 J1
    M993 A2 B2 C2
    M993 A0 B0 C0

    

    
        M9711 M0 E0 X204 Y240 Z16.8 S11 C10 O0 T3000
    

    
    
    M993 A3 B3 C3
M623
; SKIPPABLE_END

; close powerlost recovery
M1003 S0
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 
;===== machine: H2C end =====
;====== date: 20251111 ======

G392 S0 ;turn off nozzle clog detect
M993 A0 B0 C0 ; nozzle cam detection not allowed.

M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G1 E-0.8 F1800 ; retract
M400
M211 Z1
G1 Z16.8 F900 ; lower z a little
M640.2 R0

M1002 judge_flag timelapse_record_flag
M622 J1
    G150.3
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S5 ;wait for last picture to be taken
M623  ;end of "timelapse_record_flag"

G90
G1 Z26.4 F900 ; lower z a little

G90
M141 S0 ; turn off chamber heating
M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan
M106 P9 S0 ; turn off ext toodhead cooling fan

; pull back filament to AMS
M620 S65535

M620.11 P1 I0 E-14 F623.623



M620.11 K1 I0 R10 F623.623


M620.11 P1 I0 E-14
T65535
G150.2
M621 S65535

M620 S65279
T65279
G150.2
M621 S65279

G150.3

M104 S0 T0; turn off hotend
M104 S0 T1; turn off hotend

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    
        G1 Z108.2 F600
        G1 Z106.2
    

M400 P100
M17 R ; restore z current

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M1015.4 S0 K0 ;disable air printing detect
;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A53 B10 L99 C53 D10 M99 E53 F10 N99 
M1006 A57 B10 L99 C57 D10 M99 E57 F10 N99 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A53 B10 L99 C53 D10 M99 E53 F10 N99 
M1006 A57 B10 L99 C57 D10 M99 E57 F10 N99 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A48 B10 L99 C48 D10 M99 E48 F10 N99 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A60 B10 L99 C60 D10 M99 E60 F10 N99 
M1006 W
;=====printer finish  sound=========
M400
M18

M73 P100 R0
; EXECUTABLE_BLOCK_END

