
scheduler.renderEvent = function(container, ev) {
        var container_width = container.style.width; // e.g. "105px"
         
            // move section
        //     var html = "<div class='dhx_event_move my_event_move' style='width: " + 
        //         container_width + "'></div>";
        //          
        //              // container for event's content
        //                  html+= "<div class='my_event_body'>";
        //                      html += "<span class='event_date'>";
        //                          //two options here:show only start date for short events or start+end for long
        //                              if ((ev.end_date - ev.start_date)/60000>40){//if event is longer than 40 minutes
        //                                      html += scheduler.templates.event_header(ev.start_date, ev.end_date, ev);
        //                                              html += "</span><br/>";
        //                                                  } else {
        //                                                          html += scheduler.templates.event_date(ev.start_date) + "</span>";
        //                                                              }
        //                                                                  // displaying event's text
        //                                                                      html += "<span>" + scheduler.templates.event_text(ev.start_date,ev.end_date,ev)+
        //                                                                          "</span>" + "</div>";
        //                                                                           
        //                                                                               // resize section
        //                                                                                   html += "<div class='dhx_event_resize my_event_resize' style='width: " +
        //                                                                                       container_width + "'></div>";
        //                                                                                        
        //                                                                                            container.innerHTML = html;
        //                                                                                                return true; //required, true - display a custom form, false - the default form
        //                                                                                                };
