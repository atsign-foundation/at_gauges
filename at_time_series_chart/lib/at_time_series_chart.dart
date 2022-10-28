library at_time_series_chart;

import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'src/bar_chart.dart';

/// State
part 'src/model/chart_state.dart';

/// Data
part 'src/model/data/chart_data.dart';

/// Geometries
part 'src/model/geometry/bar_value_item.dart';

// part 'chart/model/geometry/bubble_value_item.dart';
// part 'chart/model/geometry/candle_value_item.dart';
part 'src/model/geometry/chart_item.dart';

/// Theme
part 'src/model/theme/chart_behaviour.dart';

part 'src/model/theme/item_theme/bar_item_options.dart';

part 'src/model/theme/item_theme/item_options.dart';

part 'src/model/theme/item_theme/line_item_options.dart';

/// Render
part 'src/render/chart_renderer.dart';

// Data renderers
part 'src/render/data_renderer/chart_data_renderer.dart';

part 'src/render/data_renderer/chart_linear_data_renderer.dart';

// Decoration painters
// part 'chart/render/decorations/border_decoration.dart';
part 'src/render/decorations/decoration_painter.dart';

part 'src/render/decorations/grid_decoration.dart';

part 'src/render/decorations/horizontal_axis_decoration.dart';

// part 'chart/render/decorations/renderer/chart_decoration_child_renderer.dart';
part 'src/render/decorations/renderer/chart_decoration_renderer.dart';

// part 'chart/render/decorations/selected_item_decoration.dart';
part 'src/render/decorations/spark_line_decoration.dart';

// part 'src/render/decorations/target_decoration.dart';
// part 'chart/render/decorations/target_legends_decoration.dart';
part 'src/render/decorations/value_decoration.dart';

part 'src/render/decorations/vertical_axis_decoration.dart';

part 'src/render/decorations_renderer.dart';

// Geometry painters
part 'src/render/geometry/leaf_item_renderer.dart';

part 'src/render/geometry/painters/bar_geometry_painter.dart';

part 'src/render/geometry/painters/bubble_geometry_painter.dart';

part 'src/render/geometry/painters/geometry_painter.dart';

// Utils
part 'src/render/utils/dashed_path_util.dart';

/// Widgets
part 'src/widget/animated_chart.dart';

part 'src/widget/chart_widget.dart';
