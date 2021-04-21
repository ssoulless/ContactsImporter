jQuery(() => {
  $(".upload-contacts-button").on("click", (e) => {
    e.preventDefault();

    $(".submit-contacts").show();

    if (document.getElementById("contacts_file_field").files.length <= 0) {
      alert("Please select a file");
      return;
    }

    const file = document.getElementById("contacts_file_field").files[0];
    let fileHeaders;

    papa.parse(file, {
      header: true,
      error: function (err, file, inputElem, reason) {
        console.log(err, reason);
      },
      complete: function (results) {
        //Sanitize the headers applying trim to remove white spaces
        fileHeaders = results.meta["fields"].map((header) => header.trim());
        console.log("Finished:", fileHeaders.join());
        $.ajax({
          url: "/pre-parse-contacts",
          type: "post",
          data: { file_headers: fileHeaders.join() },
          success() {},
        });
      },
    });
  });

  $("#fields-map-form").on("submit", (e) => {
    e.preventDefault();
    let mappingConfig = {};
    const file = document.getElementById("contacts_file_field").files[0];
    var formData = new FormData();
    formData.append("file", file);
    for (let i = 0; i < $("#fields-map-form select").length; i++) {
      const columnName = $(`#config-mapping-header-${i}`).text();
      const mapValue = $(`#config-mapping-column-${i}`).val();
      mappingConfig[`${columnName}`] = mapValue;
    }

    formData.append("mapping_config", JSON.stringify(mappingConfig));

    $.ajax({
      url: "/import-contacts-submit",
      type: "post",
      data: formData,
      processData: false,
      contentType: false,
      success() {},
      error: (result) => {
        alert("Error:" + result.responseText);
        console.log(result);
      },
    });
  });
});
