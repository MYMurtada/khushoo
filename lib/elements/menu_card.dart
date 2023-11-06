import 'package:flutter/material.dart';
import 'package:khushoo/elements/constans.dart';

class MenuCard extends StatefulWidget {
  final IconData icon;
  final String label;

  MenuCard({required this.label, required this.icon});

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            clicked = !clicked;
          });
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(
              boxShadow: !clicked
                  ? [
                      BoxShadow(
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: Offset(2, 2),
                      ),
                      BoxShadow(
                          blurRadius: 15,
                          spreadRadius: 1,
                          color: kBackgroundColor,
                          offset: Offset(-2, -2))
                    ]
                  : [],
              color: kElementsColor,
              borderRadius: BorderRadius.circular(20)),
          duration: Duration(milliseconds: 200),
          child: ListTile(
            leading: Icon(
              widget.icon,
              color: kButtonColor,
            ),
            title: Text(
              widget.label,
              style: TextStyle(
                  color: kButtonColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
