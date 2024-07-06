function Write-FormatSelectionSet
{
    <#
    .SYNOPSIS
        Writes a selection set.
    .DESCRIPTION
        Writes a format selection set.
    .NOTES    
        Formatting is commonly selected by a TypeName.
        
        It can also be selected by a group of type names, which is called a SelectionSet.

        A few built-in formatters use selection sets, most notably the filesystem formatters.
    .EXAMPLE
        Write-FormatSelectionSet -Name 'FileSystemTypes' -TypeName 'System.IO.DirectoryInfo', 'System.IO.FileInfo'    
    #>
    param(
    # The name of the selection set.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [Alias('SelectionSetName','SelectionSet')]
    [string]
    $Name,

    # The type names in the selection set.
    [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
    [string[]]
    $TypeName
    )

    begin {
        # First, create a queue to hold the selection sets.
        $eachSelectionSet = [Collections.Queue]::new()
    }
    
    process {
        # Make sure the name and type names are XML-safe
        $NameAsXml = "<Name>$Name</Name>" -as [xml]
        if (-not $NameAsXml) {
            $Name = [Security.SecurityElement]::Escape($Name)
        }
        $TypeName = foreach ($tn in $TypeName) {
            if (-not ("<TypeName>$tn</TypeName>" -as [xml])) {
                [Security.SecurityElement]::Escape($tn)
            } else {
                $tn
            }
        }

        # Create the selection set XML
        $selectionSetXml = [xml](@(
            "<SelectionSet>"
                # Consisting of a `<Name>`
                "<Name>$Name</Name>"                
                "<Types>" # and a `<Types>` element
                    foreach ($tn in $TypeName) {
                        # (containing each `<TypeName>`)
                        "<TypeName>$tn</TypeName>"
                    }
                "</Types>"
            "</SelectionSet>"
        ) -join '')
        if (-not $selectionSetXml) { return }
        $xOut=[IO.StringWriter]::new()
        $selectionSetXml.Save($xOut)
        $eachSelectionSet.Enqueue("$xOut" -replace '\<\?xml.+?\?>[\s\r\n]+')
        $xOut.Dispose()
    }

    end {
        # Create the `<SelectionSets>` element
        $selectionSetXml = @(
            "<SelectionSets>"
            # (containing each `<SelectionSet>`)
            $eachSelectionSet.ToArray()
            "</SelectionSets>"
        ) -join '' -as [xml]
        $xOut=[IO.StringWriter]::new()
        $selectionSetXml.Save($xOut)
        # Write the XML to the pipeline as a string, removing the XML declaration.
        "$xOut" -replace '\<\?xml.+?\?>[\s\r\n]+'
        $xOut.Dispose()
    }
}
