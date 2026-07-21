# Screen — Document Vault & Form Screens

## Purpose

Provides a searchable folder grid of uploaded files (Vault view) and attachment forms (Form view) to link stencils or waivers to clients.

## Widgets

### 1. Document Vault Screen

* **File Grid/List**: Cards representing uploaded documents. Displays file title, creation timestamp, and format symbols (e.g., PDF or Image thumbnails).
* **Search Input Bar**: Real-time filtering by document title.

### 2. Document Upload Form Screen

* **File Selector Area**: Drag-and-drop zone to select a local system file.
* **Metadata Fields**: Text inputs for custom document titles and client selectors.
* **"Inscribe Treaty" Button**: Commits upload operations.

## Inputs

* File bytes and metadata title parameters.

## Outputs

* Persists file paths and metadata rows in local SQLite tables.

## Navigation

* `/documents` → `/documents/new` (launching form).

## Uses Classes

* **Document** ([Document](../classes/document.md)): Active metadata model.
* **Client** ([Client](../classes/client.md)): Target parent link.

## States

* **Uploading**: Displays progress percentage bars.
* **Active**: Directory lists documents.
* **Empty State**: Displays clear placeholders on empty directories ("The document vault stands silent...").
* **Error State**: Flags missing local binaries or failed file locks.
