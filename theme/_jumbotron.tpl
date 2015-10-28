<!--jumbotron /slideshow--> 
 {if !empty($slide)}
                    <div class="jumbotron well well-lg img-rounded">
                        <div id="carousel-generic" class="carousel slide " data-ride="carousel">
                          <!-- Indicators -->

                          <!-- Wrapper for slides -->
                          <div class="carousel-inner" role="listbox">
                          {foreach from=$slide item=jumbotron}

                            <div class="item {($jumbotron@first) ? 'active' : ''} ">
                              <img src="{$jumbotron->linkphoto}" alt="{$jumbotron->judul}" class="img-responsive center-block img-thumbnail">
                              <div class="carousel-caption">
                               <h3>{$jumbotron->judul|unescape:'htmlall'|capitalize:true}</h3>
                               {assign var=readMoreText value=" ... <a href='{$SCRIPT_NAME}?j={$jumbotron->id}'><strong> Baca.... </strong></a>"} 
                               <p>{$jumbotron->konten|unescape:'htmlall'}<p>
                              </div>
                            </div>              
                          
                          {/foreach}
                        </div>

                          <!-- Controls -->
                          <a class="left carousel-control" href="#carousel-generic" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                          </a>
                          <a class="right carousel-control" href="#carousel-generic" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                          </a>
                        </div>                       
                    </div><br>
{/if}
<!--/jumbotron--> 