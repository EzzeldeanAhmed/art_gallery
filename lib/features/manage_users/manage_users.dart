import 'package:art_gallery/core/services/get_it_service.dart';
import 'package:art_gallery/features/auth/data/models/user_model.dart';
import 'package:art_gallery/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final AuthRepo _userService = getIt.get<AuthRepo>();
  List<UserModel> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final users = await _userService.getUsersData(uids: ["aa"]);
    setState(() {
      _users = users;
      _isLoading = false;
    });
  }

  void _updateUserRole(int index, String newRole) async {
    var user = _users[index];
    user.role = newRole;
    try {
      final response = await _userService.addUser(user);
      _fetchUsers(); // Refresh the list
      setState(() {
        _users[index] = user;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User role updated successfully'),
        ),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update user role'),
        ),
      );
    }
  }

  void _deleteUser(String userId) async {
    try {
      await _userService.deleteUser(userId);
      _fetchUsers(); // Refresh the list
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to delete user')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                UserModel user = _users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text('Role: ${user.role}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton(
                        value: user.role,
                        items: ['admin', 'client'].map((String role) {
                          return DropdownMenuItem(
                              value: role, child: Text(role));
                        }).toList(),
                        onChanged: (String? newRole) {
                          if (newRole != null) {
                            _updateUserRole(index, newRole);
                          }
                        },
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // background color
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete User'),
                                content: Text(
                                    'Are you sure you want to delete this user?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteUser(user.uId);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'Delete',
                            style:
                                TextStyle(color: Colors.white), // text color),
                          )),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
