Import-TypeView
---------------

### Synopsis
Imports a Type View

---

### Description

Imports a Type View, defined in a external file.

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
|`[String[]]`|true    |1       |true (ByPropertyName)|FullName|

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
Import-TypeView [-FilePath] <String[]> [-Deserialized] [[-Namespace] <String>] [[-Command] <PSObject[]>] [[-ExcludeFilePath] <PSObject[]>] [[-TextFileType] <PSObject[]>] [<CommonParameters>]
```
