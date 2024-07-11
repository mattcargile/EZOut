Write-FormatSelectionCondition
------------------------------

### Synopsis
Writes a selection condition.

---

### Description

Writes a formatting selection condition.

---

### Parameters
#### **TypeName**
The type name of the selection set.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |1       |true (ByPropertyName)|

#### **SelectionSet**
The name of the selection set.

|Type      |Required|Position|PipelineInput        |
|----------|--------|--------|---------------------|
|`[String]`|false   |2       |true (ByPropertyName)|

#### **ScriptBlock**
The type names in the selection set.

|Type           |Required|Position|PipelineInput|Aliases           |
|---------------|--------|--------|-------------|------------------|
|`[ScriptBlock]`|false   |3       |false        |SelectionCondition|

---

### Notes
PowerShell formatting can be conditional.

A condition is expressed an `<SelectionCondition>` element, which must be inside of an `<EntrySelectedBy>` element..

Multiple selection conditions are permitted in a single `<EntrySelectedBy>` element.  

They will be evaluated using `-or` (if any of the conditions is true, the formatting will be applied).

---

### Syntax
```PowerShell
Write-FormatSelectionCondition [[-TypeName] <String>] [[-SelectionSet] <String>] [[-ScriptBlock] <ScriptBlock>] [<CommonParameters>]
```
