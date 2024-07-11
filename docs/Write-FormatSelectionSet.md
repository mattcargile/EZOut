Write-FormatSelectionSet
------------------------

### Synopsis
Writes a selection set.

---

### Description

Writes a format selection set.

---

### Examples
> EXAMPLE 1

```PowerShell
Write-FormatSelectionSet -Name 'FileSystemTypes' -TypeName 'System.IO.DirectoryInfo', 'System.IO.FileInfo'
```

---

### Parameters
#### **Name**
The name of the selection set.

|Type      |Required|Position|PipelineInput        |Aliases                          |
|----------|--------|--------|---------------------|---------------------------------|
|`[String]`|true    |1       |true (ByPropertyName)|SelectionSetName<br/>SelectionSet|

#### **TypeName**
The type names in the selection set.

|Type        |Required|Position|PipelineInput        |
|------------|--------|--------|---------------------|
|`[String[]]`|true    |2       |true (ByPropertyName)|

---

### Notes
Formatting is commonly selected by a TypeName.

It can also be selected by a group of type names, which is called a SelectionSet.

A few built-in formatters use selection sets, most notably the filesystem formatters.

---

### Syntax
```PowerShell
Write-FormatSelectionSet [-Name] <String> [-TypeName] <String[]> [<CommonParameters>]
```
