import 'package:flutter/material.dart';
import '../../models/bus_stop_modal.dart';
import '../../data/bus_stop_data.dart';

class NearbyStopsSheet extends StatefulWidget {
  final BusStop? selectedBusStop;
  final Function(String route)? onRouteSelected;
  const NearbyStopsSheet({
    super.key,
    this.selectedBusStop,
    this.onRouteSelected,
  });

  @override
  State<NearbyStopsSheet> createState() => _NearbyStopsSheetState();
}

class _NearbyStopsSheetState extends State<NearbyStopsSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  late List<BusStop> _busStops;
  late BusStop _displayedBusStop;
  final Set<String> _selectedRoutes = {};

  @override
  void initState() {
    super.initState();
    _busStops = BusStopData.getAllBusStops();
    _displayedBusStop = widget.selectedBusStop ?? _busStops[0];
    _selectedRoutes.clear();
    // _selectedRoutes.addAll(_displayedBusStop.routes);
  }

  @override
  void didUpdateWidget(NearbyStopsSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedBusStop != oldWidget.selectedBusStop &&
        widget.selectedBusStop != null) {
      setState(() {
        _displayedBusStop = widget.selectedBusStop!;
        _selectedRoutes.clear();
        // _selectedRoutes.addAll(_displayedBusStop.routes);
      });
    }
  }

  void _toggleRoute(String route) {
    setState(() {
      if (_selectedRoutes.contains(route)) {
        _selectedRoutes.remove(route);
      } else {
        _selectedRoutes.add(route);
        widget.onRouteSelected?.call(route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.8,
      controller: _controller,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 8,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                  children: [
                    Text(
                      _displayedBusStop.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _displayedBusStop.routes.map((route) {
                        final isSelected = _selectedRoutes.contains(route);
                        return GestureDetector(
                          onTap: () => _toggleRoute(route),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue[700]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              route,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 32),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Icon(
                                Icons.directions_bus,
                                color: Colors.green[700],
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        '255',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        index == 0
                                            ? 'Galkissa → Kottawa'
                                            : 'Kottawa → Galkissa',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'Next',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        index == 0
                                            ? 'University of Moratuwa'
                                            : 'Piliyandala',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'Stop',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'University',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'ETA ${index == 0 ? '11:21' : '11:39'} am',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
