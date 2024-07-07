Import-TypeView
---------------

### Synopsis
Imports Type Views

---

### Description

Imports one or more Type Views from a directory (and an optional list of commands).

This creates a .types.ps1xml file that can be used to extend the type system of PowerShell.

Each file in the directory will be treated as a property or method of a type.

---

### Related Links
* [Write-TypeView](Write-TypeView.md)

---

### Examples
> EXAMPLE 1

```PowerShell
Import-TypeView .\Types
```

---

### Parameters
#### **FilePath**
The path containing type information.

|Type        |Required|Position|PipelineInput        |Aliases |
|------------|--------|--------|---------------------|--------|
|`[String[]]`|false   |1       |true (ByPropertyName)|FullName|

#### **Deserialized**
If set, will generate an identical typeview for the deserialized form of each typename.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[Switch]`|false   |named   |true (ByPropertyName)|

#### **Namespace**
The namespace to use for all imported types.
This will be prepended to the type name, and followed by a period.

|Type      |Required|Position|PipelineInput        |Aliases|
|----------|--------|--------|---------------------|-------|
|`[String]`|false   |2       |true (ByPropertyName)|Prefix |

#### **Command**
Any number of commands to import.
These commands will converted into ScriptMethods.
Each ScriptMethod will it's original command name, within the typename `Commands`.
(if -Namespace is provided, the namespace will be prepended to the typename)
(only functions are currently supported)

|Type          |Required|Position|PipelineInput        |Aliases |
|--------------|--------|--------|---------------------|--------|
|`[PSObject[]]`|false   |3       |true (ByPropertyName)|Commands|

#### **ExcludeFilePath**
Any file paths to exclude.

|Type          |Required|Position|PipelineInput        |
|--------------|--------|--------|---------------------|
|`[PSObject[]]`|false   |4       |true (ByPropertyName)|

#### **TextFileType**
A pattern describing the types of files that will embedded as constant note properties containing the file's text.

|Type          |Required|Position|PipelineInput        |Aliases        |
|--------------|--------|--------|---------------------|---------------|
|`[PSObject[]]`|false   |5       |true (ByPropertyName)|TextFilePattern|

---

### Syntax
```PowerShell
Import-TypeView [[-FilePath] <String[]>] [-Deserialized] [[-Namespace] <String>] [[-Command] <PSObject[]>] [[-ExcludeFilePath] <PSObject[]>] [[-TextFileType] <PSObject[]>] [<CommonParameters>]
```
