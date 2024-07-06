function Write-FormatSelectionCondition
{
    <#
    .SYNOPSIS
        Writes a selection condition.
    .DESCRIPTION
        Writes a formatting selection condition.
    .NOTES    
        PowerShell formatting can be conditional.

        A condition is expressed an `<SelectionCondition>` element, which must be inside of an `<EntrySelectedBy>` element..

        Multiple selection conditions are permitted in a single `<EntrySelectedBy>` element.  
        
        They will be evaluated using `-or` (if any of the conditions is true, the formatting will be applied).
    #>
    param(
    # The type name of the selection set.
    [Parameter(ValueFromPipelineByPropertyName)]    
    [string]
    $TypeName,

    # The name of the selection set.
    [Parameter(ValueFromPipelineByPropertyName)]
    [string]
    $SelectionSet,

    # The type names in the selection set.    
    [Alias('SelectionCondition')]
    [ScriptBlock]
    $ScriptBlock
    )

    begin {
        # First, create a queue to hold the selection conditions
        $selectionConditionQueue = [Collections.Queue]::new()
    }
    
    process {
        # Each selection condition is a separate XML element
        $selectionConditionXml = [xml](@(
            "<SelectionCondition>"
                # Consisting of a typename
                if ($TypeName) {
                    if (-not ("<TypeName>$TypeName</TypeName>" -as [xml])) {
                        "<TypeName>$([Security.SecurityElement]::Escape($TypeName))</TypeName>"
                    } else {
                        "<TypeName>$TypeName</TypeName>"
                    }
                }
                # or a selection set name
                elseif ($SelectionSet) {
                    if (-not ("<SelectionSetName>$SelectionSet</SelectionSetName>" -as [xml])) {
                        "<SelectionSetName>$([Security.SecurityElement]::Escape($SelectionSet))</SelectionSetName>"
                    } else {
                        "<SelectionSetName>$SelectionSet</SelectionSetName>"
                    }
                }
                # and a script block.
                # If no `-ScriptBlock` is provided,
                if (-not $ScriptBlock) {
                    # it is assumed to be `$true`.
                    "<ScriptBlock>`$true</ScriptBlock>"
                } else {
                    "<ScriptBlock>$([Security.SecurityElement]::Escape($ScriptBlock))</ScriptBlock>"
                }
            "</SelectionCondition>"
        ) -join '')
        if (-not $selectionConditionXml) { return }
        # Save the XML to a string (for readablility),
        $xOut=[IO.StringWriter]::new()
        $selectionConditionXml.Save($xOut)
        # and add the string to the queue (remove the XML declaration).
        $selectionConditionQueue.Enqueue("$xOut" -replace '\<\?xml.+?\?>[\s\r\n]+')
        $xOut.Dispose()
    }

    end {
        # Finally, create an `<EntrySelectedBy>` element
        $EntrySelectedByXml = @(
            "<EntrySelectedBy>"
            # containing all of the selection conditions
            $selectionConditionQueue.ToArray()
            "</EntrySelectedBy>"
        ) -join '' -as [xml]
        # Save the XML to a string (for readablility),
        $xOut=[IO.StringWriter]::new()
        $EntrySelectedByXml.Save($xOut)
        # and return the string (remove the XML declaration).
        "$xOut" -replace '\<\?xml.+?\?>[\s\r\n]+'
        $xOut.Dispose()
    }
}

