    <script>
    JSONEditor.defaults.theme = 'bootstrap3';
    JSONEditor.defaults.iconlib = 'fontawesome4';
    </script>

    <script>
      var starting_value = {{ json_string }};
      // Initialize the editor
      var editor = new JSONEditor(document.getElementById('{{ doc_id }}'),{
       schema: {
        //   format: "grid",
           type: "object"
       },
        // Seed the form with a starting value
        startval: starting_value
      });
      
      // Hook up the Restore to Default button
      document.getElementById('restore_json_onbill_general_settings').addEventListener('click',function() {
        editor.setValue(starting_value);
      });
      
      // Hook up the validation indicator to update its 
      // status whenever the editor changes
      editor.on('change',function() {
        // Get an array of errors from the validator
        var errors = editor.validate();
        
        var indicator = document.getElementById('valid_indicator');
        
        // Not valid
        if(errors.length) {
          indicator.className = 'label alert';
          indicator.textContent = 'not valid';
        }
        // Valid
        else {
          indicator.className = 'label success';
          indicator.textContent = 'valid';
        }
      });
    </script>

