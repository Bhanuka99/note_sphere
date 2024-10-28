import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notesphere/models/note_model.dart';
import 'package:notesphere/pages/create_new_note.dart';
import 'package:notesphere/pages/edit_note_page.dart';
import 'package:notesphere/pages/home_page.dart';
import 'package:notesphere/pages/note_by_category_page.dart';
import 'package:notesphere/pages/notes_page.dart';
import 'package:notesphere/pages/todo_page.dart';

class AppRouter{
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: false,
    initialLocation: "/",
    routes: [
      //homepage
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return const HomePage();
        },
      ),
      
      //notes page
      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state){
          return const NotesPage();
        },
      ),
      //todo page
      GoRoute(
        name: "todos",
        path: "/todos",
        builder: (context, state){
          return const TodoPage();
        },
      ),
      //note by category page
      GoRoute(
        name: "category",
        path: "/category",
        builder: (context, state){
          final String category = state.extra as String;
          return NoteByCategoryPage(category: category);
        },
      ),
      //create new note
      GoRoute(
        name: "create-note",
        path: "/create-note",
        builder: (context, state){
          final isNewCategoryPage = state.extra as bool;
          return CreateNewNote(isNewCategory: isNewCategoryPage);
        },
      ),
      //edit page
      GoRoute(
        name: "edit note",
        path: "/edit-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return EditNotePage(note: note,);
        },
      )
    ]
  );
}