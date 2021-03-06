library angular.service.filter;

import 'package:di/di.dart';
import 'registry.dart';

/**
 * Use @[NgFilter] annotation to register a new filter. A filter is a class
 * with a [call] method (a callable function).
 *
 * Usage:
 *
 *     // Declaration
 *     @NgFilter(name:'myFilter')
 *     class MyFilter {
 *       call(valueToFilter, optArg1, optArg2) {
 *          return ...;
 *       }
 *     }
 *
 *
 *     // Registration
 *     var module = ...;
 *     module.type(MyFilter);
 *
 *
 *     <!-- Usage -->
 *     <span>{{something | myFilter:arg1:arg2}}</span>
 */
class NgFilter {
  final String name;

  const NgFilter({String this.name});

  int get hashCode => name.hashCode;
  bool operator==(other) => this.name == other.name;

  toString() => 'NgFilter: $name';
}

/**
 * Registry of filters at runtime.
 */
class FilterMap extends AnnotationMap<NgFilter> {
  Injector _injector;
  FilterMap(Injector injector, MetadataExtractor extractMetadata) : super(injector, extractMetadata) {
    this._injector = injector;
  }

  call(String name) {
    var filter = new NgFilter(name:name);
    var filterType = this[filter];
    return _injector.get(filterType);
  }
}

